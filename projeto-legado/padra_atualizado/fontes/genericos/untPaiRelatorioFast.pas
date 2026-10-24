{*********************************************************}
{* TELA DE RELATORIOS FEITOS PELO FAST REPORT            *}
{*                                                       *}
{* DATA......: 18/09/2007                                *}
{* AUTOR.....: ALEXANDRE OLIVEIRA FERRI "FALTA MUITO???" *}
{*                                                       *}
{******************************************************AF*}
unit untPaiRelatorioFast;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, EditFocus, QColorLabel, frxClass, Menus,
  Buttons, ExtCtrls, frxDBSet, frxExportTXT, frxExportRTF, frxExportXLS,
  frxExportHTML, frxExportPDF, frxDMPExport, frxADOComponents;

type
  TfrmPaiRelatorioFast = class(TfrmPai)
    frxReport1: TfrxReport;
    pnlDados: TPanel;
    gpbDestino: TGroupBox;
    ColorLabel1: TColorLabel;
    edtDestino: TEditFocus;
    btnImprimir: TBitBtn;
    btnConfigurar: TBitBtn;
    frxRelatorio: TfrxDBDataset;
    frxMatricial: TfrxDotMatrixExport;
    frxExpPDF: TfrxPDFExport;
    frxExpHtml: TfrxHTMLExport;
    frxExpXLS: TfrxXLSExport;
    frxExpRTF: TfrxRTFExport;
    frxExpTXT: TfrxTXTExport;
    frxQrysAdo: TfrxADOComponents;
    procedure FormShow(Sender: TObject);
    procedure btnConfigurarClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtDestinoExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    blnImprime: Boolean;
    strTipImp : String;
    intCount  : Integer;
    intGlobal : Integer;
  Protected
    procedure pTabelaVazia;
  end;

Const
  MSG_IMPINVALIDA = 'Houve um erro ao enviar o relatório para a impressora.' + #13 +
                    'Verifique se a impressora selecionada é válida ou seu nome está digitado corretamente.';

var
  frmPaiRelatorioFast: TfrmPaiRelatorioFast;

implementation

uses untFuncoes, untfuncoesSimples, untModuloCfgRel, untCadConfRelatorios, untModuloSPR;

{$R *.dfm}

{ TfrmPaiRelatorioFast }

procedure TfrmPaiRelatorioFast.pTabelaVazia;
begin
  fMensagem('', 'Não há dados para gerar o relatório!', ['&Ok']);
end;

procedure TfrmPaiRelatorioFast.FormShow(Sender: TObject);
begin
  inherited;

  frmModuloCfgRel.pCarregaConfImpr(Self.Name);

end;

procedure TfrmPaiRelatorioFast.btnConfigurarClick(Sender: TObject);
begin
  inherited;

  Try
    Application.CreateForm(TfrmCadConfRelatorios, frmCadConfRelatorios);
    frmCadConfRelatorios.blnConfigurar := True;
    frmCadConfRelatorios.strNomeForm   := Self.Name;
    frmCadConfRelatorios.showModal;
  Finally
    FreeAndNil(frmCadConfRelatorios);
  End;
  frmModuloCfgRel.pCarregaConfImpr(Self.Name);

end;

procedure TfrmPaiRelatorioFast.btnImprimirClick(Sender: TObject);
  Var
    strNomImp: String;
begin
  inherited;

  btnImprimir.Enabled := False;
  blnImprime := fVerificaCampos;

  If blnImprime Then
  Begin
    blnImprime := frmModuloCfgRel.fPreImpressao(strNomImp, strTipImp, False, edtDestino.Text);
  End;

end;

procedure TfrmPaiRelatorioFast.FormCreate(Sender: TObject);
begin
  inherited;

  intCount  := 0;
  intGlobal := 0;

end;

procedure TfrmPaiRelatorioFast.edtDestinoExit(Sender: TObject);
begin
  inherited;

  If fEmptyStr(edtDestino.Text) Then
  Begin
    fMensagem('ATENÇÃO', 'O Destino do Relatório deve ser preenchido!', ['&Ok']);
    edtDestino.SetFocus;
  End
  Else If Pos(edtDestino.Text,'V_I_') <= 0 Then
  Begin
    edtDestino.SetFocus;
  End;

end;

end.

