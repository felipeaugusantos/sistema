unit untConfiguracoesNexa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, Mask,
  DirectoryEditFocus, EditFocus, StrUtils, AppEvnts, Uni,
  FilenameEditFocus, ComCtrls, Grids, ValEdit, untConfConsulta, untIConfTinta,
  untIConsultaTinta,  BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit;

type
  TfrmConfiguracoesNexa = class(TfrmPai)
    pnlCentral: TPanel;
    chkUsaNexa: TCheckBox;
    pnlCabecalho: TPanel;
    Label9: TLabel;
    Label20: TLabel;
    Label11: TLabel;
    edtTraNexa: TEditFocus;
    edtFatNexa: TEditFocus;
    Label10: TLabel;
    Label7: TLabel;
    edtGalNexa: TEditFocus;
    edtEmbNexa: TEditFocus;
    Label12: TLabel;
    Label15: TLabel;
    edtNexaVcd: TEditFocus;
    edtNexaVvd: TEditFocus;
    lbPatTxtDin: TLabel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    chkUsaFor: TCheckBox;
    edtProCod: TEditFocus;
    tbsConfCampos: TTabSheet;
    tbsEmbPMNexa: TTabSheet;
    btnGravarConf: TBitBtnLocked;
    btnRestaurar: TBitBtnLocked;
    rgVersaoArquivo: TRadioGroup;
    chkAcuAbs: TCheckBox;
    grbProVen: TGroupBox;
    Label6: TLabel;
    edtProNexa: TEditFocus;
    edtDesProNexa: TEditFocus;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edtProAcs: TEditFocus;
    edtDesProAcs: TEditFocus;
    edtProInd: TEditFocus;
    edtDesProInd: TEditFocus;
    edtProSpe: TEditFocus;
    edtDesProSpe: TEditFocus;
    edtProZyn: TEditFocus;
    edtDesProZyn: TEditFocus;
    Label5: TLabel;
    edtProEvo: TEditFocus;
    edtDesProEvo: TEditFocus;
    Label8: TLabel;
    edtProTur: TEditFocus;
    edtDesProTur: TEditFocus;
    sbComponentes: TScrollBox;
    GroupBox9: TGroupBox;
    Label42: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label59: TLabel;
    edtNexaPML2k: TEditFocus;
    edtDesNexaPML2k: TEditFocus;
    edtNexaPMLAc: TEditFocus;
    edtDesNexaPMLAc: TEditFocus;
    edtNexaPMLIn: TEditFocus;
    edtDesNexaPMLIn: TEditFocus;
    edtNexaPMLSg: TEditFocus;
    edtDesNexaPMLSg: TEditFocus;
    edtNexaPMLZy: TEditFocus;
    edtDesNexaPMLZy: TEditFocus;
    GroupBox10: TGroupBox;
    Label46: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    Label49: TLabel;
    Label60: TLabel;
    edtNexaPMG2k: TEditFocus;
    edtDesNexaPMG2k: TEditFocus;
    edtNexaPMGAc: TEditFocus;
    edtDesNexaPMGAc: TEditFocus;
    edtNexaPMGIn: TEditFocus;
    edtDesNexaPMGIn: TEditFocus;
    edtNexaPMGSg: TEditFocus;
    edtDesNexaPMGSg: TEditFocus;
    edtNexaPMGZy: TEditFocus;
    edtDesNexaPMGZy: TEditFocus;
    GroupBox11: TGroupBox;
    Label50: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    Label53: TLabel;
    Label61: TLabel;
    edtNexaPMLA2k: TEditFocus;
    edtDesNexaPMLA2k: TEditFocus;
    edtNexaPMLAAc: TEditFocus;
    edtDesNexaPMLAAc: TEditFocus;
    edtNexaPMLAIn: TEditFocus;
    edtDesNexaPMLAIn: TEditFocus;
    edtNexaPMLASg: TEditFocus;
    edtDesNexaPMLASg: TEditFocus;
    edtNexaPMLAZy: TEditFocus;
    edtDesNexaPMLAZy: TEditFocus;
    GroupBox12: TGroupBox;
    Label54: TLabel;
    Label55: TLabel;
    Label56: TLabel;
    Label57: TLabel;
    Label62: TLabel;
    edtNexaPMT2k: TEditFocus;
    edtDesNexaPMT2k: TEditFocus;
    edtNexaPMTAc: TEditFocus;
    edtDesNexaPMTAc: TEditFocus;
    edtNexaPMTin: TEditFocus;
    edtDesNexaPMTin: TEditFocus;
    edtNexaPMTSg: TEditFocus;
    edtDesNexaPMTSg: TEditFocus;
    edtNexaPMTZy: TEditFocus;
    edtDesNexaPMTZy: TEditFocus;
    edtNexaCop: TEditFocus;
    lblLazCop: TLabel;
    edtDesNexaCop: TEditFocus;
    Label13: TLabel;
    edtNexaPMLEv: TEditFocus;
    edtDesNexaPMLEv: TEditFocus;
    Label14: TLabel;
    edtNexaPMLTp: TEditFocus;
    edtDesNexaPMLTp: TEditFocus;
    edtDesNexaPMGEv: TEditFocus;
    edtNexaPMGEv: TEditFocus;
    Label16: TLabel;
    edtDesNexaPMGTp: TEditFocus;
    edtNexaPMGTp: TEditFocus;
    Label17: TLabel;
    Label18: TLabel;
    edtNexaPMLAEv: TEditFocus;
    edtDesNexaPMLAEv: TEditFocus;
    Label19: TLabel;
    edtNexaPMLATp: TEditFocus;
    edtDesNexaPMLATp: TEditFocus;
    edtDesNexaPMTEv: TEditFocus;
    edtNexaPMTEv: TEditFocus;
    Label22: TLabel;
    edtDesNexaPMTTp: TEditFocus;
    edtNexaPMTTp: TEditFocus;
    Label23: TLabel;
    Label24: TLabel;
    edtDesOpe: TEditFocus;
    Label25: TLabel;
    edtApreve: TEditFocus;
    edtPatNexaDin: TFilenameEditFocus;
    procedure FormShow(Sender: TObject);
    procedure btnGravarConfClick(Sender: TObject);
    procedure edtNexaGduKeyPress(Sender: TObject; var Key: Char);
    procedure edtProNexaKeyPress(Sender: TObject; var Key: Char);
    procedure edtNexaLAduKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnRestaurarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PageControl1Change(Sender: TObject);
    procedure edtNexaPMLduKeyPress(Sender: TObject; var Key: Char);
    procedure edtNexaPMLAduKeyPress(Sender: TObject; var Key: Char);
    procedure edtProAcsKeyPress(Sender: TObject; var Key: Char);
    procedure edtProIndKeyPress(Sender: TObject; var Key: Char);
    procedure edtProSpeKeyPress(Sender: TObject; var Key: Char);
    procedure edtProZynKeyPress(Sender: TObject; var Key: Char);
    procedure edtProEvoKeyPress(Sender: TObject; var Key: Char);
    procedure edtProTurKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }

    qryCadIte: TUniQuery;
    frmConfConsultaNexa: TfrmConfConsulta;
    tinta: IConsultaTinta;
    conf: IConfTinta;

    procedure pGravaArqIni;
    procedure pCarregaArqIni;
    procedure pRetornaDescricaoItem(edtCodIte: TEdit);
    procedure pRetornaDescricaoItem3(edtCodIte: TEdit);
    procedure pRetornaDescricaoItem4(edtCodIte: TEdit);
    procedure pConsultaItem(edtItem, edtDesIte: TEdit);
    function fGetEdtDescri(edtCod: TEdit): TEdit;

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

var
  frmConfiguracoesNexa: TfrmConfiguracoesNexa;

implementation

uses untFuncoes,
    untFuncTinta, untFuncoesSimples, untTypesSistema, untConsultas;

{$R *.dfm}

{ TfrmConfiguracoesNexa }

function TfrmConfiguracoesNexa.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    edtDesIte: TEdit;
begin

  Result := True;

  If (Sender = edtProNexa) Or
     (Sender = edtProAcs) Or
     (Sender = edtProInd) Or
     (Sender = edtProSpe) Or
     (Sender = edtProZyn) Or
     (Sender = edtProEvo) Or
     (Sender = edtProTur) Then
  Begin
    If (fEmptyStr(TEditFocus(Sender).Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O produto para venda deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else
    Begin
      pRetornaDescricaoItem(TEdit(Sender));
      If (fEmptyStr(fGetEdtDescri(TEdit(Sender)).Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse produto não está cadastrado!', ['&Ok']);
        Result := False;
      End;
    End;
  End

  Else If (Sender = edtTraNexa) Then
  Begin
    If (fEmptyStr(edtTraNexa.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A trava para valor de venda deve ser preenchida!', ['&Ok']);
      Result := False;
    End
    Else If Length(edtTraNexa.Text) <> 3 Then
    Begin
      fMensagem('ATENÇÃO!', 'O campo da trava deve ter exatamente 3 caracteres!', ['&Ok']);
      Result := False;
    End
    Else If Pos(edtTraNexa.Text, 'VEN_CUS_') <= 0 Then
    Begin
      fMensagem('ATENÇÃO!', 'Campo inválido ou inexistente!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = edtFatNexa) Then
  Begin
    If (fEmptyStr(edtFatNexa.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O fator para trava deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If fStrToFloat(edtFatNexa.Text) <= 0.0 Then
    Begin
      fMensagem('ATENÇÃO!', 'O Fator da trava deve ser maior que Zero!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = edtNexaVvd) Then
  Begin
    If (fEmptyStr(edtNexaVvd.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Valor de venda litro diluente deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If fStrToFloat(edtNexaVvd.Text) < 0.0 Then
    Begin
      fMensagem('ATENÇÃO!', 'O Valor de venda litro diluente deve ser maior ou igual a Zero!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = edtNexaVcd) Then
  Begin
    If (fEmptyStr(edtNexaVcd.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Valor de custo litro diluente deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If fStrToFloat(edtNexaVcd.Text) < 0.0 Then
    Begin
      fMensagem('ATENÇÃO!', 'O Valor de custo litro diluente deve ser maior ou igual a Zero!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = edtEmbNexa) Then
  Begin
    If (fEmptyStr(edtEmbNexa.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O preço de Embalagem deve ser preenchido!', ['&O k']);
      Result := False;
    End
    Else If (fStrToFloat(edtEmbNexa.Text) < 0.0) Then
    Begin
      fMensagem('ATENÇÃO!', 'O preço de Embalagem deve ser maior ou igual a Zero!', ['&O k']);
      Result := False;
    End;
  End

  Else If (Sender = edtGalNexa) Then
  Begin
    If (fEmptyStr(edtGalNexa.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O preço do Galão deve ser preenchido!', ['&O k']);
      Result := False;
    End
    Else If (fStrToFloat(edtGalNexa.Text) < 0.0) Then
    Begin
      fMensagem('ATENÇÃO!', 'O preço do Galão deve ser maior ou igual a Zero!', ['&O k']);
      Result := False;
    End;
  End

  Else If (Sender = edtPatNexaDin) Then
  Begin
    edtPatNexaDin.Text := AnsiDequotedStr(edtPatNexaDin.Text, '"');
    If (not fEmptyStr(edtPatNexaDin.Text)) Then
    Begin
      edtPatNexaDin.Text := AnsiDequotedStr(edtPatNexaDin.Text, '"');

      if (rgVersaoArquivo.ItemIndex + 1) >= 2 then
      begin
        if not FileExists(edtPatNexaDin.Text) then
        begin
          fMensagem('ATENÇÃO!', 'O arquivo não existe!', ['&Ok']);
          Result := False;
        end;
      end
      else
      begin
        if not DirectoryExists(edtPatNexaDin.Text) then
        begin
          fMensagem('ATENÇÃO!', 'O path para os arquivos Txt não existe!', ['&Ok']);
          Result := False;
        end;
      end;
    End;

  End

  Else If (   (Sender = edtNexaPMG2k) Or
              (Sender = edtNexaPMGAc) Or
              (Sender = edtNexaPMGIn) Or
              (Sender = edtNexaPMGSg) Or
              (Sender = edtNexaPMGZy) Or
              (Sender = edtNexaPMGEv) Or
              (Sender = edtNexaPMGTp) Or
              (Sender = edtNexaPML2k) Or
              (Sender = edtNexaPMLAc) Or
              (Sender = edtNexaPMLIn) Or
              (Sender = edtNexaPMLSg) Or
              (Sender = edtNexaPMLZy) Or
              (Sender = edtNexaPMLEv) Or
              (Sender = edtNexaPMLTp) Or
              (Sender = edtNexaPMT2k) Or
              (Sender = edtNexaPMTAc) Or
              (Sender = edtNexaPMTin) Or
              (Sender = edtNexaPMTSg) Or
              (Sender = edtNexaPMTZy) Or
              (Sender = edtNexaPMTEv) Or
              (Sender = edtNexaPMTTp) ) Then

  Begin

    If Not (fEmptyStr(TEdit(Sender).Text)) Then
    Begin
      pRetornaDescricaoItem3(TEdit(Sender));
      edtDesIte := TEdit(FindComponent('edtDes' + RightStr(TEdit(Sender).Name, 9)));
      If (fEmptyStr(edtDesIte.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse item não está cadastrado!', ['&Ok']);
        Result := False;
      End;
    End;

  End
  Else If (   (Sender = edtNexaPMLA2k) Or
              (Sender = edtNexaPMLAAc) Or
              (Sender = edtNexaPMLAIn) Or
              (Sender = edtNexaPMLASg) Or
              (Sender = edtNexaPMLAZy) Or
              (Sender = edtNexaPMLAEv) Or
              (Sender = edtNexaPMLATp) ) Then
  Begin

    If Not (fEmptyStr(TEdit(Sender).Text)) Then
    Begin
      pRetornaDescricaoItem4(TEdit(Sender));
      edtDesIte := TEdit(FindComponent('edtDes' + RightStr(TEdit(Sender).Name, 10)));
      If (fEmptyStr(edtDesIte.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse item não está cadastrado!', ['&Ok']);
        Result := False;
      End;
    End;

  End

  Else If (Sender = edtDesOpe) Then
  begin
    If fEmptyStr(edtDesOpe.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'A Despesa Operacional deve ser maior ou igual a Zero!', ['&Ok']);
      Result := False;
    End
    Else If fStrToFloat(edtDesOpe.Text) < 0.0 Then
    Begin
      fMensagem('ATENÇÃO!', 'A Despesa Operacional deve ser maior ou igual a Zero!', ['&Ok']);
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
  End


end;

procedure TfrmConfiguracoesNexa.PageControl1Change(Sender: TObject);
begin
  inherited;
  btnRestaurar.Visible := (PageControl1.ActivePage = tbsConfCampos);
end;

procedure TfrmConfiguracoesNexa.pCarregaArqIni;
begin
  {*****************************************}
  {* GRAVA DADOS DA Nexa                    *}
  {**************************************AC*}

  chkUsaNexa.Checked := conf.fGetBoolean('USATIN');

  //PRODUTOS VENDA
  edtProNexa.Text := conf.fGet('PRONEXA');
  edtProAcs.Text  := IfThen(conf.fGet('PROACS') = '', conf.fGet('PRONEXA'), conf.fGet('PROACS'));
  edtProInd.Text  := IfThen(conf.fGet('PROIND') = '', conf.fGet('PRONEXA'), conf.fGet('PROIND'));
  edtProSpe.Text  := IfThen(conf.fGet('PROSPE') = '', conf.fGet('PRONEXA'), conf.fGet('PROSPE'));
  edtProZyn.Text  := IfThen(conf.fGet('PROZYN') = '', conf.fGet('PRONEXA'), conf.fGet('PROZYN'));
  edtProEvo.Text  := IfThen(conf.fGet('PROEVO') = '', conf.fGet('PRONEXA'), conf.fGet('PROEVO'));
  edtProTur.Text  := IfThen(conf.fGet('PROTUR') = '', conf.fGet('PRONEXA'), conf.fGet('PROTUR'));

  edtTraNexa.Text := conf.fGet('TRANEXA');
  edtFatNexa.Text := conf.fGet('FATNEXA');
  edtEmbNexa.Text := conf.fGet('EMBNEXA');
  edtGalNexa.Text := conf.fGet('GALNEXA');

  //PAINT MANAGER - NEXA
  edtNexaPMG2k.Text := conf.fGet('NEXAPMG2K');
  edtNexaPMGAc.Text := conf.fGet('NEXAPMGAC');
  edtNexaPMGIn.Text := conf.fGet('NEXAPMGIN');
  edtNexaPMGSg.Text := conf.fGet('NEXAPMGSG');
  edtNexaPMGZy.Text := conf.fGet('NEXAPMGZY');
  edtNexaPMGEv.Text := conf.fGet('NEXAPMGEV');
  edtNexaPMGTp.Text := conf.fGet('NEXAPMGTP');

  edtNexaPML2k.Text := conf.fGet('NEXAPML2K');
  edtNexaPMLAc.Text := conf.fGet('NEXAPMLAC');
  edtNexaPMLIn.Text := conf.fGet('NEXAPMLIN');
  edtNexaPMLSg.Text := conf.fGet('NEXAPMLSG');
  edtNexaPMLZy.Text := conf.fGet('NEXAPMLZY');
  edtNexaPMLEv.Text := conf.fGet('NEXAPMLEV');
  edtNexaPMLTp.Text := conf.fGet('NEXAPMLTP');

  edtNexaPMLA2k.Text := conf.fGet('NEXAPMLA2K');
  edtNexaPMLAAc.Text := conf.fGet('NEXAPMLAAC');
  edtNexaPMLAIn.Text := conf.fGet('NEXAPMLAIN');
  edtNexaPMLASg.Text := conf.fGet('NEXAPMLASG');
  edtNexaPMLAZy.Text := conf.fGet('NEXAPMLAZY');
  edtNexaPMLAEv.Text := conf.fGet('NEXAPMLAEV');
  edtNexaPMLATp.Text := conf.fGet('NEXAPMLATP');

  edtNexaPMT2k.Text := conf.fGet('NEXAPMT2K');
  edtNexaPMTAc.Text := conf.fGet('NEXAPMTAC');
  edtNexaPMTin.Text := conf.fGet('NEXAPMTIN');
  edtNexaPMTSg.Text := conf.fGet('NEXAPMTSG');
  edtNexaPMTZy.Text := conf.fGet('NEXAPMTZY');
  edtNexaPMTEv.Text := conf.fGet('NEXAPMTEV');
  edtNexaPMTTp.Text := conf.fGet('NEXAPMTTP');
  //

  edtNexaVvd.Text := conf.fGet('PATVVD');
  edtNexaVcd.Text := conf.fGet('PATVCD');
  edtPatNexaDin.Text := conf.fGet('PATNEXA');

  chkUsaFor.Checked := conf.fGetBoolean('USAFOR');
  chkAcuAbs.Checked := conf.fGetInteger('ACUABS') = 1;

  edtProCod.Text := conf.fGet('PROCOD');
  rgVersaoArquivo.ItemIndex := conf.fGetInteger('VERARQ') - 1;

  edtNexaCop.Text := conf.fGet('NEXACOP');

  edtDesOpe.Text := conf.fGet('DESOPE');
  edtApreve.Text := conf.fGet('APREVE');

  {*******************************************}
  {* GRUPOS DOS ITENS                        *}
  {****************************************MV*}

  pRetornaDescricaoItem(edtProNexa);
  pRetornaDescricaoItem(edtProAcs);
  pRetornaDescricaoItem(edtProInd);
  pRetornaDescricaoItem(edtProSpe);
  pRetornaDescricaoItem(edtProZyn);
  pRetornaDescricaoItem(edtProEvo);
  pRetornaDescricaoItem(edtProTur);

  //PAINT MANAGER - NEXA
  pRetornaDescricaoItem3(edtNexaPMG2k);
  pRetornaDescricaoItem3(edtNexaPMGAc);
  pRetornaDescricaoItem3(edtNexaPMGIn);
  pRetornaDescricaoItem3(edtNexaPMGSg);
  pRetornaDescricaoItem3(edtNexaPMGZy);
  pRetornaDescricaoItem3(edtNexaPMGEv);
  pRetornaDescricaoItem3(edtNexaPMGTp);

  pRetornaDescricaoItem3(edtNexaPML2k);
  pRetornaDescricaoItem3(edtNexaPMLAc);
  pRetornaDescricaoItem3(edtNexaPMLIn);
  pRetornaDescricaoItem3(edtNexaPMLSg);
  pRetornaDescricaoItem3(edtNexaPMLZy);
  pRetornaDescricaoItem3(edtNexaPMLEv);
  pRetornaDescricaoItem3(edtNexaPMLTp);

  pRetornaDescricaoItem4(edtNexaPMLA2k);
  pRetornaDescricaoItem4(edtNexaPMLAAc);
  pRetornaDescricaoItem4(edtNexaPMLAIn);
  pRetornaDescricaoItem4(edtNexaPMLASg);
  pRetornaDescricaoItem4(edtNexaPMLAZy);
  pRetornaDescricaoItem4(edtNexaPMLAEv);
  pRetornaDescricaoItem4(edtNexaPMLATp);

  pRetornaDescricaoItem3(edtNexaPMT2k);
  pRetornaDescricaoItem3(edtNexaPMTAc);
  pRetornaDescricaoItem3(edtNexaPMTin);
  pRetornaDescricaoItem3(edtNexaPMTSg);
  pRetornaDescricaoItem3(edtNexaPMTZy);
  pRetornaDescricaoItem3(edtNexaPMTEv);
  pRetornaDescricaoItem3(edtNexaPMTTp);
  //

  pRetornaDescricaoItem(edtNexaCop);

end;

procedure TfrmConfiguracoesNexa.pConsultaItem(edtItem, edtDesIte: TEdit);
  Var
    arrSel: TConsultasArray;
    Key: Char;
begin
  Key := '/';
  if fPesqItem(conIteSimples, Self, edtItem, edtDesIte, nil, Key, arrSel) Then
    SelectNext(ActiveControl, True, True);
end;

procedure TfrmConfiguracoesNexa.pGravaArqIni;
begin
  {*****************************************}
  {* GRAVA DADOS DA Nexa                    *}
  {**************************************AC*}

  conf.pSetBoolean('USATIN', chkUsaNexa.Checked);

  //PRODUTOS VENDA
  conf.pSet('PRONEXA', edtProNexa.Text);
  conf.pSet('PROACS',  edtProAcs.Text);
  conf.pSet('PROIND',  edtProInd.Text);
  conf.pSet('PROSPE',  edtProSpe.Text);
  conf.pSet('PROZYN',  edtProZyn.Text);
  conf.pSet('PROEVO',  edtProEvo.Text);
  conf.pSet('PROTUR',  edtProTur.Text);

  conf.pSet('TRANEXA', edtTraNexa.Text);
  conf.pSet('FATNEXA', edtFatNexa.Text);
  conf.pSet('EMBNEXA', edtEmbNexa.Text);
  conf.pSet('GALNEXA', edtGalNexa.Text);
  conf.pSet('PATNEXA', edtPatNexaDin.Text);


  //PAINT MANAGER - NEXA

  conf.pSet('NEXAPMG2K', edtNexaPMG2k.Text);
  conf.pSet('NEXAPMGAC', edtNexaPMGAc.Text);
  conf.pSet('NEXAPMGIN', edtNexaPMGIn.Text);
  conf.pSet('NEXAPMGSG', edtNexaPMGSg.Text);
  conf.pSet('NEXAPMGZY', edtNexaPMGZy.Text);
  conf.pSet('NEXAPMGEV', edtNexaPMGEv.Text);
  conf.pSet('NEXAPMGTP', edtNexaPMGTp.Text);

  conf.pSet('NEXAPML2K', edtNexaPML2k.Text);
  conf.pSet('NEXAPMLAC', edtNexaPMLAc.Text);
  conf.pSet('NEXAPMLIN', edtNexaPMLIn.Text);
  conf.pSet('NEXAPMLSG', edtNexaPMLSg.Text);
  conf.pSet('NEXAPMLZY', edtNexaPMLZy.Text);
  conf.pSet('NEXAPMLEV', edtNexaPMLEv.Text);
  conf.pSet('NEXAPMLTP', edtNexaPMLTp.Text);

  conf.pSet('NEXAPMLA2K', edtNexaPMLA2k.Text);
  conf.pSet('NEXAPMLAAC', edtNexaPMLAAc.Text);
  conf.pSet('NEXAPMLAIN', edtNexaPMLAIn.Text);
  conf.pSet('NEXAPMLASG', edtNexaPMLASg.Text);
  conf.pSet('NEXAPMLAZY', edtNexaPMLAZy.Text);
  conf.pSet('NEXAPMLAEV', edtNexaPMLAEv.Text);
  conf.pSet('NEXAPMLATP', edtNexaPMLATp.Text);

  conf.pSet('NEXAPMT2K', edtNexaPMT2k.Text);
  conf.pSet('NEXAPMTAC', edtNexaPMTAc.Text);
  conf.pSet('NEXAPMTIN', edtNexaPMTin.Text);
  conf.pSet('NEXAPMTSG', edtNexaPMTSg.Text);
  conf.pSet('NEXAPMTZY', edtNexaPMTZy.Text);
  conf.pSet('NEXAPMTEV', edtNexaPMTEv.Text);
  conf.pSet('NEXAPMTTP', edtNexaPMTTp.Text);
  //

  conf.pSet('PATVVD', edtNexaVvd.Text);
  conf.pSet('PATVCD', edtNexaVcd.Text);

  conf.pSet('NEXACOP', edtNexaCop.Text);

  conf.pSetDouble('DESOPE', fStrToFloat(edtDesOpe.Text));
  conf.pSetDouble('APREVE', fStrToFloat(edtApreve.Text));

  {*******************************************}
  {* GRUPOS DOS ITENS                        *}
  {****************************************AC*}

  //PAINT MANAGER - NEXA
  conf.pSet('G_NEXAPMG2K', fRetornaGrupoItem(edtNexaPMG2k.Text));
  conf.pSet('G_NEXAPMGAC', fRetornaGrupoItem(edtNexaPMGAc.Text));
  conf.pSet('G_NEXAPMGIN', fRetornaGrupoItem(edtNexaPMGIn.Text));
  conf.pSet('G_NEXAPMGSG', fRetornaGrupoItem(edtNexaPMGSg.Text));
  conf.pSet('G_NEXAPMGZY', fRetornaGrupoItem(edtNexaPMGZy.Text));
  conf.pSet('G_NEXAPMGEV', fRetornaGrupoItem(edtNexaPMGEv.Text));
  conf.pSet('G_NEXAPMGTP', fRetornaGrupoItem(edtNexaPMGTp.Text));
  conf.pSet('G_NEXAPML2K', fRetornaGrupoItem(edtNexaPML2k.Text));
  conf.pSet('G_NEXAPMLAC', fRetornaGrupoItem(edtNexaPMLAc.Text));
  conf.pSet('G_NEXAPMLIN', fRetornaGrupoItem(edtNexaPMLIn.Text));
  conf.pSet('G_NEXAPMLSG', fRetornaGrupoItem(edtNexaPMLSg.Text));
  conf.pSet('G_NEXAPMLZY', fRetornaGrupoItem(edtNexaPMLZy.Text));
  conf.pSet('G_NEXAPMLEV', fRetornaGrupoItem(edtNexaPMLEv.Text));
  conf.pSet('G_NEXAPMLTP', fRetornaGrupoItem(edtNexaPMLTp.Text));
  //

  conf.pSetBoolean('USAFOR',chkUsaFor.Checked);
  conf.pSetInteger('ACUABS', IIF(chkAcuAbs.Checked, 1, 2));
  conf.pSet('PROCOD', edtProCod.Text);
  conf.pSetInteger('VERARQ', rgVersaoArquivo.ItemIndex + 1);
  
  frmConfConsultaNexa.pSalvarConfs;
end;

procedure TfrmConfiguracoesNexa.pRetornaDescricaoItem(edtCodIte: TEdit);
  Var
    strNomEdt: String;
    edtDesIte: TEdit;
    intTamanho: Integer;
begin
  intTamanho := IIF(Length(edtCodIte.Name) = 10,7,6);
  strNomEdt := 'edtDes' + RightStr(edtCodIte.Name, intTamanho);
  edtDesIte := TEdit(FindComponent(strNomEdt));
  edtDesIte.Text := fRetNomProduto(edtCodIte.Text);
end;

procedure TfrmConfiguracoesNexa.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  frmConfConsultaNexa.Free;
end;

procedure TfrmConfiguracoesNexa.FormCreate(Sender: TObject);
begin
  inherited;
  conf  := fGetConfTinta('NEX');
  tinta := fGetConsultaTinta('NEX');

  {*****************************************}
  {* CRIA AS CONFIGURACOES CASO NAO EXISTA *}
  {**************************************AC*}

  conf.pInsereCodigo('USATIN', 'Utilizar essa tinta de máquina', fArqIniTinta(0, 'NEXA AUTOCOLOR', 'USATIN', ''));


  //PRODUTOS VENDA
  conf.pInsereCodigo('PRONEXA', 'Produto para venda 2K', fArqIniTinta(0, 'NEXA AUTOCOLOR', 'PRONEXA', ''));
  conf.pInsereCodigo('PROACS',  'Produto para venda ACS', fArqIniTinta(0, 'NEXA AUTOCOLOR', 'PRONEXA', ''));
  conf.pInsereCodigo('PROIND',  'Produto para venda Industran', fArqIniTinta(0, 'NEXA AUTOCOLOR', 'PRONEXA', ''));
  conf.pInsereCodigo('PROSPE',  'Produto para venda Spectral Grey', fArqIniTinta(0, 'NEXA AUTOCOLOR', 'PRONEXA', ''));
  conf.pInsereCodigo('PROZYN',  'Produto para venda Zynamix', fArqIniTinta(0, 'NEXA AUTOCOLOR', 'PRONEXA', ''));
  conf.pInsereCodigo('PROEVO',  'Produto para venda ACS Evolution', fArqIniTinta(0, 'NEXA AUTOCOLOR', 'PRONEXA', ''));
  conf.pInsereCodigo('PROTUR',  'Produto para venda Turbo Plus', fArqIniTinta(0, 'NEXA AUTOCOLOR', 'PRONEXA', ''));

  conf.pInsereCodigo('TRANEXA', 'Trava para valor de venda Nexa_PRE', fArqIniTinta(0, 'NEXA AUTOCOLOR', 'TRANEXA', ''));
  conf.pInsereCodigo('FATNEXA', 'Fator', fArqIniTinta(0, 'NEXA AUTOCOLOR', 'FATNEXA', ''));
  conf.pInsereCodigo('EMBNEXA', 'Preço de embalagem', fArqIniTinta(0, 'NEXA AUTOCOLOR', 'EMBNEXA', ''));
  conf.pInsereCodigo('GALNEXA', 'Preço de galão', fArqIniTinta(0, 'NEXA AUTOCOLOR', 'GALNEXA', ''));
  conf.pInsereCodigo('PATNEXA', 'Path para arquivos (*.txt)', fArqIniTinta(0, 'NEXA AUTOCOLOR', 'PATNEXA', ''));

  //PAINT MANAGER - NEXA
  conf.pInsereCodigo('NEXAPMG2K', 'Embalagem Galão 2K', fArqIniTinta(0, 'NEXA AUTOCOLOR', 'NEXAPMG2K', ''));
  conf.pInsereCodigo('NEXAPMGAC', 'Embalagem Galão ACS', fArqIniTinta(0, 'NEXA AUTOCOLOR', 'NEXAPMGAC', ''));
  conf.pInsereCodigo('NEXAPMGIN', 'Embalagem Galão Industran', fArqIniTinta(0, 'NEXA AUTOCOLOR', 'NEXAPMGIN', ''));
  conf.pInsereCodigo('NEXAPMGSG', 'Embalagem Galão Spectral grey', fArqIniTinta(0, 'NEXA AUTOCOLOR', 'NEXAPMGSG', ''));
  conf.pInsereCodigo('NEXAPMGZY', 'Embalagem Galão Zynamix', fArqIniTinta(0, 'NEXA AUTOCOLOR', 'NEXAPMGZY', ''));
  conf.pInsereCodigo('NEXAPMGEV', 'Embalagem Galão ACS Evolution ', fArqIniTinta(0, 'NEXA AUTOCOLOR', 'NEXAPMGEV', ''));
  conf.pInsereCodigo('NEXAPMGTP', 'Embalagem Galão Turbo Plus', fArqIniTinta(0, 'NEXA AUTOCOLOR', 'NEXAPMGTP', ''));
  conf.pInsereCodigo('NEXAPML2K', 'Embalagem Litro 2K', fArqIniTinta(0, 'NEXA AUTOCOLOR', 'NEXAPML2K', ''));
  conf.pInsereCodigo('NEXAPMLAC', 'Embalagem Litro ACS', fArqIniTinta(0, 'NEXA AUTOCOLOR', 'NEXAPMLAC', ''));
  conf.pInsereCodigo('NEXAPMLIN', 'Embalagem Litro Industran', fArqIniTinta(0, 'NEXA AUTOCOLOR', 'NEXAPMLIN', ''));
  conf.pInsereCodigo('NEXAPMLSG', 'Embalagem Litro Spectral grey', fArqIniTinta(0, 'NEXA AUTOCOLOR', 'NEXAPMLSG', ''));
  conf.pInsereCodigo('NEXAPMLZY', 'Embalagem Litro Zynamix', fArqIniTinta(0, 'NEXA AUTOCOLOR', 'NEXAPMLZY', ''));
  conf.pInsereCodigo('NEXAPMLEV', 'Embalagem Litro ACS Evolution ', fArqIniTinta(0, 'NEXA AUTOCOLOR', 'NEXAPMLEV', ''));
  conf.pInsereCodigo('NEXAPMLTP', 'Embalagem Litro Turbo Plus', fArqIniTinta(0, 'NEXA AUTOCOLOR', 'NEXAPMLTP', ''));
  conf.pInsereCodigo('NEXAPMLA2K', 'Embalagem Balde 2K', fArqIniTinta(0, 'NEXA AUTOCOLOR', 'NEXAPMLA2K', ''));
  conf.pInsereCodigo('NEXAPMLAAC', 'Embalagem Balde ACS', fArqIniTinta(0, 'NEXA AUTOCOLOR', 'NEXAPMLAAC', ''));
  conf.pInsereCodigo('NEXAPMLAIN', 'Embalagem Balde Industran', fArqIniTinta(0, 'NEXA AUTOCOLOR', 'NEXAPMLAIN', ''));
  conf.pInsereCodigo('NEXAPMLASG', 'Embalagem Balde Spectral grey', fArqIniTinta(0, 'NEXA AUTOCOLOR', 'NEXAPMLASG', ''));
  conf.pInsereCodigo('NEXAPMLAZY', 'Embalagem Balde Zynamix', fArqIniTinta(0, 'NEXA AUTOCOLOR', 'NEXAPMLAZY', ''));
  conf.pInsereCodigo('NEXAPMLAEV', 'Embalagem Balde ACS Evolution', fArqIniTinta(0, 'NEXA AUTOCOLOR', 'NEXAPMLAEV', ''));
  conf.pInsereCodigo('NEXAPMLATP', 'Embalagem Balde Turbo Plus', fArqIniTinta(0, 'NEXA AUTOCOLOR', 'NEXAPMLATP', ''));
  conf.pInsereCodigo('NEXAPMT2K', 'Embalagem Tambor 2K', fArqIniTinta(0, 'NEXA AUTOCOLOR', 'NEXAPMT2K', ''));
  conf.pInsereCodigo('NEXAPMTAC', 'Embalagem Tambor ACS', fArqIniTinta(0, 'NEXA AUTOCOLOR', 'NEXAPMTAC', ''));
  conf.pInsereCodigo('NEXAPMTIN', 'Embalagem Tambor Industran', fArqIniTinta(0, 'NEXA AUTOCOLOR', 'NEXAPMTIN', ''));
  conf.pInsereCodigo('NEXAPMTSG', 'Embalagem Tambor Spectral grey', fArqIniTinta(0, 'NEXA AUTOCOLOR', 'NEXAPMTSG', ''));
  conf.pInsereCodigo('NEXAPMTZY', 'Embalagem Tambor Zynamix', fArqIniTinta(0, 'NEXA AUTOCOLOR', 'NEXAPMTZY', ''));
  conf.pInsereCodigo('NEXAPMTEV', 'Embalagem Tambor ACS Evolution', fArqIniTinta(0, 'NEXA AUTOCOLOR', 'NEXAPMTEV', ''));
  conf.pInsereCodigo('NEXAPMTTP', 'Embalagem Tambor Turbo Plus', fArqIniTinta(0, 'NEXA AUTOCOLOR', 'NEXAPMTTP', ''));
  //

  conf.pInsereCodigo('PATNEXA', 'Path para arquivos (*.txt)', fArqIniTinta(0, 'NEXA AUTOCOLOR', 'PATNEXA', ''));
  conf.pInsereCodigo('PATVVD', 'Valor de venda litro diluente', fArqIniTinta(0, 'NEXA AUTOCOLOR', 'PATVVD', ''));
  conf.pInsereCodigo('PATVCD', 'Valor de custo litro diluente', fArqIniTinta(0, 'NEXA AUTOCOLOR', 'PATVCD', ''));
  conf.pInsereCodigo('USAFOR', 'Utilizar formulação', fArqIniTinta(0, 'USA_FORMUL', 'NEXA AUTOCOLOR', 'S'));
  conf.pInsereCodigo('PROCOD', 'Próximo Código Novas Fórmulas', fArqIniTinta(0, 'NEXA AUTOCOLOR', 'PROCOD', ''));
  conf.pInsereCodigo('NEXACOP', 'Embalagem copo', fArqIniTinta(0, 'NEXA AUTOCOLOR', 'NEXACOP', ''));

  conf.pInsereCodigo('DESOPE', 'Despesas Operacionais da Tinta', '0');
  conf.pInsereCodigo('APREVE', 'Acréscimo Adicional sobre Preço de Venda', '0');

  {*******************************************}
  {* GRUPOS DOS ITENS                        *}
  {****************************************AC*}


  //PAINT MANAGER - NEXA
  conf.pInsereCodigo('G_NEXAPMG2K', 'Grupo item Embalagem Galão 2K', fRetornaGrupoItem(fArqIniTinta(0, 'NEXA AUTOCOLOR', 'NEXAPMG2K', '')));
  conf.pInsereCodigo('G_NEXAPMGAC', 'Grupo item Embalagem Galão ACS', fRetornaGrupoItem(fArqIniTinta(0, 'NEXA AUTOCOLOR', 'NEXAPMGAC', '')));
  conf.pInsereCodigo('G_NEXAPMGIN', 'Grupo item Embalagem Galão Industran', fRetornaGrupoItem(fArqIniTinta(0, 'NEXA AUTOCOLOR', 'NEXAPMGIN', '')));
  conf.pInsereCodigo('G_NEXAPMGSG', 'Grupo item Embalagem Galão Spectral grey', fRetornaGrupoItem(fArqIniTinta(0, 'NEXA AUTOCOLOR', 'NEXAPMGSG', '')));
  conf.pInsereCodigo('G_NEXAPMGZY', 'Grupo item Embalagem Galão Zynamix', fRetornaGrupoItem(fArqIniTinta(0, 'NEXA AUTOCOLOR', 'NEXAPMGZY', '')));
  conf.pInsereCodigo('G_NEXAPMGEV', 'Grupo item Embalagem Galão ACS Evolution ', fRetornaGrupoItem(fArqIniTinta(0, 'NEXA AUTOCOLOR', 'NEXAPMGEV', '')));
  conf.pInsereCodigo('G_NEXAPMGTP', 'Grupo item Embalagem Galão Turbo Plus', fRetornaGrupoItem(fArqIniTinta(0, 'NEXA AUTOCOLOR', 'NEXAPMGTP', '')));
  conf.pInsereCodigo('G_NEXAPML2K', 'Grupo item Embalagem Litro 2K', fRetornaGrupoItem(fArqIniTinta(0, 'NEXA AUTOCOLOR', 'NEXAPML2K', '')));
  conf.pInsereCodigo('G_NEXAPMLAC', 'Grupo item Embalagem Litro ACS', fRetornaGrupoItem(fArqIniTinta(0, 'NEXA AUTOCOLOR', 'NEXAPMLAC', '')));
  conf.pInsereCodigo('G_NEXAPMLIN', 'Grupo item Embalagem Litro Industran', fRetornaGrupoItem(fArqIniTinta(0, 'NEXA AUTOCOLOR', 'NEXAPMLIN', '')));
  conf.pInsereCodigo('G_NEXAPMLSG', 'Grupo item Embalagem Litro Spectral grey', fRetornaGrupoItem(fArqIniTinta(0, 'NEXA AUTOCOLOR', 'NEXAPMLSG', '')));
  conf.pInsereCodigo('G_NEXAPMLZY', 'Grupo item Embalagem Litro Zynamix', fRetornaGrupoItem(fArqIniTinta(0, 'NEXA AUTOCOLOR', 'NEXAPMLZY', '')));
  conf.pInsereCodigo('G_NEXAPMLEV', 'Grupo item Embalagem Litro ACS Evolution', fRetornaGrupoItem(fArqIniTinta(0, 'NEXA AUTOCOLOR', 'NEXAPMLEV', '')));
  conf.pInsereCodigo('G_NEXAPMLTP', 'Grupo item Embalagem Litro Turbo Plus', fRetornaGrupoItem(fArqIniTinta(0, 'NEXA AUTOCOLOR', 'NEXAPMLTP', '')));

  conf.pInsereCodigo('VERARQ', 'Versão do arquivo de geração PPG', '1');
  conf.pInsereCodigo('ACUABS', 'Formulação Acumulada Absoluta', '2');
  //

  PageControl1.ActivePageIndex := 0;
  frmConfConsultaNexa := TfrmConfConsulta.Create(Self, tbsConfCampos, Canvas, tinta);
end;

procedure TfrmConfiguracoesNexa.FormShow(Sender: TObject);
begin
  inherited;
  pCarregaArqIni;
  qryCadIte := fCriaQuery(Self);
end;

procedure TfrmConfiguracoesNexa.btnGravarConfClick(Sender: TObject);
begin
  inherited;
  If (fVerificaCampos) Then
  Begin
    pGravaArqIni;
    Close;
  End;
end;

procedure TfrmConfiguracoesNexa.edtNexaGduKeyPress(Sender: TObject;
  var Key: Char);
  Var
    edtDesEdt: TEdit;
begin
  inherited;
  If (fEntraCons(Key)) Then
  Begin
    edtDesEdt := TEdit(FindComponent('edtDes' + RightStr(TEdit(Sender).Name, 6)));
    pConsultaItem(TEdit(Sender), edtDesEdt);
  End;
end;

procedure TfrmConfiguracoesNexa.edtProAcsKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If (fEntraCons(Key)) Then
  Begin
    pConsultaItem(TEdit(Sender), edtDesProAcs);
  End;

end;

procedure TfrmConfiguracoesNexa.edtProEvoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If (fEntraCons(Key)) Then
  Begin
    pConsultaItem(TEdit(Sender), edtDesProEvo);
  End;

end;

procedure TfrmConfiguracoesNexa.edtProIndKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If (fEntraCons(Key)) Then
  Begin
    pConsultaItem(TEdit(Sender), edtDesProInd);
  End;
end;

procedure TfrmConfiguracoesNexa.edtProNexaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If (fEntraCons(Key)) Then
  Begin
    pConsultaItem(TEdit(Sender), edtDesProNexa);
  End;

end;

procedure TfrmConfiguracoesNexa.edtProSpeKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If (fEntraCons(Key)) Then
  Begin
    pConsultaItem(TEdit(Sender), edtDesProSpe);
  End;
end;

procedure TfrmConfiguracoesNexa.edtProTurKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If (fEntraCons(Key)) Then
  Begin
    pConsultaItem(TEdit(Sender), edtDesProTur);
  End;

end;

procedure TfrmConfiguracoesNexa.edtProZynKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If (fEntraCons(Key)) Then
  Begin
    pConsultaItem(TEdit(Sender), edtDesProZyn);
  End;
end;

function TfrmConfiguracoesNexa.fGetEdtDescri(edtCod: TEdit): TEdit;
var
  strNome: string;
begin
  strNome := edtCod.Name;
  Insert('Des', strNome, 4);
  Result := TEdit(FindComponent(strNome));
end;

procedure TfrmConfiguracoesNexa.btnRestaurarClick(Sender: TObject);
begin
  inherited;
  frmConfConsultaNexa.pRestaurarPadrao;
end;

procedure TfrmConfiguracoesNexa.edtNexaLAduKeyPress(Sender: TObject;
  var Key: Char);
  Var
    edtDesEdt: TEdit;
begin
  Inherited;
  If (fEntraCons(Key)) Then
  Begin
    edtDesEdt := TEdit(FindComponent('edtDes' + RightStr(TEdit(Sender).Name, 7)));
    pConsultaItem(TEdit(Sender), edtDesEdt);
  End;
end;

procedure TfrmConfiguracoesNexa.edtNexaPMLAduKeyPress(Sender: TObject;
  var Key: Char);
  Var
    edtDesEdt: TEdit;
begin
  inherited;
  If (fEntraCons(Key)) Then
  Begin
    edtDesEdt := TEdit(FindComponent('edtDes' + RightStr(TEdit(Sender).Name, 9)));
    pConsultaItem(TEdit(Sender), edtDesEdt);
  End;
end;

procedure TfrmConfiguracoesNexa.edtNexaPMLduKeyPress(Sender: TObject;
  var Key: Char);
  Var
    edtDesEdt: TEdit;
begin
  inherited;
  If (fEntraCons(Key)) Then
  Begin
    edtDesEdt := TEdit(FindComponent('edtDes' + RightStr(TEdit(Sender).Name, 8)));
    pConsultaItem(TEdit(Sender), edtDesEdt);
  End;
end;

procedure TfrmConfiguracoesNexa.pRetornaDescricaoItem3(edtCodIte: TEdit);
  Var
    strNomEdt: String;
    edtDesIte: TEdit;
begin
  strNomEdt := 'edtDes' + RightStr(edtCodIte.Name, 9);
  edtDesIte := TEdit(FindComponent(strNomEdt));
  edtDesIte.Text := fRetNomProduto(edtCodIte.Text);
end;

procedure TfrmConfiguracoesNexa.pRetornaDescricaoItem4(edtCodIte: TEdit);
  Var
    strNomEdt: String;
    edtDesIte: TEdit;
begin
  strNomEdt := 'edtDes' + RightStr(edtCodIte.Name, 10);
  edtDesIte := TEdit(FindComponent(strNomEdt));
  edtDesIte.Text := fRetNomProduto(edtCodIte.Text);
end;

end.
