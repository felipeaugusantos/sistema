unit untExpArqPagFor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit,
  cxButtonEdit, DirectoryEditFocus, EditFocus, untFuncoes, untFuncoesSimples, 
  untFrameDirectoryEditFocus;

type
  TfrmExpArqPagFor = class(TfrmPai)
    pnlFundo: TPanel;
    lblPathRem: TLabel;
    lblNomArq: TLabel;
    pnlTopo: TPanel;
    edtNomArquivo: TEditFocus;
    fraPathRemessa: TfraDirectoryEditFocus;
    btnGerar: TBitBtnLocked;
    procedure btnGerarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure pMontaNomeArquivo;
    { Private declarations }
  public
    { Public declarations }
    strCodBco,
    strNomBco,
    strConfig: String;
  end;

var
  frmExpArqPagFor: TfrmExpArqPagFor;

implementation
Uses untTPagFor;
{$R *.dfm}

procedure TfrmExpArqPagFor.btnGerarClick(Sender: TObject);
  Var
    objPagFor: TPagFor;
    lstArquiv: TStringList;
begin
  inherited;
  fraPathRemessa.edtDirectory.text := fVerBarraFinal(fraPathRemessa.edtDirectory.text);

  If Not DirectoryExists(fraPathRemessa.edtDirectory.text) Then
  Begin
    fMensagem('Caminho', 'Pasta inválida para a exportação do arquivo.', ['&O K'], 1, True);
    pSetFocus(fraPathRemessa);
    Exit;
  End;

  Try
    lstArquiv := TStringList.Create;
    lstArquiv.Add(fraPathRemessa.edtDirectory.text + edtNomArquivo.Text);
    objPagFor := TPagFor.Create;
    objPagFor.fExportaPagFor(lstArquiv, strCodBco, strNomBco, strConfig);
  Finally
    FreeAndNil(objPagFor);
    FreeAndNil(lstArquiv);
  End;
  Self.Close;
end;

procedure TfrmExpArqPagFor.pMontaNomeArquivo;
var
  strCodCon : String;
  intProxNum : Integer;
const
  strMes : Array[0..11] of string = ('1', '2', '3', '4', '5', '6', '7', '8', '9', 'O', 'N', 'D');
begin
  intProxNum := StrToInt(fGetBancoProxNum(strConfig));
  Inc(intProxNum);

  If (strCodBco = '748') Then
  Begin
    strCodCon := fGetBancoConfig(0, strConfig, 'CONVENI', '');
    If (Length(strCodCon) = 4) Then
      edtNomArquivo.Text := strCodCon +
                            FormatDateTime('dd',VS_Date) +
                            fPadL(IntToStr(intProxNum), 02, '0') +
                           '.REM'
    Else
      edtNomArquivo.Text := strCodCon +
                            FormatDateTime('dd',VS_Date) +
                            strMes[StrToInt(FormatDateTime('mm',VS_Date))-1] +
                            fPadL(IntToStr(intProxNum), 02, '0') +
                           '.REM';
  End
  Else
  Begin
    edtNomArquivo.Text  := 'RM' +
                           fStrZero(IntToStr(intProxNum), 06) +
                           '.TXT'
  End;
end;

procedure TfrmExpArqPagFor.FormShow(Sender: TObject);
begin
  inherited;
  fraPathRemessa.edtDirectory.text := fVerBarraFinal(fGetBancoConfig(0, strConfig, 'PATHREM',''));

  pMontaNomeArquivo;

  pSetFocus(fraPathRemessa);
end;

end.
