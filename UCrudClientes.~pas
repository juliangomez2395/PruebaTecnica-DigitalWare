unit UCrudClientes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, DB, ADODB, StdCtrls, Buttons, ExtCtrls;

type
  TFrmCrudClientes = class(TForm)
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
    QryClientesCreados: TADOQuery;
    QryClientesCreadosCLIENTE: TIntegerField;
    QryClientesCreadosNOMBRE_CLIENTE: TStringField;
    QryClientesCreadosDIRECCION: TStringField;
    DtsClienteCRUD: TDataSource;
    QryConsulta: TADOQuery;
    QryConsultaCLIENTE: TIntegerField;
    QryConsultaNOMBRE_CLIENTE: TStringField;
    QryConsultaDIRECCION: TStringField;
    QryInsert: TADOQuery;
    QryInsertCLIENTE: TIntegerField;
    QryInsertNOMBRE_CLIENTE: TStringField;
    QryInsertDIRECCION: TStringField;
    QryUpdate: TADOQuery;
    IntegerField3: TIntegerField;
    StringField5: TStringField;
    StringField6: TStringField;
    DBGrid1: TDBGrid;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Edit1Exit(Sender: TObject);
    procedure Edit2Exit(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure conexionSqlServer();
  end;

var
  FrmCrudClientes: TFrmCrudClientes;

implementation

uses UDataModul;

{$R *.dfm}

procedure TFrmCrudClientes.conexionSqlServer();
var
  password, user, dataBase, server: string;

begin
  password := 'Colombia01+';
  user := 'sa';
  dataBase := 'PRUEBA';
  server := '192.168.20.117';

  DataModule1 := TDataModule1.create(application);

  DataModule1.ConexionLocal.Connected := FALSE;
  DataModule1.ConexionLocal.ConnectionString := 'Provider=SQLOLEDB.1;Password='
    + password + ';Persist Security Info=True;User ID=' + user +
    ';Initial Catalog=' + dataBase + ';Data Source=' + server +
    ';Use Procedure for Prepare=1;';
  DataModule1.ConexionLocal.ConnectionString :=
    DataModule1.ConexionLocal.ConnectionString +
    'Auto Translate=True;Packet Size=8192;Workstation ID=' + user +
    ';Use Encryption for Data=False;Tag with column collation when possible=False';
  DataModule1.ConexionLocal.Connected := true;
end;

procedure TFrmCrudClientes.FormActivate(Sender: TObject);
begin
  top := 20;
  conexionSqlServer();

  DataModule1 := TDataModule1.create(application);
  QryClientesCreados.Active := true;
end;

procedure TFrmCrudClientes.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFrmCrudClientes.FormCreate(Sender: TObject);
begin
  conexionSqlServer();
  DataModule1 := TDataModule1.create(application);
end;

procedure TFrmCrudClientes.Edit1Exit(Sender: TObject);
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
  END;

  DataModule1 := TDataModule1.create(application);
  QryConsulta.Close;
  QryConsulta.SQL.Clear;
  QryConsulta.SQL.Add('SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED ' +
    'SELECT CLIENTE, NOMBRE_CLIENTE, DIRECCION FROM CLIENTES WHERE CLIENTE =:CLIENTE  ');
  QryConsulta.Parameters[0].Value := trim(Edit1.Text);
  QryConsulta.Open;

  if QryConsulta.RecordCount = 0 then
  begin

    BitBtn2.Enabled := true;
    // BitBtn3.Enabled:=TRUE;
    // BitBtn4.Enabled:=TRUE;

  end
  else
  begin

    Edit2.Text := QryConsultaNOMBRE_CLIENTE.AsString;
    Edit3.Text := QryConsultaDIRECCION.AsString;
    // BitBtn2.Enabled:=TRUE;
    BitBtn3.Enabled := true;
    BitBtn4.Enabled := true;

  end;
end;

procedure TFrmCrudClientes.Edit2Exit(Sender: TObject);
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

procedure TFrmCrudClientes.BitBtn2Click(Sender: TObject);
begin
  if (Edit1.Text = EmptyStr) or (Edit2.Text = EmptyStr) or
    (Edit3.Text = EmptyStr) then
  begin

    application.MessageBox(pchar('Por favor diligenciar todos los campos. '),
      pchar('Informacion'), (MB_OK + MB_ICONEXCLAMATION));

    exit;

  end;

  TRY
    QryInsert.Close;
    QryInsert.SQL.Clear;
    QryInsert.SQL.Add('SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED ' +
      'SELECT CLIENTE, NOMBRE_CLIENTE, DIRECCION FROM CLIENTES WHERE CLIENTE =:CLIENTE  ');
    QryInsert.Parameters[0].Value := trim(Edit1.Text);
    QryInsert.Open;

    if QryInsert.RecordCount = 0 then
    begin

      QryInsert.Insert;

      QryInsertCLIENTE.Value := StrToInt(trim(Edit1.Text));
      QryInsertNOMBRE_CLIENTE.Value := trim(Edit2.Text);
      QryInsertDIRECCION.Value := trim(Edit3.Text);

      QryInsert.Post;

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

procedure TFrmCrudClientes.BitBtn5Click(Sender: TObject);
begin
  Close();
  FrmCrudClientes := TFrmCrudClientes.create(application);
  FrmCrudClientes.Show;
end;

procedure TFrmCrudClientes.BitBtn3Click(Sender: TObject);
begin
  if (Edit1.Text = EmptyStr) or (Edit2.Text = EmptyStr) or
    (Edit3.Text = EmptyStr) then
  begin

    application.MessageBox(pchar('Por favor diligenciar todos los campos. '),
      pchar('Información'), (MB_OK + MB_ICONEXCLAMATION));

    exit;

  end;

  TRY
    QryInsert.Close;
    QryInsert.SQL.Clear;
    QryInsert.SQL.Add('SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED ' +
      'SELECT CLIENTE, NOMBRE_CLIENTE, DIRECCION FROM CLIENTES WHERE CLIENTE =:CLIENTE  ');
    QryInsert.Parameters[0].Value := trim(Edit1.Text);
    QryInsert.Open;

    if QryInsert.RecordCount > 0 then
    begin

      QryInsert.edit;

      QryInsertCLIENTE.Value := StrToInt(trim(Edit1.Text));
      QryInsertNOMBRE_CLIENTE.Value := trim(Edit2.Text);
      QryInsertDIRECCION.Value := trim(Edit3.Text);

      QryInsert.Post;

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

procedure TFrmCrudClientes.BitBtn4Click(Sender: TObject);
begin
   if (Edit1.Text = EmptyStr) or (Edit2.Text = EmptyStr) or
    (Edit3.Text = EmptyStr) then
  begin

    application.MessageBox(pchar('Por favor diligenciar todos los campos. '),
      pchar('Información'), (MB_OK + MB_ICONEXCLAMATION));

    exit;

  end;

  TRY
    QryInsert.Close;
    QryInsert.SQL.Clear;
    QryInsert.SQL.Add('SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED ' +
      'SELECT CLIENTE, NOMBRE_CLIENTE, DIRECCION FROM CLIENTES WHERE CLIENTE =:CLIENTE  ');
    QryInsert.Parameters[0].Value := trim(Edit1.Text);
    QryInsert.Open;

    if QryInsert.RecordCount > 0 then
    begin

      QryInsert.Close;
      QryInsert.SQL.Clear;
      QryInsert.SQL.Add('DELETE FROM CLIENTES WHERE CLIENTE=:CLIENTE ');
      QryInsert.Parameters[0].Value := trim(Edit1.Text);
      QryInsert.ExecSQL;

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

procedure TFrmCrudClientes.DBGrid1DblClick(Sender: TObject);
begin
  Edit1.Text := DBGrid1.Fields[0].AsString;
  Edit1Exit(self);
end;

end.
