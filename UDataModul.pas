unit UDataModul;

interface

uses
  SysUtils, Classes, DB, ADODB;

type
  TDataModule1 = class(TDataModule)
    ConexionLocal: TADOConnection;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure conexionSqlServer();
  end;

var
  DataModule1: TDataModule1;

implementation

{$R *.dfm}

procedure TDataModule1.conexionSqlServer();
var
  password, user, dataBase, server: string;

begin
  password := 'Colombia01+';
  user := 'sa';
  dataBase := 'PRUEBA';
  server := '192.168.20.117';

//  DataModule1 := TDataModule1.create(application);

  ConexionLocal.Connected := FALSE;
  ConexionLocal.ConnectionString := 'Provider=SQLOLEDB.1;Password='
    + password + ';Persist Security Info=True;User ID=' + user +
    ';Initial Catalog=' + dataBase + ';Data Source=' + server +
    ';Use Procedure for Prepare=1;';
  ConexionLocal.ConnectionString :=
    ConexionLocal.ConnectionString +
    'Auto Translate=True;Packet Size=8192;Workstation ID=' + user +
    ';Use Encryption for Data=False;Tag with column collation when possible=False';
  ConexionLocal.Connected := true;
end;

end.
