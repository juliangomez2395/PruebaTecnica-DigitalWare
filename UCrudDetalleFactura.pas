unit UCrudDetalleFactura;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, Buttons, ExtCtrls, DBCtrls, DB, ADODB;

type
  TFrmCrudDetalleFactura = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Image1: TImage;
    GroupBox2: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    Edit3: TEdit;
    BitBtn5: TBitBtn;
    GroupBox3: TGroupBox;
    DBGrid1: TDBGrid;
    Edit2: TEdit;
    DBLookupComboBox1: TDBLookupComboBox;
    QryProdcuto: TADOQuery;
    DtsProducto: TDataSource;
    QryDetalleFacturaCreados: TADOQuery;
    DtsDetalleFacturaCreados: TDataSource;
    QryConsultaDetalleFactura: TADOQuery;
    QryConsultaDetalleFacturaNUMERO: TIntegerField;
    QryConsultaDetalleFacturaPRODUCTO: TIntegerField;
    QryConsultaDetalleFacturaNOMBRE_PRODUCTO: TStringField;
    QryConsultaDetalleFacturaCANTIDAD: TIntegerField;
    QryConsultaDetalleFacturaTOTAL: TFloatField;
    QryTraerValorProducto: TADOQuery;
    QryTraerValorProductovalor: TFloatField;
    QryCrudDetalleFactura: TADOQuery;
    QryCrudDetalleFacturaNUMERO: TIntegerField;
    QryCrudDetalleFacturaPRODUCTO: TIntegerField;
    QryCrudDetalleFacturaCANTIDAD: TIntegerField;
    QryCrudDetalleFacturaVALOR: TFloatField;
    DBLookupComboBox2: TDBLookupComboBox;
    QryNumero: TADOQuery;
    DtsNumero: TDataSource;
    QryProdcutoPRODUCTO: TIntegerField;
    QryProdcutoNOMBRE_PRODUCTO: TStringField;
    QryDetalleFacturaCreadosNUMERO: TIntegerField;
    QryDetalleFacturaCreadosNOMBRE_PRODUCTO: TStringField;
    QryDetalleFacturaCreadosCANTIDAD: TIntegerField;
    QryDetalleFacturaCreadosVALOR: TFloatField;
    QryNumeroNUMERO: TIntegerField;
    QryNumeroFACTURA: TStringField;
    QryValorCabezaFactura: TADOQuery;
    IntegerField1: TIntegerField;
    IntegerField2: TIntegerField;
    StringField1: TStringField;
    IntegerField3: TIntegerField;
    FloatField1: TFloatField;
    procedure BitBtn5Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    
    procedure Edit3Change(Sender: TObject);
    procedure Edit3Exit(Sender: TObject);
    procedure Edit2KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBLookupComboBox1Exit(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCrudDetalleFactura: TFrmCrudDetalleFactura;
  //Globales
  numeroFactura:Currency;
  producto:Currency;
  cantidad:Currency;
  valor:Currency;


implementation

uses UDataModul;

{$R *.dfm}

procedure TFrmCrudDetalleFactura.BitBtn5Click(Sender: TObject);
begin
Close();
  FrmCrudDetalleFactura := TFrmCrudDetalleFactura.create(application);
  FrmCrudDetalleFactura.Show;
end;

procedure TFrmCrudDetalleFactura.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:=caFree;
end;

procedure TFrmCrudDetalleFactura.BitBtn1Click(Sender: TObject);
begin
    if DBLookupComboBox2.Text=EmptyStr  then
  begin

    application.MessageBox(pchar('Por favor Digitar No. Detalle Factura. '),
      pchar('Información'), (MB_OK + MB_ICONEXCLAMATION));
      DBLookupComboBox2.SetFocus;

    exit;

  end;

  QryDetalleFacturaCreados.close;
  QryDetalleFacturaCreados.SQL.Clear;
  QryDetalleFacturaCreados.SQL.Add('SELECT a.NUMERO, B.NOMBRE_PRODUCTO, A.CANTIDAD, A.VALOR FROM DETALLE_FACTURA A INNER JOIN PRODUCTOS B ON A.PRODUCTO=B.PRODUCTO WHERE A.NUMERO=:NUMERO');
  QryDetalleFacturaCreados.Parameters[0].Value:= DBLookupComboBox2.KeyValue;
  QryDetalleFacturaCreados.Open;

  IF QryDetalleFacturaCreados.RecordCount=0 THEN
  BEGIN

    application.MessageBox(pchar('El numero '+DBLookupComboBox2.text+', no existe en bases de datos'),
      pchar('Información'), (MB_OK + MB_ICONEXCLAMATION));
      DBLookupComboBox2.SetFocus;

    exit;


  end;
end;

procedure TFrmCrudDetalleFactura.FormActivate(Sender: TObject);
begin
  top := 20;


  DataModule1 := TDataModule1.create(application);
  DataModule1.conexionSqlServer();
  QryDetalleFacturaCreados.Active := true;
  QryProdcuto.Active:=true;
  QryNumero.Active:=TRUE;
end;

procedure TFrmCrudDetalleFactura.FormCreate(Sender: TObject);
begin
   DataModule1 := TDataModule1.create(application);
  DataModule1.conexionSqlServer();
end;



procedure TFrmCrudDetalleFactura.Edit3Change(Sender: TObject);
begin
   IF trim(Edit3.Text) <> EmptyStr THEN
  /// /////// VALIDACION SOLO ACEPTA VALORES NUMERICOS //////////
  BEGIN
    IF STRTOINT64DEF(trim(Edit3.Text), 123456789) = 123456789 THEN
    BEGIN
      application.MessageBox(pchar('El campo debe ser numerico. '),
        pchar('Información'), (MB_OK + MB_ICONEXCLAMATION));
      Edit3.SetFocus;
//      Edit3.Text := EmptyStr;
      exit;
    END;
    end;
end;

procedure TFrmCrudDetalleFactura.Edit3Exit(Sender: TObject);
var
  calculo:Currency;
begin
  if Edit3.Text <> EmptyStr then
  begin

     if DBLookupComboBox1.Text <> EmptyStr then
    begin

      QryTraerValorProducto.Close;
      QryTraerValorProducto.SQL.Clear;
      QryTraerValorProducto.SQL.Add('select * from PRODUCTOS where PRODUCTO=:PRODUCTO ');
      QryTraerValorProducto.Parameters[0].Value:=DBLookupComboBox1.KeyValue;
      QryTraerValorProducto.Open;

      if  QryTraerValorProducto.RecordCount > 0 then
      begin

        calculo:=StrToCurr(trim(Edit3.Text)) * (QryTraerValorProductovalor.AsCurrency);
        Edit2.Text:=  CurrToStr(calculo);

      end;



    end
    else
    begin
       application.MessageBox(pchar('Por favor seleccionar producto. '),
      pchar('Informacion'), (MB_OK + MB_ICONEXCLAMATION));
      Edit3.Text:=EmptyStr;
      DBLookupComboBox1.SetFocus;

      exit;
    end;

  end;
end;

procedure TFrmCrudDetalleFactura.Edit2KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  var
  numero: extended;
  numerox:string;

begin

  if Length(Edit2.Text) >2 then
    BEGIN
     // QUITA LOS PUNTOS PARA CONVERTIR A FLOTANTE
     numerox:= StringReplace(Edit2.Text, '.', '', [rfReplaceAll]);
     numerox:= StringReplace(numerox, ',', '', [rfReplaceAll]);
     numero := StrToFloat(numerox);
     Edit2.Text := FloatToStrf(numero, ffNumber, 15, 0);
     // POSICIONA EL CURSOR EN LA ULTIMA POSICION DEL EDIT
     Edit2.SelStart := Length(Edit2.Text);

    end;
end;

procedure TFrmCrudDetalleFactura.DBLookupComboBox1Exit(Sender: TObject);
begin
  if DBLookupComboBox1.Text <> EmptyStr then
  begin

    QryTraerValorProducto.Close;
    QryTraerValorProducto.SQL.Clear;
    QryTraerValorProducto.SQL.Add('select * from PRODUCTOS where PRODUCTO=:PRODUCTO ');
    QryTraerValorProducto.Parameters[0].Value:=DBLookupComboBox1.KeyValue;
    QryTraerValorProducto.Open;

    if  QryTraerValorProducto.RecordCount > 0 then
    begin

      Edit2.Text:=  CurrToStr(QryTraerValorProductovalor.AsCurrency);

    end;



  end;
end;

procedure TFrmCrudDetalleFactura.BitBtn2Click(Sender: TObject);
begin
  if (DBLookupComboBox2.Text = EmptyStr) or (Edit2.Text = EmptyStr) or
      (Edit3.Text = EmptyStr) or (DBLookupComboBox1.Text = EmptyStr) then
    begin

      application.MessageBox(pchar('Por favor diligenciar todos los campos. '),
        pchar('Informacion'), (MB_OK + MB_ICONEXCLAMATION));

      exit;

    end;

  TRY
    QryCrudDetalleFactura.Close;
    QryCrudDetalleFactura.SQL.Clear;
    QryCrudDetalleFactura.SQL.Add('SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED ' +
      'select * from DETALLE_FACTURA WHERE NUMERO =:NUMERO  ');
    QryCrudDetalleFactura.Parameters[0].Value := DBLookupComboBox2.KeyValue;
    QryCrudDetalleFactura.Open;



      QryCrudDetalleFactura.Insert;

      QryCrudDetalleFacturaNUMERO.Value := StrToInt(DBLookupComboBox2.KeyValue);
      QryCrudDetalleFacturaPRODUCTO.Value := DBLookupComboBox1.KeyValue;
      QryCrudDetalleFacturaCANTIDAD.Value:=StrToInt(trim(Edit3.Text));
      QryCrudDetalleFacturaVALOR.Value := StrToFloat(StringReplace(trim(Edit2.Text), '', '.', [rfReplaceAll]));

      QryCrudDetalleFactura.Post;

//      -----------------------

      QryValorCabezaFactura.Close;
      QryValorCabezaFactura.SQL.Clear;
      QryValorCabezaFactura.SQL.Add('UPDATE A SET A.TOTAL=TABLA1.TOTAL FROM CABEZA_FACTURA A INNER JOIN(                             ' +
                'SELECT A.NUMERO, A.FECHA, A.CLIENTE,                                                             '+                 
                    'ISNULL((SELECT SUM(B.VALOR*B.CANTIDAD) AS TOTAL FROM DETALLE_FACTURA B WHERE B.NUMERO=A.NUMERO),0) AS TOTAL      '+
                    ' FROM CABEZA_FACTURA A                                                                                             '+
                    ' )TABLA1 ON A.NUMERO=TABLA1.NUMERO WHERE A.NUMERO=:NUMERO ');
      QryValorCabezaFactura.Parameters[0].Value:= (DBLookupComboBox2.KeyValue);
      QryValorCabezaFactura.ExecSQL;

      application.MessageBox(pchar('Registro guardado con exito. '),
        pchar('Información'), (MB_OK + MB_ICONINFORMATION));

      BitBtn5Click(self);


  EXCEPT
    ON E: Exception do
      application.MessageBox(pchar('No se pudo Guardar el registro ' +
        E.Message), pchar('Información '), MB_OK + MB_ICONINFORMATION);
  END;
end;

procedure TFrmCrudDetalleFactura.BitBtn3Click(Sender: TObject);
begin
  if (DBLookupComboBox2.Text = EmptyStr) or (Edit2.Text = EmptyStr) or
      (Edit3.Text = EmptyStr) or (DBLookupComboBox1.Text = EmptyStr) then
    begin

      application.MessageBox(pchar('Por favor diligenciar todos los campos. '),
        pchar('Informacion'), (MB_OK + MB_ICONEXCLAMATION));

      exit;

    end;


  TRY
    QryCrudDetalleFactura.Close;
    QryCrudDetalleFactura.SQL.Clear;
    QryCrudDetalleFactura.SQL.Add('SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED ' +
     'select * from DETALLE_FACTURA '+
      ' WHERE NUMERO ='''+CurrToStr(numeroFactura)+''' AND PRODUCTO ='''+CurrToStr(producto)+''' AND CANTIDAD ='''+CurrToStr(cantidad)+''' and VALOR ='''+CurrToStr(valor)+''' ');


    QryCrudDetalleFactura.open;


    QryCrudDetalleFactura.Edit;
    QryCrudDetalleFacturaNUMERO.Value := StrToInt(DBLookupComboBox2.KeyValue);
      QryCrudDetalleFacturaPRODUCTO.Value := DBLookupComboBox1.KeyValue;
      QryCrudDetalleFacturaCANTIDAD.Value:=StrToInt(trim(Edit3.Text));
      QryCrudDetalleFacturaVALOR.Value := StrToFloat(StringReplace(trim(Edit2.Text), '', '.', [rfReplaceAll]));
    QryCrudDetalleFactura.Post;




      application.MessageBox(pchar('Registro Modificado con exito. '),
        pchar('Información'), (MB_OK + MB_ICONINFORMATION));

      BitBtn5Click(self);


  EXCEPT
    ON E: Exception do
      application.MessageBox(pchar('No se pudo Guardar el registro ' +
        E.Message), pchar('Información '), MB_OK + MB_ICONINFORMATION);
  END;
end;

procedure TFrmCrudDetalleFactura.DBGrid1DblClick(Sender: TObject);
begin
  DBLookupComboBox2.KeyValue := DBGrid1.Fields[0].AsString;
  QryProdcuto.Close;
  QryProdcuto.SQL.Clear;
  QryProdcuto.SQL.Add('select PRODUCTO, NOMBRE_PRODUCTO from PRODUCTOS where NOMBRE_PRODUCTO=:NOMBRE_PRODUCTO ');
  QryProdcuto.Parameters[0].Value:=DBGrid1.Fields[1].AsString;
  QryProdcuto.Open;
  DBLookupComboBox1.KeyValue := QryProdcutoPRODUCTO.Value;
  Edit3.Text := DBGrid1.Fields[2].AsString;
  Edit2.Text := DBGrid1.Fields[3].AsString;

  numeroFactura:=StrToCurr(DBGrid1.Fields[0].AsString);
  producto:=QryProdcutoPRODUCTO.Value;;
  cantidad:=StrToCurr(DBGrid1.Fields[2].AsString);
  valor:=StrToCurr(DBGrid1.Fields[3].AsString);
end;

procedure TFrmCrudDetalleFactura.BitBtn4Click(Sender: TObject);
begin
   if (DBLookupComboBox2.Text = EmptyStr) or (Edit2.Text = EmptyStr) or
      (Edit3.Text = EmptyStr) or (DBLookupComboBox1.Text = EmptyStr) then
    begin

      application.MessageBox(pchar('Por favor diligenciar todos los campos. '),
        pchar('Informacion'), (MB_OK + MB_ICONEXCLAMATION));

      exit;

    end;
     
  TRY
    QryCrudDetalleFactura.Close;
    QryCrudDetalleFactura.SQL.Clear;
    QryCrudDetalleFactura.SQL.Add('SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED ' +
      'select * from DETALLE_FACTURA '+
      ' WHERE NUMERO =:NUMERO AND PRODUCTO =:PRODUCTO AND CANTIDAD =:CANTIDAD and VALOR =:VALOR ');
    QryCrudDetalleFactura.Parameters[0].Value := StrToInt(DBLookupComboBox2.KeyValue);;
    QryCrudDetalleFactura.Parameters[1].Value := DBLookupComboBox1.KeyValue;
    QryCrudDetalleFactura.Parameters[2].Value := StrToInt(trim(Edit3.Text));
    QryCrudDetalleFactura.Parameters[3].Value := StrToFloat(StringReplace(trim(Edit2.Text), '', '.', [rfReplaceAll]));
    QryCrudDetalleFactura.Open;

    if QryCrudDetalleFactura.RecordCount > 0 then
    begin

      QryCrudDetalleFactura.Close;
      QryCrudDetalleFactura.SQL.Clear;
      QryCrudDetalleFactura.SQL.Add('DELETE from DETALLE_FACTURA WHERE NUMERO =:NUMERO AND PRODUCTO =:PRODUCTO AND CANTIDAD =:CANTIDAD and VALOR =:VALOR  ');
      QryCrudDetalleFactura.Parameters[0].Value := StrToInt(DBLookupComboBox2.KeyValue);;
      QryCrudDetalleFactura.Parameters[1].Value := DBLookupComboBox1.KeyValue;
      QryCrudDetalleFactura.Parameters[2].Value := StrToInt(trim(Edit3.Text));
      QryCrudDetalleFactura.Parameters[3].Value := StrToFloat(StringReplace(trim(Edit2.Text), '', '.', [rfReplaceAll]));
    
      QryCrudDetalleFactura.ExecSQL;

      application.MessageBox(pchar('Registro Eliminado con exito. '),
        pchar('Información'), (MB_OK + MB_ICONINFORMATION));

      BitBtn5Click(self);

    end
    else
    begin

      application.MessageBox(pchar('No se pudo Eliminar el registro porque no existe en bases de datos '),
        pchar('Informacion'), (MB_OK + MB_ICONEXCLAMATION));

      exit;

    end;
  EXCEPT
    ON E: Exception do
      application.MessageBox(pchar('No se pudo Eliminar el registro ' +
        E.Message), pchar('Información '), MB_OK + MB_ICONINFORMATION);
  END;

end;

end.
