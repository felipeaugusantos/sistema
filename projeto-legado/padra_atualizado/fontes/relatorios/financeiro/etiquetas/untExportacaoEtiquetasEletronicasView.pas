unit untExportacaoEtiquetasEletronicasView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ComCtrls, untFrameDirectoryEditFocus, untFuncoesSimples,
  untIExportacaoEtiquetasEletronicas, untExportacaoEtiquetasEletronicasCSV, Data.DB,
  untTypesSistema, EditFocus;

type
  TfrmExportacaoEtiquetasEletronicasView = class(TfrmPai)
    pnlCabecalho: TPanel;
    Label1: TLabel;
    fraPatTxt: TfraDirectoryEditFocus;
    btnConfirmar: TBitBtnLocked;
    pgbProgresso: TProgressBar;
    Label2: TLabel;
    edtNomeArq: TEditFocus;
    procedure btnConfirmarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    DataSet: TDataSet;
    arrCodEmpEtiEle: TConsultasArray;
    strFiltro: string;
  end;

var
  frmExportacaoEtiquetasEletronicasView: TfrmExportacaoEtiquetasEletronicasView;

implementation

{$R *.dfm}

procedure TfrmExportacaoEtiquetasEletronicasView.btnConfirmarClick(
  Sender: TObject);
begin
  inherited;
  If fEmptyStr(fraPatTxt.edtDirectory.text)Then
  Begin
    fMensagem('ATENÇÃO!','Path para geração do arquivo está vazio!' + #13#10 +
      'Favor preencher a configuração CFG_EECGAR. ' ,['&O K']);
    pSetFocus(fraPatTxt);
    Exit;
  End
  Else if (not DirectoryExists(fraPatTxt.edtDirectory.text)) Then
  Begin
    fMensagem('ATENÇÃO!','Path inválido.',['&O K']);
    pSetFocus(fraPatTxt);
    Exit;
  End;

  if fEmptyStr(edtNomeArq.text) then
  begin
    fMensagem('ATENÇÃO!','Nome do aqrquivo está vazio!' + #13#10 +
      'Favor preencher corretamente. ' ,['&O K']);
    pSetFocus(edtNomeArq);
    Exit;
  end;

  btnConfirmar.Enabled := False;

  Try
    If TExportacaoEtiquetasEletronicasCSV.New().fGerarArquivo(fraPatTxt.edtDirectory.Text, DataSet, pgbProgresso, arrCodEmpEtiEle, LowerCase(edtNomeArq.Text), UpperCase(strFiltro)) Then
      BtnSair.Click;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[btnConfirmarClick]');
    End;
  End;
end;

procedure TfrmExportacaoEtiquetasEletronicasView.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if (Shift = []) then
    if (Key = VK_ESCAPE) Then
      Self.Close;
end;

procedure TfrmExportacaoEtiquetasEletronicasView.FormShow(Sender: TObject);
begin
  inherited;
  edtNomeArq.text := fCfgSis('EENARQ');
  fraPatTxt.edtDirectory.text := fCfgSis('EECGAR');

  If fEmptyStr(fraPatTxt.edtDirectory.text) Then
  Begin
    pSetFocus(fraPatTxt);
    Exit;
  End;

  fraPatTxt.edtDirectory.Enabled := False;
  fraPatTxt.btnOpenDirectory.Enabled := False;
  pSetFocus(btnConfirmar);
end;

end.

