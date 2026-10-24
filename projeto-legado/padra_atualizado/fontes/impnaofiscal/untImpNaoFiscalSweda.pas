unit untImpNaoFiscalSweda;

interface

uses Windows, SysUtils, untImpNaoFiscal, Printers, Graphics, ComCtrls;

Type
  TImpNaoFiscalSweda = class(TImpNaoFiscal)
  private
    procedure pConfiguraImpressora;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;

    procedure pEscreveNegrito(strTexto: String); override;
    procedure pAcionaGuilhotina(blnCorteTotal: Boolean); override;
    procedure pAbreGaveta; Override;
  End;

implementation

uses  Forms;

{ TImpNaoFiscalSweda }

constructor TImpNaoFiscalSweda.Create;
begin
  pConfiguraImpressora;
  FEditor := TRichEdit.Create(Application);
  FEditor.Parent := Application.MainForm;
  FEditor.Visible := False;
  FEditor.DefAttributes.Name := 'Courier New';
  FEditor.DefAttributes.Style := [fsBold];
end;

destructor TImpNaoFiscalSweda.Destroy;
begin
  FreeAndNil(FEditor);
  inherited;
end;

procedure TImpNaoFiscalSweda.pAbreGaveta;
begin
  inherited;
  //
end;

procedure TImpNaoFiscalSweda.pAcionaGuilhotina(blnCorteTotal: Boolean);
begin
  inherited;
  //MEGENCOM32_EscrevernoDispositivo(PChar(strPorta), PChar(#27 + 'm'), 2, @intQtd);
//  If Not Printer.Printing Then
//    Printer.BeginDoc;

//  Printer.EndDoc;
  FEditor.Print('Impressão de faturamento');
  FEditor.Lines.Clear;
end;

procedure TImpNaoFiscalSweda.pConfiguraImpressora;
begin
  //
end;

procedure TImpNaoFiscalSweda.pEscreveNegrito(strTexto: String);
  Var
    intSize: Integer;
    fstStyle: TFontStyles;
begin

  intSize := FEditor.SelAttributes.Size;
  fstStyle := FEditor.SelAttributes.Style;

  FEditor.SelAttributes.Size := 13;
  FEditor.SelAttributes.Style := [fsBold];

  FEditor.Lines.Add(strTexto);

  FEditor.SelAttributes.Size := intSize;
  FEditor.SelAttributes.Style := fstStyle;
end;

end.
