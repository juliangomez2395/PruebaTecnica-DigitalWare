unit UCrudProductos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, Buttons, ExtCtrls, DB, ADODB;

type
  TFrmCrudProductos = class(TForm)
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
    Edit2: TEdit;
    Edit3: TEdit;
    BitBtn5: TBitBtn;
    GroupBox3: TGroupBox;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    QryProductosCreados: TADOQuery;
    QryProductosCreadosPRODUCTO: TIntegerField;
    QryProductosCreadosNOMBRE_PRODUCTO: TStringField;
    QryProductosCreadosVALOR: TFloatField;
    QryCrudProductos: TADOQuery;
    QryConsultaProductos: TADOQuery;
    QryConsultaProductosPRODUCTO: TIntegerField;
    QryConsultaProductosNOMBRE_PRODUCTO: TStringField;
    QryConsultaProductosVALOR: TFloatField;
    QryCrudProductosPRODUCTO: TIntegerField;
    QryCrudProductosNOMBRE_PRODUCTO: TStringField;
    QryCrudProductosVALOR: TFloatField;
    procedure Edit1Exit(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Edit3KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit2Exit(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCrudProductos: TFrmCrudProductos;

implementation

uses UDataModul, UCrudClientes;

{$R *.dfm}

procedure TFrmCrudProductos.Edit1Exit(Sender: TObject);
begin
   IF trim(Edit1.Text) <> EmptyStr THEN
  /// /////// VALIDACION SOLO ACEPTA VALORES NUMERICOS //////////
  BEGIN
    IF STRTOINT64DEF(trim(Edit1.Text), 123456789) = 123456789 THEN
    BEGIN
      application.MessageBox(pchar('El campo debe ser numerico. '),
        pchar('Información'), (MB_OK + MB_ICONEXCLAMATION));
      Edit1.SetFocus;
      Edit1.Text := EmptyStr;
      exit;
    END;

    DataModule1 := TDataModule1.create(application);
    QryConsultaProductos.Close;
    QryConsultaProductos.SQL.Clear;
    QryConsultaProductos.SQL.Add('SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED ' +
      'select * from PRODUCTOS WHERE PRODUCTO =:PRODUCTO  ');
    QryConsultaProductos.Parameters[0].Value := trim(Edit1.Text);
    QryConsultaProductos.Open;

    if QryConsultaProductos.RecordCount = 0 then
    begin

      BitBtn2.Enabled := true;
      // BitBtn3.Enabled:=TRUE;
      // BitBtn4.Enabled:=TRUE;

    end
    else
    begin

      Edit2.Text := QryConsultaProductosNOMBRE_PRODUCTO.AsString;
      Edit3.Text := CurrToStr(QryConsultaProductosVALOR.value);
      // BitBtn2.Enabled:=TRUE;
      BitBtn3.Enabled := true;
      BitBtn4.Enabled := true;

    end;

  END;


end;

procedure TFrmCrudProductos.FormActivate(Sender: TObject);
begin
  top := 20;


  DataModule1 := TDataModule1.create(application);
  DataModule1.conexionSqlServer();
  QryProductosCreados.Active := true;
end;

procedure TFrmCrudProductos.FormCreate(Sender: TObject);
begin
  DataModule1 := TDataModule1.create(application);
  DataModule1.conexionSqlServer();

end;

procedure TFrmCrudProductos.Edit3KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  numero: extended;
  numerox:string;

begin

  if Length(Edit3.Text) >2 then
    BEGIN
     // QUITA LOS PUNTOS PARA CONVERTIR A FLOTANTE
     numerox:= StringReplace(Edit3.Text, '.', '', [rfReplaceAll]);
     numerox:= StringReplace(numerox, ',', '', [rfReplaceAll]);
     numero := StrToFloat(numerox);
     Edit3.Text := FloatToStrf(numero, ffNumber, 15, 0);
     // POSICIONA EL CURSOR EN LA ULTIMA POSICION DEL EDIT
     Edit3.SelStart := Length(Edit3.Text);

    end;

end;

procedure TFrmCrudProductos.Edit2Exit(Sender: TObject);
var
  i:integer;
begin
  if trim(Edit2.Text)<>EmptyStr then
  begin
     FOR i := 1 TO Length(Edit2.Text) DO
    BEGIN
      IF ((Edit2.Text[i] = '1') OR (Edit2.Text[i] = '2') OR (Edit2.Text[i] = '3')
        OR (Edit2.Text[i] = '4') OR (Edit2.Text[i] = '5') OR (Edit2.Text[i] = '6')
        OR (Edit2.Text[i] = '7') OR (Edit2.Text[i] = '8') OR (Edit2.Text[i] = '9')
        OR (Edit2.Text[i] = '0')) THEN
      BEGIN

        application.MessageBox(pchar('Este campo no debe contener numeros. '),
          pchar('Nombre no valido'), (MB_OK + MB_ICONERROR));
        Edit2.SetFocus;
        Edit2.Text := EmptyStr;
        exit;
      END;
    END;
  end;

end;

procedure TFrmCrudProductos.BitBtn2Click(Sender: TObject);
begin
if (Edit1.Text = EmptyStr) or (Edit2.Text = EmptyStr) or
    (Edit3.Text = EmptyStr) then
  begin

    application.MessageBox(pchar('Por favor diligenciar todos los campos. '),
      pchar('Informacion'), (MB_OK + MB_ICONEXCLAMATION));

    exit;

  end;

  TRY
    QryCrudProductos.Close;
    QryCrudProductos.SQL.Clear;
    QryCrudProductos.SQL.Add('SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED ' +
      'select * from PRODUCTOS WHERE PRODUCTO =:PRODUCTO  ');
    QryCrudProductos.Parameters[0].Value := trim(Edit1.Text);
    QryCrudProductos.Open;

    if QryCrudProductos.RecordCount = 0 then
    begin

      QryCrudProductos.Insert;

      QryCrudProductosPRODUCTO.Value := StrToInt(trim(Edit1.Text));
      QryCrudProductosNOMBRE_PRODUCTO.Value := trim(Edit2.Text);
      QryCrudProductosVALOR.Value := StrToFloat(StringReplace(trim(Edit3.Text), '.', '', [rfReplaceAll]));

      QryCrudProductos.Post;

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

procedure TFrmCrudProductos.BitBtn5Click(Sender: TObject);
begin
 Close();
  FrmCrudProductos := TFrmCrudProductos.create(application);
  FrmCrudProductos.Show;
end;

procedure TFrmCrudProductos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:=caFree;
end;

procedure TFrmCrudProductos.BitBtn3Click(Sender: TObject);
begin
  if (Edit1.Text = EmptyStr) or (Edit2.Text = EmptyStr) or
    (Edit3.Text = EmptyStr) then
  begin

    application.MessageBox(pchar('Por favor diligenciar todos los campos. '),
      pchar('Información'), (MB_OK + MB_ICONEXCLAMATION));

    exit;

  end;

  TRY
    QryCrudProductos.Close;
    QryCrudProductos.SQL.Clear;
    QryCrudProductos.SQL.Add('SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED ' +
      'select * from PRODUCTOS WHERE PRODUCTO =:PRODUCTO  ');
    QryCrudProductos.Parameters[0].Value := trim(Edit1.Text);
    QryCrudProductos.Open;

    if QryCrudProductos.RecordCount > 0 then
    begin

      QryCrudProductos.edit;

      QryCrudProductosPRODUCTO.Value := StrToInt(trim(Edit1.Text));
      QryCrudProductosNOMBRE_PRODUCTO.Value := trim(Edit2.Text);
      QryCrudProductosVALOR.Value := StrToFloat(StringReplace(trim(Edit3.Text), '.', '', [rfReplaceAll]));

      QryCrudProductos.Post;

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

procedure TFrmCrudProductos.BitBtn4Click(Sender: TObject);
begin

 if (Edit1.Text = EmptyStr) or (Edit2.Text = EmptyStr) or
    (Edit3.Text = EmptyStr) then
  begin

    application.MessageBox(pchar('Por favor diligenciar todos los campos. '),
      pchar('Información'), (MB_OK + MB_ICONEXCLAMATION));

    exit;

  end;

  TRY
    QryCrudProductos.Close;
    QryCrudProductos.SQL.Clear;
    QryCrudProductos.SQL.Add('SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED ' +
      'select * from PRODUCTOS WHERE PRODUCTO =:PRODUCTO  ');
    QryCrudProductos.Parameters[0].Value := trim(Edit1.Text);
    QryCrudProductos.Open;

    if QryCrudProductos.RecordCount > 0 then
    begin

      QryCrudProductos.Close;
      QryCrudProductos.SQL.Clear;
      QryCrudProductos.SQL.Add('DELETE from PRODUCTOS WHERE PRODUCTO=:PRODUCTO ');
      QryCrudProductos.Parameters[0].Value := trim(Edit1.Text);
      QryCrudProductos.ExecSQL;

      application.MessageBox(pchar('Registro Eliminado con exito. '),
        pchar('Información'), (MB_OK + MB_ICONINFORMATION));

      BitBtn5Click(self);

    end;
  EXCEPT
    ON E: Exception do
      application.MessageBox(pchar('No se pudo Eliminar el registro ' +
        E.Message), pchar('Información '), MB_OK + MB_ICONINFORMATION);
  END;
  
end;

procedure TFrmCrudProductos.DBGrid1DblClick(Sender: TObject);
begin
  Edit1.Text := DBGrid1.Fields[0].AsString;
  Edit1Exit(self);
end;

procedure TFrmCrudProductos.BitBtn1Click(Sender: TObject);
begin
    if Edit1.Text=EmptyStr  then
  begin

    application.MessageBox(pchar('Por favor Digitar No. Producto. '),
      pchar('Información'), (MB_OK + MB_ICONEXCLAMATION));
      Edit1.SetFocus;

    exit;

  end;
end;

end.
