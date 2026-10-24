unit untConfiguracoesResicolor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, Mask,
  FilenameEditFocus, EditFocus, strUtils, Uni,
  DirectoryEditFocus, Tabs, ComCtrls, untIConfTinta, untIConsultaTinta,
  untConfConsulta, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit, 
  untFrameDirectoryEditFocus;

type
  TfrmConfiguracoesResicolor = class(TfrmPai)
    pnlCabecalho: TPanel;
    pcgResicolor: TPageControl;
    tbsGeral: TTabSheet;
    tbsConfCampos: TTabSheet;
    Label2: TLabel;
    Label20: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    chkUsaRsi: TCheckBox;
    edtTraRsi: TEditFocus;
    edtFatRsi: TEditFocus;
    edtNfmRsi: TEditFocus;
    btnGravarConf: TBitBtnLocked;
    btnRestaurar: TBitBtnLocked;
    Label7: TLabel;
    edtDesOpe: TEditFocus;
    Label63: TLabel;
    edtApreve: TEditFocus;
    fraPatRsi: TfraDirectoryEditFocus;
    procedure btnGravarConfClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnRestaurarClick(Sender: TObject);
  private
    conf: IConfTinta;
    tinta: IConsultaTinta ;
    frmConfConsultaResicolor: TfrmConfConsulta;
    procedure pCarregarConfs;
    procedure pSalvarConfs;
    { Private declarations }
  public
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    { Public declarations }
  end;

var
  frmConfiguracoesResicolor: TfrmConfiguracoesResicolor;

implementation

uses untFuncoesSimples, untFuncTinta;

{$R *.dfm}

{ TfrmConfiguracoesResicolor }

procedure TfrmConfiguracoesResicolor.pCarregarConfs;
begin
  conf := fGetConfTinta('RSI');

  chkUsaRsi.Checked := conf.fGetBoolean('USATIN');
  edtTraRsi.Text := conf.fGet('RSITRA');
  edtFatRsi.Text := conf.fGet('FATRSI');
  edtNfmRsi.Text := conf.fGet('NFMRSI');
  fraPatRsi.edtDirectory.text := conf.fGet('PATRSI');
  edtDesOpe.Text := conf.fGet('DESOPE');
  edtApreve.Text := conf.fGet('APREVE');
end;

procedure TfrmConfiguracoesResicolor.pSalvarConfs;
begin
  conf.pSetBoolean('USATIN', chkUsaRsi.Checked);
  conf.pSet('RSITRA', edtTraRsi.Text);
  conf.pSet('FATRSI', edtFatRsi.Text);
  conf.pSet('NFMRSI', edtNfmRsi.Text);
  conf.pSet('PATRSI', fraPatRsi.edtDirectory.text);
  conf.pSetDouble('DESOPE', fStrToFloat(edtDesOpe.Text));
  conf.pSetDouble('APREVE', fStrToFloat(edtApreve.Text));

  frmConfConsultaResicolor.pSalvarConfs;
end;

procedure TfrmConfiguracoesResicolor.btnGravarConfClick(Sender: TObject);
begin
  inherited;
  pSalvarConfs;
  Close;
end;

procedure TfrmConfiguracoesResicolor.btnRestaurarClick(Sender: TObject);
begin
  inherited;
  frmConfConsultaResicolor.pRestaurarPadrao;
end;

procedure TfrmConfiguracoesResicolor.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  frmConfConsultaResicolor.Free;
end;

procedure TfrmConfiguracoesResicolor.FormCreate(Sender: TObject);
begin
  inherited;
  conf := fGetConfTinta('RSI');
  tinta := fGetConsultaTinta('RSI');

  conf.pInsereCodigo('USATIN', 'Utilizar essa tinta de máquina', 'N');
  conf.pInsereCodigo('RSITRA', 'Trava de Preço', 'VEN');
  conf.pInsereCodigo('FATRSI', 'Fator da Trava', '1');
  conf.pInsereCodigo('NFMRSI', 'Próximo código', '1');
  conf.pInsereCodigo('PATRSI', 'Path para os arquivos', '\');

  conf.pInsereCodigo('DESOPE', 'Despesas Operacionais da Tinta', '0');
  conf.pInsereCodigo('APREVE', 'Acréscimo Adicional sobre Preço de Venda', '0');

  pCarregarConfs;

  frmConfConsultaResicolor := TfrmConfConsulta.Create(Self, tbsConfCampos, Canvas, tinta);
  pcgResicolor.ActivePageIndex := 0;
end;

function TfrmConfiguracoesResicolor.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If Inherited fValidaCampos(Sender, blnBuscaPorChave) Then
  Begin
    If Sender = edtTraRsi Then
    Begin
      If fEmptyStr(edtTraRsi.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'Entre com a trava para o valor de venda', ['OK']);
        Result := False;
      End
      Else If Pos(edtTraRsi.Text, '_VEN_CUS_') <= 0 Then
      Begin
        fMensagem('ATENÇÃO', 'Campo inválido!', ['OK']);
        Result := False;
      End;
    End

    Else If Sender = edtFatRsi Then
    Begin
      If fEmptyStr(edtFatRsi.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'O fator da trava deve ser preenchido!', ['OK']);
        Result := False;
      End
      Else If fStrToFloat(edtFatRsi.Text) <= 0 Then
      Begin
        fMensagem('ATENÇÃO', 'O fator da trava deve ser maior que zero!',['OK']);
        Result := False;
      End;
    End

    Else If (Sender = edtApreve) Then
    begin
      If fEmptyStr(edtApreve.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Acréscimo Adicional sobre Preço de Venda deve ser maior ou igual a Zero!', ['&Ok']);
        Result := False;
      End
      Else If fStrToFloat(edtApreve.Text) < 0.0 Then
      Begin
        fMensagem('ATENÇÃO!', 'O Acréscimo Adicional sobre Preço de Venda deve ser maior ou igual a Zero!', ['&Ok']);
        Result := False;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;


end.
