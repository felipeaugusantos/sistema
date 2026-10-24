unit untSefazParalisado;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxControls, cxContainer, cxEdit, cxTextEdit, cxMemo, StdCtrls,
  ComCtrls;

type
  TfrmSefazParalisado = class(TForm)
    edtTexto: TRichEdit;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    blnMomentaneamente: Boolean;
    blnDPec: Boolean;
  end;

var
  frmSefazParalisado: TfrmSefazParalisado;

implementation

{$R *.dfm}

procedure TfrmSefazParalisado.FormCreate(Sender: TObject);
begin
  blnMomentaneamente := True;
  blnDPec := False;
end;

procedure TfrmSefazParalisado.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If Key = VK_ESCAPE Then
    Close;
end;

procedure TfrmSefazParalisado.FormShow(Sender: TObject);
  Var
    strTitulo: String;
begin
  If blnDPec Then
  Begin
    strTitulo := 'SEFAZ OPERACIONAL (OPERANDO EM DPEC) ';
  End
  Else
  Begin
    strTitulo := 'SEFAZ PARALISADO ';
    If blnMomentaneamente Then
      strTitulo := strTitulo + 'MOMENTANEAMENTE'
    Else
      strTitulo := strTitulo + 'SEM PREVISÃO DE RETORNO';
  End;

  edtTexto.Paragraph.Alignment := taCenter;
  edtTexto.SelAttributes.Size := 20;
  edtTexto.SelAttributes.Style := [fsBold];
  edtTexto.SelAttributes.Color := clRed;

  edtTexto.Lines.Add(strTitulo);

  edtTexto.SelAttributes.Size := 14;
  edtTexto.SelAttributes.Style := [fsBold];
  edtTexto.SelAttributes.Color := clBlack;

  If blnDPec Then
  Begin
    edtTexto.Lines.Add('As notas emitidas em DPEC serão autorizadas temporariamente e reenviadas à SEFAZ quando a mesma retomar sua operação normal.');

    edtTexto.SelAttributes.Size := 14;
    edtTexto.SelAttributes.Style := [fsBold];
    edtTexto.SelAttributes.Color := clBlack;
    edtTexto.Lines.Add('A emissão de notas na empresa pode continuar normalmente, sem nenhuma outra intervenção.');

    edtTexto.SelAttributes.Size := 14;
    edtTexto.SelAttributes.Style := [fsBold];
    edtTexto.SelAttributes.Color := clBlack;
    edtTexto.Lines.Add('Caso haja notas aguardando autorização no PainelNFe, pof favor aguarde alguns minutos para que elas sejam autorizadas.');
  End
  Else
  Begin
    edtTexto.Lines.Add('');

    edtTexto.SelAttributes.Size := 9;
    edtTexto.SelAttributes.Style := [fsBold];
    edtTexto.SelAttributes.Color := clBlack;
    edtTexto.Lines.Add('No momento, o sistema para validação e autorização de nota fiscal (Sefaz) está indisponível devido a problemas técnicos.');

    edtTexto.SelAttributes.Size := 9;
    edtTexto.SelAttributes.Style := [fsBold];
    edtTexto.SelAttributes.Color := clBlack;
    edtTexto.Lines.Add('Aguarde alguns minutos e volte a reenviar as notas. Em breve, o serviço será restabelecido e elas serão autorizadas.');
    edtTexto.Lines.Add('');
    edtTexto.SelAttributes.Size := 9;
    edtTexto.SelAttributes.Style := [fsBold];
    edtTexto.SelAttributes.Color := clBlack;
    edtTexto.Lines.Add('O status pode ser consultado e verificado através do portal:');

    edtTexto.SelAttributes.Size := 9;
    edtTexto.SelAttributes.Style := [fsBold];
    edtTexto.SelAttributes.Color := clBlack;
    edtTexto.Lines.Add('https://www.nfe.fazenda.gov.br/portal/disponibilidade.aspx?versao=0.00&tipoConteudo=Skeuqr8PQBY=');
  End;
end;

end.
