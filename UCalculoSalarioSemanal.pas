unit UCalculoSalarioSemanal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TFrmCalculoSalarioSemanal = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Image1: TImage;
    GroupBox2: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Edit1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCalculoSalarioSemanal: TFrmCalculoSalarioSemanal;

implementation

{$R *.dfm}

procedure TFrmCalculoSalarioSemanal.FormActivate(Sender: TObject);
begin
  top := 20;
end;

procedure TFrmCalculoSalarioSemanal.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:= caFree;
end;

procedure TFrmCalculoSalarioSemanal.Edit1Change(Sender: TObject);
var
  i:integer;
begin
  if  Edit1.Text<>EmptyStr then
  begin
    FOR i := 1 TO Length(Edit1.Text) DO
    BEGIN
      IF ((Edit1.Text[i] = '1') OR (Edit1.Text[i] = '2') OR (Edit1.Text[i] = '3')
        OR (Edit1.Text[i] = '4') OR (Edit1.Text[i] = '5') OR (Edit1.Text[i] = '6')
        OR (Edit1.Text[i] = '7') OR (Edit1.Text[i] = '8') OR (Edit1.Text[i] = '9')
        OR (Edit1.Text[i] = '0')) THEN
      BEGIN

        Application.MessageBox(pchar('Este campo no debe contener numeros. '),
          pchar('Nombre no valido'), (MB_OK + MB_ICONERROR));
        Edit1.SetFocus;
        Edit1.Text := EmptyStr;
        exit;
      END;
    END;
  end;
end;

procedure TFrmCalculoSalarioSemanal.Edit2Change(Sender: TObject);
begin
  IF TRIM(Edit2.Text) <> EmptyStr THEN
  /// /////// VALIDACION SOLO ACEPTA VALORES NUMERICOS //////////
  BEGIN
    IF STRTOINT64DEF(TRIM(Edit2.Text), 123456789) = 123456789 THEN
    BEGIN
      Application.MessageBox(pchar('El campo debe ser numerico. '),
        pchar('Horas Trabajadas'), (MB_OK + MB_ICONEXCLAMATION));
      Edit2.SetFocus;
      Edit2.Text := EmptyStr;
      exit;
    END;
  END;
end;

procedure TFrmCalculoSalarioSemanal.BitBtn1Click(Sender: TObject);
var
  horaNormal, pagoPorHora, totalPago, horaExtra, pagoHoraExtra: Currency;
begin
   if (TRIM(Edit1.Text) = EmptyStr) or (TRIM(Edit2.Text) = EmptyStr) then
  begin

    Application.MessageBox
      (pchar('Por favor diligenciar todos los campos del formulario.'),
      pchar('Calculo Salario Semanal'), (MB_OK + MB_ICONEXCLAMATION));
    exit;

  end;

  pagoPorHora := 15000;
  pagoHoraExtra := 19000;
  horaNormal := 35;

  if StrToInt(TRIM(Edit2.Text)) <= horaNormal then
  BEGIN

    totalPago := (pagoPorHora * StrToInt(TRIM(Edit2.Text))) / 1;

  END
  ELSE
  BEGIN

    horaExtra := StrToInt(TRIM(Edit2.Text)) - horaNormal;

    totalPago := (pagoPorHora * horaNormal) + (pagoHoraExtra * horaExtra);

  END;

  Application.MessageBox(pchar('Al Empleado ' + TRIM(Edit1.Text) +
    ' se le debe pagar la suma de ' + FormatFloat('#,##.00', totalPago) +
    ' pesos.'), pchar('Calculo Salario Semanal'), (MB_OK + MB_ICONINFORMATION));
end;

procedure TFrmCalculoSalarioSemanal.BitBtn2Click(Sender: TObject);
begin
  Edit1.Text := EmptyStr;
  Edit2.Text := EmptyStr;
  Edit1.SetFocus;
end;

end.
