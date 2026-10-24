unit untMenuFiscalExpMFD;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, Mask, MaskEditFocus, ExtCtrls, Menus, Buttons,
  AppEvnts, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmMenuFiscalExpMFD = class(TfrmPai)
    pnlCabecalho: TPanel;
    pnlGeral: TPanel;
    rdgIntervalo: TRadioGroup;
    gpbValores: TGroupBox;
    lblFiltroIni: TLabel;
    lblFiltroFin: TLabel;
    mskFiltroIni: TMaskEditFocus;
    mskFiltroFin: TMaskEditFocus;
    btnEmitir: TBitBtnLocked;
    lblInformacoes: TLabel;
    procedure btnEmitirClick(Sender: TObject);
    procedure rdgIntervaloClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    procedure pGeraEspelhoMFD;
    procedure pGeraArquivoMFD;
  public
    { Public declarations }
    lblInfo: TLabel;
    blnEspelho: Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmMenuFiscalExpMFD: TfrmMenuFiscalExpMFD;

implementation

uses untFuncoes, untFiscal, untFuncoesSimples, StrUtils;

{$R *.dfm}

{ TfrmMenuFiscalExpMFD }

function TfrmMenuFiscalExpMFD.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (Sender = mskFiltroIni) Or
     (Sender = mskFiltroFin) Then
  Begin
    If fEmptyStr(fTiraCaracEspeciais(TMaskEditFocus(Sender).Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'As datas devem ser preenchidas.', ['&Ok']);
      Result := False;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmMenuFiscalExpMFD.btnEmitirClick(Sender: TObject);
begin
  inherited;
  If (blnEspelho) Then
    pGeraEspelhoMFD
  Else
    pGeraArquivoMFD;
end;

procedure TfrmMenuFiscalExpMFD.rdgIntervaloClick(Sender: TObject);
begin
  inherited;
  If (rdgIntervalo.ItemIndex = 0) Then
  Begin
    mskFiltroIni.EditMask   := '99/99/9999;1;_';
    mskFiltroFin.EditMask   := '99/99/9999;1;_';
    mskFiltroIni.ValidaData := True;
    mskFiltroFin.ValidaData := True;
    mskFiltroIni.Clear;
    mskFiltroFin.Clear;
  End
  Else
  Begin
    mskFiltroIni.EditMask   := '';
    mskFiltroFin.EditMask   := '';
    mskFiltroIni.ValidaData := False;
    mskFiltroFin.ValidaData := False;
    mskFiltroIni.Clear;
    mskFiltroFin.Clear;
  End;
end;

procedure TfrmMenuFiscalExpMFD.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Not Assigned(ActiveControl)) Or (ActiveControl Is TRadioButton) Then
  Begin
    If Key = VK_RETURN Then
    Begin
      SelectNext(ActiveControl, True, True);
    End
    Else If (Key = VK_ESCAPE) Then
    Begin
      btnSair.Click;
    End;
  End;
end;

procedure TfrmMenuFiscalExpMFD.FormShow(Sender: TObject);
begin
  inherited;
  If Not Assigned(lblInfo) Then
     lblInfo := lblInformacoes;
end;

procedure TfrmMenuFiscalExpMFD.pGeraEspelhoMFD;
  Var
    strTipFil: String;
    strArqSai: String;
begin
  lblInfo.Caption := 'Aguarde, gerando Espelho MFD. Esta operação pode demorar, ' +
                     'e a aplicação ficará travada. Uma luz informativa no ECF ' +
                     'ficará piscando durante o processo.';
  btnEmitir.Enabled := False;

  Application.ProcessMessages;

  strArqSai := fRetNomeArquivoPAF('EspelhoMFD');

  strTipFil := IIF(rdgIntervalo.ItemIndex = 0, 'D', 'C');
  If (VS_objFiscal.fEspelhoMFD(strTipFil, mskFiltroIni.Text, mskFiltroFin.Text, strArqSai)) Then
  Begin

    lblInfo.Caption := 'Assinando arquivo digitalmente, aguarde...';
    Application.ProcessMessages;
    pAssinarDigitalmente(AnsiString(strArqSai));

    fMensagem('ATENÇÃO!', 'Arquivo gerado com sucesso:' + #13#10 + strArqSai, ['&Ok']);
  End;

  lblInfo.Caption := '';
  btnEmitir.Enabled := True;
end;

procedure TfrmMenuFiscalExpMFD.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(TWinControl(rdgIntervalo.Controls[0]));
end;

procedure TfrmMenuFiscalExpMFD.FormCreate(Sender: TObject);
begin
  inherited;
  blnEspelho := True;
  lblInformacoes.Caption := '';
end;

procedure TfrmMenuFiscalExpMFD.pGeraArquivoMFD;
  Var
    strArqSai: String;
    strRazDocEmp: String;
    strEndereEmp: String;
    strArqAssinatura: String;
begin

  If (rdgIntervalo.ItemIndex = 1) Then
  Begin
    fMensagem('ATENÇÃO!', 'Função não suportada pelo modelo de ECF utilizado: ' +
                          'Arquivo MFD por intervalo de COO.', ['&Ok']);
    Exit;
  End;

  strRazDocEmp := fCadEmp('NOMEMP');
  strEndereEmp := fCadEmp('ENDERE') + ', ' + fCadEmp('ENDNUM');

  lblInfo.Caption := 'Aguarde, gerando Arquivo MFD. Esta operação pode demorar, ' +
                     'e a aplicação ficará travada. Uma luz informativa no ECF ' +
                     'ficará piscando durante o processo.';
  btnEmitir.Enabled := False;

  Application.ProcessMessages;

  strArqSai := fRetNomeArquivoPAF('ArqMFD', '.mfd');
  strArqAssinatura := AnsiReplaceText(strArqSai, '.mfd', '.txt');

  If (VS_objFiscal.fArquivoMFD(mskFiltroIni.Text, mskFiltroFin.Text, strArqSai,
    strRazDocEmp, strEndereEmp)) Then
  Begin
    lblInfo.Caption := 'Assinando arquivo digitalmente, aguarde...';
    Application.ProcessMessages;
    pAssinarDigitalmente(AnsiString(strArqAssinatura));

    fMensagem('ATENÇÃO!', 'Arquivo gerado com sucesso:' + #13#10 + strArqSai, ['&Ok']);
  End;

  lblInfo.Caption := '';
  btnEmitir.Enabled := True;
end;

end.
