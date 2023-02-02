unit UCrudCabezaFactura;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, Buttons, ExtCtrls, ComCtrls, DBCtrls,
  DB, ADODB;

type
  TFrmCrudCabezaFactura = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Image1: TImage;
    GroupBox2: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    Edit1: TEdit;
    BitBtn5: TBitBtn;
    GroupBox3: TGroupBox;
    DBGrid1: TDBGrid;
    Label5: TLabel;
    QryCabezaFacturaCreados: TADOQuery;
    DtsCabezaFacturaCreados: TDataSource;
    DBLookupComboBox1: TDBLookupComboBox;
    DateTimePicker1: TDateTimePicker;
    Edit2: TEdit;
    QryCrudCabezaFactura: TADOQuery;
    QryClientes: TADOQuery;
    DtsClientes: TDataSource;
    QryClientesCLIENTE: TIntegerField;
    QryClientesNOMBRE_CLIENTE: TStringField;
    QrySaldo: TADOQuery;
    QrySaldototal: TFloatField;
    QryCrudCabezaFacturaNUMERO: TIntegerField;
    QryCrudCabezaFacturaFECHA: TDateTimeField;
    QryCrudCabezaFacturaCLIENTE: TIntegerField;
    QryCrudCabezaFacturaTOTAL: TFloatField;
    QryCabezaFacturaCreadosNUMERO: TIntegerField;
    QryCabezaFacturaCreadosFECHA: TDateTimeField;
    QryCabezaFacturaCreadosCLIENTE: TIntegerField;
    QryCabezaFacturaCreadosTOTAL: TFloatField;
    procedure FormActivate(Sender: TObject);
    procedure Edit1Exit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCrudCabezaFactura: TFrmCrudCabezaFactura;

implementation

uses UDataModul, UCrudClientes;

{$R *.dfm}

procedure TFrmCrudCabezaFactura.FormActivate(Sender: TObject);
begin
   top := 20;


  DataModule1 := TDataModule1.create(application);
  DataModule1.conexionSqlServer();
  QryCabezaFacturaCreados.Active := true;
  QryClientes.Active:=true;
end;

procedure TFrmCrudCabezaFactura.Edit1Exit(Sender: TObject);
begin
   IF trim(Edit1.Text) <> EmptyStr THEN
  /// /////// VALIDACION SOLO ACEPTA VALORES NUMERICOS //////////
  BEGIN
    IF STRTOINT64DEF(trim(Edit1.Text), 123456789) = 123456789 THEN
    BEGIN
      application.MessageBox(pchar('El campo debe ser numerico. '),
        pchar('Horas Trabajadas'), (MB_OK + MB_ICONEXCLAMATION));
      Edit1.SetFocus;
      Edit1.Text := EmptyStr;
      exit;
    END;
    DataModule1 := TDataModule1.create(application);
    QryCrudCabezaFactura.Close;
    QryCrudCabezaFactura.SQL.Clear;
    QryCrudCabezaFactura.SQL.Add('SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED ' +
      'select * from CABEZA_FACTURA WHERE NUMERO=:NUMERO  ');
    QryCrudCabezaFactura.Parameters[0].Value := trim(Edit1.Text);
    QryCrudCabezaFactura.Open;

    if QryCrudCabezaFactura.RecordCount = 0 then
    begin
      Edit2.Text:='0';
      BitBtn2.Enabled := true;
      // BitBtn3.Enabled:=TRUE;
      // BitBtn4.Enabled:=TRUE;

    end
    else
    begin


      DateTimePicker1.Date := QryCrudCabezaFacturaFECHa.Value;
      DBLookupComboBox1.KeyValue := QryCrudCabezaFacturaCLIENTE.AsString;
      Edit2.Text := CurrToStr(QryCrudCabezaFacturaTOTAL.value);
      // BitBtn2.Enabled:=TRUE;
      BitBtn3.Enabled := true;
      BitBtn4.Enabled := true;

    end;

  END;
end;

procedure TFrmCrudCabezaFactura.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
Action:= caFree;
end;

procedure TFrmCrudCabezaFactura.BitBtn5Click(Sender: TObject);
begin
  Close();
  FrmCrudCabezaFactura := TFrmCrudCabezaFactura.create(application);
  FrmCrudCabezaFactura.Show;
end;

procedure TFrmCrudCabezaFactura.BitBtn2Click(Sender: TObject);
begin
  if (Edit1.Text = EmptyStr) or (Edit2.Text = EmptyStr) or
    (DBLookupComboBox1.Text = EmptyStr) then
  begin

    application.MessageBox(pchar('Por favor diligenciar todos los campos. '),
      pchar('Informacion'), (MB_OK + MB_ICONEXCLAMATION));

    exit;

  end;

  TRY
   QryCrudCabezaFactura.Close;
    QryCrudCabezaFactura.SQL.Clear;
    QryCrudCabezaFactura.SQL.Add('SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED ' +
      'select * from CABEZA_FACTURA WHERE NUMERO =:NUMERO  ');
    QryCrudCabezaFactura.Parameters[0].Value := trim(Edit1.Text);
    QryCrudCabezaFactura.Open;

    if QryCrudCabezaFactura.RecordCount = 0 then
    begin

      QryCrudCabezaFactura.Insert;

      QryCrudCabezaFacturaNUMERO.Value := StrToInt(trim(Edit1.Text));
      QryCrudCabezaFacturaFECHA.Value := DateTimePicker1.DateTime;
      QryCrudCabezaFacturaCLIENTE.Value := DBLookupComboBox1.KeyValue;
      QryCrudCabezaFacturaTOTAL.Value := StrToFloat(StringReplace(trim(Edit2.Text), '.', '', [rfReplaceAll]));

      QryCrudCabezaFactura.Post;

      application.MessageBox(pchar('Registro guardado con exito. '),
        pchar('Información'), (MB_OK + MB_ICONINFORMATION));

      BitBtn5Click(self);

    end;
  EXCEPT
    ON E: Exception do
      application.MessageBox(pchar('No se pudo Guardar el registro ' +
        E.Message), pchar('Información '), MB_OK + MB_ICONINFORMATION);
  END;
end;

procedure TFrmCrudCabezaFactura.BitBtn1Click(Sender: TObject);
begin
  if Edit1.Text=EmptyStr  then
  begin

    application.MessageBox(pchar('Por favor Digitar El numero de la Factura '),
      pchar('Información'), (MB_OK + MB_ICONEXCLAMATION));
      Edit1.SetFocus;

    exit;

  end;
end;

procedure TFrmCrudCabezaFactura.BitBtn3Click(Sender: TObject);
begin
  if (Edit1.Text = EmptyStr) or (Edit2.Text = EmptyStr) or
    (DBLookupComboBox1.Text = EmptyStr) then
  begin

    application.MessageBox(pchar('Por favor diligenciar todos los campos. '),
      pchar('Informacion'), (MB_OK + MB_ICONEXCLAMATION));

    exit;

  end;

  TRY
    QryCrudCabezaFactura.Close;
    QryCrudCabezaFactura.SQL.Clear;
    QryCrudCabezaFactura.SQL.Add('SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED ' +
      'select * from CABEZA_FACTURA  WHERE NUMERO =:NUMERO  ');
    QryCrudCabezaFactura.Parameters[0].Value := trim(Edit1.Text);
    QryCrudCabezaFactura.Open;

    if QryCrudCabezaFactura.RecordCount > 0 then
    begin

      QryCrudCabezaFactura.edit;

      QryCrudCabezaFacturaNUMERO.Value := StrToInt(trim(Edit1.Text));
      QryCrudCabezaFacturaFECHA.Value := DateTimePicker1.Date;
      QryCrudCabezaFacturaCLIENTE.Value := DBLookupComboBox1.KeyValue;
      

      QryCrudCabezaFactura.Post;

      application.MessageBox(pchar('Registro Modificado con exito. '),
        pchar('Información'), (MB_OK + MB_ICONINFORMATION));

      BitBtn5Click(self);

    end;
  EXCEPT
    ON E: Exception do
      application.MessageBox(pchar('No se pudo Modificar el registro ' +
        E.Message), pchar('Información '), MB_OK + MB_ICONINFORMATION);
  END;
end;

procedure TFrmCrudCabezaFactura.DBGrid1DblClick(Sender: TObject);
begin
Edit1.Text := DBGrid1.Fields[0].AsString;
  Edit1Exit(self);
end;

procedure TFrmCrudCabezaFactura.BitBtn4Click(Sender: TObject);
begin
    if (Edit1.Text = EmptyStr) or (Edit2.Text = EmptyStr) or
    (DBLookupComboBox1.Text = EmptyStr) then
  begin

    application.MessageBox(pchar('Por favor diligenciar todos los campos. '),
      pchar('Informacion'), (MB_OK + MB_ICONEXCLAMATION));

    exit;

  end;

    TRY
      QryCrudCabezaFactura.Close;
      QryCrudCabezaFactura.SQL.Clear;
      QryCrudCabezaFactura.SQL.Add('SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED ' +
        'select * from CABEZA_FACTURA WHERE NUMERO =:NUMERO  ');
      QryCrudCabezaFactura.Parameters[0].Value := trim(Edit1.Text);
      QryCrudCabezaFactura.Open;

      if QryCrudCabezaFactura.RecordCount > 0 then
      begin

        QryCrudCabezaFactura.Close;
        QryCrudCabezaFactura.SQL.Clear;
        QryCrudCabezaFactura.SQL.Add('DELETE FROM CABEZA_FACTURA WHERE NUMERO=:NUMERO ');
        QryCrudCabezaFactura.Parameters[0].Value := trim(Edit1.Text);
        QryCrudCabezaFactura.ExecSQL;

        application.MessageBox(pchar('Registro Eliminado con exito. '),
          pchar('Información'), (MB_OK + MB_ICONINFORMATION));

        BitBtn5Click(self);

      end;
  EXCEPT
    ON E: Exception do
      application.MessageBox(pchar('No se pudo Eliminar el registro ' +
        E.Message), pchar('Información '), MB_OK + MB_ICONINFORMATION);
  END;
  END;

end.
