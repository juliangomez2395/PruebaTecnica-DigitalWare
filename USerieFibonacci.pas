unit USerieFibonacci;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TFrmSerieFibonacci = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Image1: TImage;
    GroupBox2: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    GroupBox3: TGroupBox;
    Label5: TLabel;
    Edit1: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Memo1: TMemo;
    procedure Edit1Change(Sender: TObject);
    procedure Edit1Exit(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmSerieFibonacci: TFrmSerieFibonacci;

implementation

{$R *.dfm}

procedure TFrmSerieFibonacci.Edit1Change(Sender: TObject);
begin
   IF TRIM(Edit1.Text) <> EmptyStr THEN
  /// /////// VALIDACION SOLO ACEPTA VALORES NUMERICOS //////////
  BEGIN
    IF STRTOINT64DEF(TRIM(Edit1.Text), 123456789) = 123456789 THEN
    BEGIN
      Application.MessageBox(pchar('El campo debe ser numerico. '),
        pchar('Horas Trabajadas'), (MB_OK + MB_ICONEXCLAMATION));
      Edit1.SetFocus;
      Edit1.Text := EmptyStr;
      Exit;
    END;
  END;
end;

procedure TFrmSerieFibonacci.Edit1Exit(Sender: TObject);
begin
  IF TRIM(Edit1.Text)<> EmptyStr THEN
  BEGIN

    if (StrToInt(Edit1.Text) < 1) or (StrToInt(Edit1.Text) > 20) then
    begin
      Application.MessageBox
        (pchar('Solo se permita capturar un n?mero entero positivo entre 1 y 20. '),
        pchar('Serie Fibonacci.'), (MB_OK + MB_ICONEXCLAMATION));
      Edit1.SetFocus;
      Edit1.Text := EmptyStr;
    end;

  end;

end;

procedure TFrmSerieFibonacci.FormActivate(Sender: TObject);
begin
  top := 20;
end;

procedure TFrmSerieFibonacci.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   Action := caFree;
end;

procedure TFrmSerieFibonacci.BitBtn2Click(Sender: TObject);
begin
  Memo1.Clear;
end;

procedure TFrmSerieFibonacci.BitBtn1Click(Sender: TObject);
var
  numeroArray: array of integer;
  I, n: integer;
  concatenarArray: string;

begin

   if (TRIM(Edit1.Text) = EmptyStr) then
  begin

    Application.MessageBox
      (pchar('Por favor diligenciar el campo numero.'),
      pchar('Serie Fibonacci'), (MB_OK + MB_ICONEXCLAMATION));
    exit;

  end;

  n := StrToInt(TRIM(Edit1.Text));
  SetLength(numeroArray, 2);

  numeroArray[0] := 1;
  numeroArray[1] := 1;

  for I := 2 to n - 1 do
  begin

    SetLength(numeroArray, n);

    numeroArray[I] := numeroArray[I - 1] + numeroArray[I - 2];

  end;

  for I := 0 to Length(numeroArray) - 1 do
  begin
    concatenarArray := concatenarArray + IntToStr(numeroArray[I]) + ' ';

  end;

  Memo1.Lines.Add(concatenarArray);

end;

end.
