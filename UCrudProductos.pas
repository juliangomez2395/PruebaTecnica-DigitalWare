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
    IntegerField1: TIntegerField;
    StringField1: TStringField;
    FloatField1: TFloatField;
    QryConsultaProductos: TADOQuery;
    QryConsultaProductosPRODUCTO: TIntegerField;
    QryConsultaProductosNOMBRE_PRODUCTO: TStringField;
    QryConsultaProductosVALOR: TFloatField;
    procedure Edit1Exit(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCrudProductos: TFrmCrudProductos;

implementation

uses UDataModul;

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
end;

procedure TFrmCrudProductos.FormActivate(Sender: TObject);
begin
  top := 20;
  DataModule1.conexionSqlServer();

  DataModule1 := TDataModule1.create(application);
  QryProductosCreados.Active := true;
end;

procedure TFrmCrudProductos.FormCreate(Sender: TObject);
begin
  DataModule1.conexionSqlServer();
  DataModule1 := TDataModule1.create(application);
end;

end.
