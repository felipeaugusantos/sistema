{***************************}
{* qryConMar -> CADMAR     *}
{* qryConFor -> CADFOR     *}
{* qryConGru -> CADGRU     *}
{************************JB*}
unit untFiltroEtiItens;

interface

uses
  SysUtils, Types, Classes, Variants, Graphics, Controls, Forms, Windows,
  Dialogs, StdCtrls, untPaiConfirma, EditFocus, ComCtrls, Buttons, Uni,
  ExtCtrls, Mask, MaskEditFocus, Menus, AppEvnts, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade, untTypesSistema, untfuncoesConsulta, QColorLabel, Vcl.CheckLst;

type
  TfrmFiltroEtiItens = class(TfrmPaiConfirma)
    Label1: TLabel;
    Label2: TLabel;
    edtDesIni: TEditFocus;
    edtDesFin: TEditFocus;
    lblCodMar: TLabel;
    edtCodMar: TEditFocus;
    lblCodFor: TLabel;
    edtCodFor: TEditFocus;
    lblLinGru: TLabel;
    edtLinGru: TMaskEditFocus;
    edtNomFor: TEditFocus;
    edtDesMar: TEditFocus;
    edtDesGru: TEditFocus;
    pnlFundo: TPanel;
    gpb1: TGroupBox;
    lbl1: TLabel;
    lbl2: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    lblRefere: TLabel;
    edtRefere: TEditFocus;
    lblEmpresa: TLabel;
    edtCodEmpresa: TEditFocus;
    edtDesEmpresa: TEditFocus;
    Shape1: TShape;
    pnlLocFis: TPanel;
    lblLocFis: TLabel;
    Label8: TLabel;
    edtLocFis: TEditFocus;
    edtCodAmz: TEditFocus;
    edtDesAmz: TEditFocus;
    gb2: TGroupBox;
    Label11: TLabel;
    Label9: TLabel;
    edtLocFinSup: TEditFocus;
    edtLocIniSup: TEditFocus;
    gb1: TGroupBox;
    Label5: TLabel;
    Label7: TLabel;
    edtLocFin: TEditFocus;
    edtLocIni: TEditFocus;
    Panel2: TPanel;
    chkCodBar: TCheckBox;
    chkImpEst: TCheckBox;
    chkPromoc: TCheckBox;
    chkMosFil: TCheckBox;
    edtQtdEti: TEditFocus;
    Label10: TLabel;
    pnlWms: TPanel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    edtRuaIni: TEditFocus;
    edtPredioIni: TEditFocus;
    edtAndarIni: TEditFocus;
    edtApartamentoIni: TEditFocus;
    edtCodLse: TEditFocus;
    edtDesLse: TEditFocus;
    edtRuaFin: TEditFocus;
    edtPredioFin: TEditFocus;
    edtAndarFin: TEditFocus;
    edtApartamentoFin: TEditFocus;
    lblCodPro: TLabel;
    edtCodPro: TEditFocus;
    edtDesPro: TEditFocus;
    lblCodDep: TLabel;
    edtCodDep: TEditFocus;
    edtDesDep: TEditFocus;
    lblDesIte: TLabel;
    edtDesIte: TEditFocus;
    Label22: TLabel;
    mskHraIni: TMaskEditFocus;
    Label23: TLabel;
    mskHraFin: TMaskEditFocus;
    lblDESSIM: TLabel;
    edtDESSIM: TEditFocus;
    mskDataPromoc: TMaskEditFocus;
    Label3: TLabel;
    rdgPreAlt: TRadioGroup;
    lblIteEmb: TLabel;
    edtIteEmb: TEditFocus;
    lblIteEmbLeg: TColorLabel;
    chkSaldoMinimo: TCheckBox;
    pnlExpEtiEle: TPanel;
    grbExpEtiEle: TGroupBox;
    Label4: TLabel;
    EdtCodEmpresaEtiEle: TEditFocus;
    edtDesEmpresaEtiEle: TEditFocus;
    clbPreTab: TCheckListBox;
    lblTabPre: TLabel;
    Label167: TLabel;
    edtDesPrdPro: TEditFocus;
    edtPrdGru: TEditFocus;
    Label6: TLabel;
    edtIteLot: TEditFocus;
    ColorLabel1: TColorLabel;
    pnlEstoqPro: TPanel;
    rdgEstMin: TRadioGroup;
    rdgEstMax: TRadioGroup;
    rdgEstFis: TRadioGroup;
    pnlExibirEstoque: TPanel;
    rdgExibirEstoque: TRadioGroup;
    chkSalArm: TCheckBox;
    lblSitPro: TLabel;
    edtDesSitPro: TEditFocus;
    edtSitPro: TEditFocus;
    mskPrecoDtaIni: TMaskEditFocus;
    lblPeriodoDe: TLabel;
    mskPrecoDtaFin: TMaskEditFocus;
    lblPeriodoA: TLabel;
    chkItensDivergentes: TCheckBox;
    procedure edtCodMarKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure edtLinGruKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtLocFisKeyPress(Sender: TObject; var Key: Char);
    procedure edtLocIniKeyPress(Sender: TObject; var Key: Char);
    procedure edtLocFinKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodAmzKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodAmzExit(Sender: TObject);
    procedure edtLocIniSupKeyPress(Sender: TObject; var Key: Char);
    procedure edtLocFinSupKeyPress(Sender: TObject; var Key: Char);
    procedure edtLocIniChange(Sender: TObject);
    procedure edtLocIniSupChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtCodEmpresaExit(Sender: TObject);
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodMarExit(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure chkImpEstClick(Sender: TObject);
    procedure edtCodForExit(Sender: TObject);
    procedure edtLinGruExit(Sender: TObject);
    procedure edtCodLseExit(Sender: TObject);
    procedure edtCodLseKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodProExit(Sender: TObject);
    procedure edtCodProKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodDepExit(Sender: TObject);
    procedure edtCodDepKeyPress(Sender: TObject; var Key: Char);
    procedure EdtCodEmpresaEtiEleExit(Sender: TObject);
    procedure EdtCodEmpresaEtiEleKeyPress(Sender: TObject; var Key: Char);
    procedure edtPrdGruExit(Sender: TObject);
    procedure edtPrdGruKeyPress(Sender: TObject; var Key: Char);
    procedure edtSitProKeyPress(Sender: TObject; var Key: Char);	
    procedure edtSitProExit(Sender: TObject);
    procedure chkItensDivergentesExit(Sender: TObject);
    procedure chkItensDivergentesClick(Sender: TObject);
  private
    blnCadLoc: Boolean;
    procedure pSetaCampos;
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; override;
  public
    { Public declarations }
    strDtaIni   : String;
    strDtaFin   : String;
    strDtaPro   : String;
    strHraIni   : String;
    strHraFin   : String;
    strDesIni   : String;
    strDesFin   : String;
    strRefere   : String;
    strLocFis   : String;
    strLocIni   : String;
    strLocFin   : String;
    strCodMar   : String;
    strCodFor   : String;
    strLinGru   : String;
    strPrdGru   : String;
    strSitPro   : String;
    intQtdEti   : Integer;
    strStatus   : String;
    strCodAmz   : String;
    strLocIniSup: String;
    strLocFinSup: String;
    strCodEmpAlt: String;
    strCodPro   : String;
    strCodDep   : String;
    strDesIte   : String;
    strDesSim   : String;
    strIteEmb   : String;
    strIteLot   : String;
    strCodEmpEtiEleAlt: String;
    tpAltPreEti : TTipoAltPreEti;

    arrPrdGru: TConsultasArray;
    arrMarca : TConsultasArray;
    arrFornec: TConsultasArray;
    arrGrupos: TConsultasArray;
    arrCodAmz: TConsultasArray;
    arrCodLse: TConsultasArray;
    arrPromoc: TConsultasArray;
    arrSitPro: TConsultasArray;

    arrCodEmp: TConsultasArray;
    arrCodDep: TConsultasArray;
    arrCodEmpEtiEle: TConsultasArray;
    blnConfirma: Boolean;

    strPrecoDtaIni: String;
    strPrecoDtaFin: String;

  end;


implementation

uses  untfuncoesSimples, untPesqAux, untConsultas, untCfgLocFis;

{$R *.dfm}

{ TfrmFiltroEtiItens }

function TfrmFiltroEtiItens.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
  var
    strPreTab: string;
    intCnt: integer;

begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin

    {*****************************************}
    {* VALIDA A DESCRIÇÃO INICIAL            *}
    {**************************************MV*}
    If (Sender = edtDesIni) Then
    Begin
      If fEmptyStr(edtDesIni.Text) Then
      Begin
        edtDesFin.Enabled := False;
      End
      Else
      Begin
        edtDesFin.Enabled := True;
      End;
    End

    {*****************************************}
    {* VALIDA A DESCRIÇÃO FINAL              *}
    {**************************************MV*}
    Else If (Sender = edtDesFin) Then
    Begin
      If edtDesIni.Text > edtDesFin.Text Then
      Begin
        fMensagem('ATENÇÃO!', 'A Descrição Final não pode ser menor que o Inicial', ['&O k']);
        Result := False;
      End;
    End

    {*****************************************}
    {* VALIDA A MARCA                        *}
    {**************************************MV*}
    Else If (Sender = edtCodMar) Then
    Begin
      pDesmarcaLista(edtCodMar, arrMarca);
    End

    {*****************************************}
    {* VALIDA O FORNECEDOR                   *}
    {**************************************MV*}
    Else If (Sender = edtCodFor) Then
    Begin
      pDesmarcaLista(edtCodFor, arrFornec);
    End

    {*****************************************}
    {* VALIDA A SITUAÇÃO DO PRODUTO          *}
    {**************************************TK*}
    Else If (Sender = edtSitPro) Then
    Begin
      pDesmarcaLista(edtSitPro, arrSitPro);
    End

    {*****************************************}
    {* VALIDA A DATA INICIAL E FINAL         *}
    {**************************************IV*}
    Else If (Sender = mskDtaIni) Or (Sender = mskDtaFin) Then
    Begin
      edtCodEmpresa.Enabled := True;
      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        mskDtaFin.Clear;
        mskDtaFin.Enabled := False;
        mskHraFin.Clear;
        mskHraFin.Enabled := False;
        If Not (chkItensDivergentes.Enabled And chkItensDivergentes.Checked) Then
        Begin
          edtCodEmpresa.Enabled := False;
          edtCodEmpresa.Clear;
          edtDesEmpresa.Clear;
        End
      End
      Else
      Begin
        mskDtaFin.Enabled := True;
        mskHraFin.Enabled := True;
        If (Sender = mskDtaFin) Then
        Begin
        If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
          Begin
            fMensagem('', 'O campo Data Final deve ser preenchido!', ['&O k']);
            Result := False;
            If Not (chkItensDivergentes.Enabled And chkItensDivergentes.Checked) Then
            Begin
              edtCodEmpresa.Enabled := False;
              edtCodEmpresa.Clear;
              edtDesEmpresa.Clear;
            End
          End
          Else
          Begin
            If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
            Begin
              fMensagem('','A Data Inicial deve ser menor que a Data Final!',['&O K']);
              Result := False;
              edtCodEmpresa.Enabled := False;
              edtCodEmpresa.Clear;
              edtDesEmpresa.Clear;
            End;
          End;
        End;
      End;
    End

    Else If (Sender = mskHraIni) And (Not fEmptyTime(mskHraIni.Text)) Then
    Begin
      If (StrToTimeDef(mskHraIni.Text, -1) = -1) Then
      Begin
        fMensagem('ATENÇÃO!', 'A hora inicial informada é inválida!', ['&O k']);
        Result := False;
      End
      Else If (Not fEmptyTime(mskHraFin.Text)) And
         ((mskDtaIni.Text) = (mskDtaFin.Text)) And
         (StrToTime(mskHraIni.Text) >= StrToTime(mskHraFin.Text)) Then
      Begin
        fMensagem('','A Hora Inicial deve ser menor que a Hora Final!',['&O K']);
        Result := False;
      End;
    End

    Else If (Sender = mskHraFin) Then
    Begin
      If (fEmptyTime(mskHraFin.Text)) And (Not fEmptyTime(mskHraIni.Text)) Then
        fMensagem('ATENÇÃO!', 'A hora final deve ser preenchida!', ['&O k'])
      Else If (StrToTimeDef(mskHraFin.Text, -1) = -1) And (Not fEmptyTime(mskHraFin.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A hora final informada é inválida!', ['&O k']);
        Result := False;
      End
      Else If (Not (fEmptyTime(mskHraFin.Text))) And
           ((mskDtaIni.Text) = (mskDtaFin.Text)) And
           (StrToTime(mskHraIni.Text) >= StrToTime(mskHraFin.Text)) Then
      Begin
        fMensagem('','A Hora Inicial deve ser menor que a Hora Final!',['&O K']);
        Result := False;
      End;
    End

    {*****************************************}
    {* VALIDA A LINHA / GRUPO                *}
    {**************************************MV*}
    Else If (Sender = edtLinGru) Then
    Begin
      pDesmarcaLista(edtLinGru, arrGrupos, '', 6);
    End

    Else If (Sender = edtLocFis) Then
    Begin

      If blnCadLoc Then
      Begin

        If (Not fEmptyStr(edtLocFis.Text)) Then
        Begin

          If fEmptyStr(fRetNomLocFisica(edtLocFis.Text)) Then
          Begin
            pMensagemOk('Localização Física não encontrada!');
            Result := False;
          End

        End;

      End;

    End

    Else If (Sender = edtLocIni) Then
    Begin

      If blnCadLoc Then
      Begin

        If (Not fEmptyStr(edtLocIni.Text)) Then
        Begin

          If fEmptyStr(fRetNomLocFisica(edtLocIni.Text)) Then
          Begin
            pMensagemOk('Localização Física Inicial do Estoque não encontrada!');
            Result := False;
          End
          Else
            edtLocFin.Enabled := True;

        End
        Else
        Begin
          edtLocFin.Enabled := False;
          edtLocFin.Clear;
        End;

      End;

    End

    Else If (Sender = edtLocFin) Then
    Begin

      If blnCadLoc Then
      Begin

        If (Not fEmptyStr(edtLocFin.Text)) Then
        Begin

          If fEmptyStr(fRetNomLocFisica(edtLocFin.Text)) Then
          Begin
            pMensagemOk('Localização Física Final do Estoque não encontrada!');
            Result := False;
          End
          Else
          Begin
            If edtLocIni.Text > edtLocFin.Text Then
            Begin
              fMensagem('ATENÇÃO!', 'A Localização Física do Estoque Final não pode ser menor que a Inicial', ['&O k']);
              Result := False;
            End;
          End;

        End
        Else
        Begin
          If (Not fEmptyStr(edtLocIni.Text)) Then
          Begin
            fMensagem('ATENÇÃO!', 'O campo Localização Física do Estoque Final deve ser preenchida.', ['&O k']);
            Result := False;
          End;
        End;

      End;

    End

    {*************************************************}
    {* VALIDACAO DA LOCALIZACAO FISICA SUPER ESTOQUE *}
    {***********************************************FC}
    Else If (Sender = edtLocIniSup) Then
    Begin

      If blnCadLoc Then
      Begin

        If (Not fEmptyStr(edtLocIniSup.Text)) Then
        Begin

          If fEmptyStr(fRetNomLocFisica(edtLocIniSup.Text)) Then
          Begin
            pMensagemOk('Localização Física Inicial do Super Estoque não encontrada!');
            Result := False;
          End
          Else
            edtLocFinSup.Enabled := True;

        End
        Else
        Begin
          edtLocFinSup.Enabled := False;
          edtLocFinSup.Clear;
        End;

      End;

    End

    Else If (Sender = edtLocFinSup) Then
    Begin

      If blnCadLoc Then
      Begin

        If (Not fEmptyStr(edtLocFinSup.Text)) Then
        Begin

          If fEmptyStr(fRetNomLocFisica(edtLocFinSup.Text)) Then
          Begin
            pMensagemOk('Localização Física Final do Super Estoque não encontrada!');
            Result := False;
          End
          Else
          Begin
            If edtLocIniSup.Text > edtLocFinSup.Text Then
            Begin
              fMensagem('ATENÇÃO!', 'A Localização Física do Super Estoque Final não pode ser menor que a Inicial', ['&O k']);
              Result := False;
            End;
          End;

        End
        Else
        Begin
          If (Not fEmptyStr(edtLocIniSup.Text)) Then
          Begin
            fMensagem('ATENÇÃO!', 'O campo Localização Física do Super Estoque Final deve ser preenchida.', ['&O k']);
            Result := False;
          End;
        End;

      End;

    End
    {*****************************************}
    {* VALIDA O ARMAZEM SE UTILIZAR          *}
    {**************************************RN*}
    Else If (Sender = edtCodAmz) Then
    Begin
      rdgExibirEstoque.Enabled := (edtCodAmz.Enabled) and (not fEmptyStr(edtCodAmz.Text));
      if (not rdgExibirEstoque.Enabled) then
        rdgExibirEstoque.ItemIndex := 0;

      if (not edtCodAmz.Enabled) then
        Exit;

      pDesmarcaLista(edtCodAmz, arrCodAmz);
    End

    {*****************************************}
    {* VALIDA A PROMOÇÃO                     *}
    {**************************************MV*}
    Else If (Sender = edtCodPro) Then
    Begin
      pDesmarcaLista(edtCodPro, arrPromoc);
    End

    Else If (Sender = edtCodDep) Then
    Begin
      pDesmarcaLista(edtCodDep, arrCodDep);
    End;

    If Not Result Then
      pSetFocus(Sender);

    If Sender = edtCodEmpresa Then
    Begin
      If edtCodEmpresa.Enabled Then
      Begin
        If fEmptyStr(edtCodEmpresa.Text) Then
        Begin
          fMensagem('ATENÇÂO','O Código da Empresa precisa ser preenchido!', ['&OK']);
          edtDesEmpresa.Text := '';
          Result := False;
        End;
      End;
    End;

    {*****************************************}
    {* VALIDA A QUANTIDADE DE ETIQUETAS      *}
    {**************************************MV*}
    If (Sender = edtQtdEti) And edtQtdEti.Enabled Then
    Begin
      edtQtdEti.Text := fRetSomenteNumeros(edtQtdEti.Text);

      If fEmptyStr(edtQtdEti.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Defina uma quantidade de etiquetas!', ['&O  k']);
        Result := False;
        pSetFocus(Sender);
      End
      Else If (StrToInt(edtQtdEti.Text) <= 0) Or (StrToInt(edtQtdEti.Text) > 999) Then
      Begin
        fMensagem('ATENÇÃO!', 'Defina uma quantidade de etiquetas entre 1 e 999!', ['&O  k']);
        Result := False;
        pSetFocus(Sender);
      End
      Else If (blnValidaIndividual) And (Not fVerificaCampos) Then
      Begin
        Result := False;
      End;
    End

    Else
    If (Sender = edtCodLse) Then
    Begin
      pDesmarcaLista(edtCodLse, arrCodLse);
    End

    Else
    If (Sender = edtRuaIni) Then
    Begin
      edtRuaFin.Enabled := not fEmptyStr(edtRuaIni.Text);
      If Not edtRuaFin.Enabled Then
        edtRuaFin.Clear;
    End

    Else
    If (Sender = edtPredioIni) Then
    Begin
      edtPredioFin.Enabled := not fEmptyStr(edtPredioIni.Text);
      If Not edtPredioFin.Enabled Then
        edtPredioFin.Clear;
    End

    Else
    If (Sender = edtAndarIni) Then
    Begin
      edtAndarFin.Enabled := not fEmptyStr(edtAndarIni.Text);
      If Not edtAndarFin.Enabled Then
        edtAndarFin.Clear;
    End

    Else
    If (Sender = edtApartamentoIni) Then
    Begin
      edtApartamentoFin.Enabled := not fEmptyStr(edtApartamentoIni.Text);
      If Not edtApartamentoFin.Enabled Then
        edtApartamentoFin.Clear;
    End

    Else
    If (Sender = edtIteEmb) Then
    Begin
      If (Not ( (SameText(edtIteEmb.Text, 'S')) Or (SameText(edtIteEmb.Text, 'N')) Or (SameText(edtIteEmb.Text, 'T')))) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Itens com embalagem fechada deve ser (S), (N) ou (T)!', ['&OK']);
        Result := False;
        pSetFocus(Sender);
      End;

      mskPrecoDtaIni.TabStop := (SameText(edtIteEmb.Text, 'S')) or (SameText(edtIteEmb.Text, 'T'));
      mskPrecoDtaFin.TabStop := (SameText(edtIteEmb.Text, 'S')) or (SameText(edtIteEmb.Text, 'T'));
      mskPrecoDtaIni.Enabled := (SameText(edtIteEmb.Text, 'S')) or (SameText(edtIteEmb.Text, 'T'));
      mskPrecoDtaFin.Enabled := (SameText(edtIteEmb.Text, 'S')) or (SameText(edtIteEmb.Text, 'T'));

    End

    Else
    If (Sender = edtIteLot) Then
    Begin
      If (Not ( (SameText(edtIteLot.Text, 'S')) Or (SameText(edtIteLot.Text, 'N')) Or (SameText(edtIteLot.Text, 'T')))) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Itens com lote deve ser (S), (N) ou (T)!', ['&OK']);
        Result := False;
        pSetFocus(Sender);
      End;
    End

    Else
    If (Sender = edtCodEmpresaEtiEle) And pnlExpEtiEle.Visible Then
    Begin
      If fEmptyStr(edtCodEmpresaEtiEle.Text) Then
      Begin
        fMensagem('ATENÇÂO','O Código da Empresa Etiquetas Eletrônicas precisa ser preenchido!', ['&OK']);
        edtCodEmpresaEtiEle.Text := '';
        Result := False;
      End;
    End
    else if (sender = clbPreTab) then
    begin

      if (not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) and (not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) Then
      begin
        strPreTab := 'NNNNNNN';
        for intCnt := 0 to clbPreTab.Count-1 do
        begin
          if clbPreTab.Checked[intCnt] then
          begin
            strPretab := Copy(strPretab,1, StrToInt(clbPreTab.Items[intCnt])-1)+
                         'S'+
                         Copy(strPretab, StrToInt(clbPreTab.Items[intCnt]), length(strPreTab)-StrToInt(clbPreTab.Items[intCnt]));
          end;
        end;

        if pos('S', strPreTab) = 0 then
        begin
          fMensagem('ATENÇÃO!', 'O campo Tabela de Preços deve haver pelo menos UMA selecionada!', ['&OK']);
          Result := False;
          pSetFocus(Sender);
        end;
      end;

    end

    {********************************************************}
    {* VALIDA A DATA INICIAL E FINAL ITENS EMBALGEM FECHADA *}
    {*****************************************************CH*}
    Else If (Sender = mskPrecoDtaIni) Or (Sender = mskPrecoDtaFin) Then
    Begin

      If (Sender = mskPrecoDtaFin) And (edtIteEmb.Text = 'S') Then
      Begin
        If fEmptyStr(fTiraCaracEspeciais(mskPrecoDtaFin.Text)) Then
        Begin
          fMensagem('', 'O campo Data Final deve ser preenchido!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          If StrToDate(mskPrecoDtaIni.Text) > StrToDate(mskPrecoDtaFin.Text) Then
          Begin
            fMensagem('','A Data Inicial deve ser menor que a Data Final!',['&O K']);
            Result := False;
          End;
        End;
      End;

    End;

  End;

end;

procedure TfrmFiltroEtiItens.edtCodMarExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodMar, edtDesMar, arrMarca, fRetNomeMarca, nil, 'da marca');
end;

procedure TfrmFiltroEtiItens.edtCodMarKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {***************************}
  {* NOVA CONSULTA DE MARCAS *}
  {************************DP*}
  If fPesqMarcas(Self, edtCodMar, edtDesMar, Nil, Key, arrMarca, False) Then
  Begin
    If fValidaCampos(edtCodMar, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmFiltroEtiItens.edtCodProExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodPro, edtDesPro, arrPromoc, Nil, fRetDescPromocao, 'da Promoção', 8);
end;

procedure TfrmFiltroEtiItens.edtCodProKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqPromocoes(Self, edtCodPro, edtDesPro, nil, Key, arrPromoc, False) Then
  Begin
    If fValidaCampos(edtCodPro, False) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFiltroEtiItens.btnConfirmaClick(Sender: TObject);
begin
//  inherited;

  If Not chkMosFil.Checked Then
  Begin
    mskDtaIni.Clear;
    mskDtaFin.Clear;
    mskHraIni.Clear;
    mskHraFin.Clear;
    edtCodEmpresa.Clear;
    edtDesIni.Clear;
    edtDesFin.Clear;
    edtRefere.Clear;
    edtCodMar.Clear;
    edtCodFor.Clear;
    edtlinGru.Clear;
    edtDesMar.Clear;
    edtNomFor.Clear;
    edtDesGru.Clear;
    edtLocIni.Clear;
    edtLocFin.Clear;
    edtLocIniSup.Clear;
    edtLocFinSup.Clear;
    edtCodEmpresaEtiEle.Clear;

    chkCodBar.Checked := False;
    chkPromoc.Checked := False;

    edtIteEmb.Text := 'T';
    edtIteLot.Text := 'T';
  End;

  If fVerificaCampos And (fMensagem('', 'Confirma dados do filtro?', ['&Sim', '&Não']) = 1) Then
  Begin
    blnConfirma := True;

    strDtaIni    := mskDtaIni.Text;
    strDtaFin    := mskDtaFin.Text;
    strDtaPro    := mskDataPromoc.Text;
    strHraIni    := mskHraIni.Text;
    strHraFin    := mskHraFin.Text;
    strDesIni    := edtDesIni.Text;
    strDesFin    := edtDesFin.Text;
    strRefere    := edtRefere.Text;
    strLocFis    := edtLocFis.Text;
    strLocIni    := edtLocIni.Text;
    strLocFin    := edtLocFin.Text;
    strCodMar    := edtCodMar.Text;
    strCodFor    := edtCodFor.Text;
    strLinGru    := edtLinGru.Text;
    strPrdGru    := edtPrdGru.Text;
    strSitPro    := edtSitPro.Text;
    If edtQtdEti.Enabled Then
      intQtdEti  := StrToInt(edtQtdEti.Text);
    strCodAmz    := edtCodAmz.Text;
    strLocIniSup := edtLocIniSup.Text;
    strLocFinSup := edtLocFinSup.Text;
    strCodEmpAlt := edtCodEmpresa.Text;
    strCodPro    := edtCodPro.Text;
    strCodDep    := edtCodDep.Text;
    strDesIte    := edtDesIte.Text;
    strDesSim    := edtDesSim.Text;
    strIteEmb    := edtIteEmb.Text;
    strIteLot    := edtIteLot.Text;
    Case rdgPreAlt.ItemIndex Of
      0: tpAltPreEti := tpPrecoCusto;
      1: tpAltPreEti := tpPrecoVenda;
      2: tpAltPreEti := tpTodos;
    End;
    strCodEmpEtiEleAlt := '';
    If pnlExpEtiEle.Visible Then
      strCodEmpEtiEleAlt := edtCodEmpresaEtiEle.Text;
    strPrecoDtaIni := mskPrecoDtaIni.Text;
    strPrecoDtaFin := mskPrecoDtaFin.Text;
    ModalResult := mrOK;
  End;

end;

procedure TfrmFiltroEtiItens.chkImpEstClick(Sender: TObject);
begin
  inherited;
  edtQtdEti.Enabled := not chkImpEst.Checked;
end;

procedure TfrmFiltroEtiItens.chkItensDivergentesClick(Sender: TObject);
Var
 intCnt: Integer;
begin
  inherited;
  If chkItensDivergentes.Checked Then
  Begin
    edtCodEmpresa.Enabled := False;
    edtCodEmpresa.Text := VS_strCodEmp;
    pEdtCodSelectExit(edtCodEmpresa, edtDesEmpresa, arrCodEmp, Nil, fRetNomeEmpresaSelec, 'da Empresa');

    clbPreTab.Enabled := False;
    For intCnt := 0 To clbPreTab.Count-1 Do
    Begin
      clbPreTab.Checked[intCnt] := False;
    End;

    rdgPreAlt.Enabled := False;

    mskDtaIni.Clear;
    mskDtaIni.Enabled := False;
    mskDtaFin.Clear;
    mskDtaFin.Enabled := False;
    mskHraIni.Clear;
    mskHraIni.Enabled := False;
    mskHraFin.Clear;
    mskHraFin.Enabled := False;
  End
  Else
  Begin
    edtCodEmpresa.Enabled := True;
    edtCodEmpresa.Text := VS_strCodEmp;
    pEdtCodSelectExit(edtCodEmpresa, edtDesEmpresa, arrCodEmp, Nil, fRetNomeEmpresaSelec, 'da Empresa');

    clbPreTab.Enabled := True;
    For intCnt := 0 To clbPreTab.Count-1 Do
    Begin
      clbPreTab.Checked[intCnt] := False;
    End;

    rdgPreAlt.Enabled := True;

    mskDtaIni.Clear;
    mskDtaIni.Enabled := True;
    mskDtaFin.Clear;
    mskDtaFin.Enabled := True;
    mskHraIni.Clear;
    mskHraIni.Enabled := True;
    mskHraFin.Clear;
    mskHraFin.Enabled := True;
  End;
end;

procedure TfrmFiltroEtiItens.chkItensDivergentesExit(Sender: TObject);
begin
  inherited;
  fValidaCampos(mskDtaIni, False);
end;

procedure TfrmFiltroEtiItens.EdtCodEmpresaEtiEleExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(EdtCodEmpresaEtiEle, EdtDesEmpresaEtiEle, arrCodEmpEtiEle, Nil, fRetNomeEmpresaSelec, 'da Empresa');
end;

procedure TfrmFiltroEtiItens.EdtCodEmpresaEtiEleKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmpresaEtiEle, edtDesEmpresaEtiEle, Nil, Key, arrCodEmpEtiEle, False) Then
  Begin
    fValidaCampos(edtCodEmpresaEtiEle, False);
    Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFiltroEtiItens.edtCodAmzExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodAmz, edtDesAmz, arrCodAmz, Nil, fRetNomeArmazem, 'do armazém');
end;

procedure TfrmFiltroEtiItens.edtCodAmzKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqArmazem(Self, edtCodAmz, edtDesAmz, nil, Key, arrCodAmz, False) Then
  Begin
    If fValidaCampos(edtCodAmz, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFiltroEtiItens.edtCodDepExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodDep, edtDesDep, arrCodDep, fRetNomDep, nil, 'do Departamento');
end;

procedure TfrmFiltroEtiItens.edtCodDepKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqDepartamento(Self, edtCodDep, edtDesDep, Nil, Key, arrCodDep, False) Then
  Begin
    If fValidaCampos(edtCodDep, False) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFiltroEtiItens.edtCodEmpresaExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodEmpresa, edtDesEmpresa, arrCodEmp, Nil, fRetNomeEmpresaSelec, 'da Empresa');
end;

procedure TfrmFiltroEtiItens.edtCodEmpresaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmpresa, edtDesEmpresa, Nil, Key, arrCodEmp, False) Then
  Begin
    fValidaCampos(edtCodEmpresa, False);
    Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFiltroEtiItens.edtCodForExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodFor, edtNomFor, arrFornec, fRetNomFornecedor, nil, 'do fornecedor');
end;

procedure TfrmFiltroEtiItens.edtCodForKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*********************************}
  {* NOVA CONSULTA DE FORNECEDORES *}
  {******************************RV*}
  If fPesqFornecedor(conForSimples, Self, edtCodFor, edtNomFor, Nil, Key, arrFornec, False) Then
  Begin
    If fValidaCampos(edtCodFor, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFiltroEtiItens.edtCodLseExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodLse, edtDesLse, arrCodLse, nil, fRetLocSep, 'do local de separação');
end;

procedure TfrmFiltroEtiItens.edtCodLseKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqLocSep(Self, edtCodLse, edtDesLse, nil, key, arrCodLse, False) Then
  Begin
    If fValidaCampos(edtCodLSe, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFiltroEtiItens.edtLinGruExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtLinGru, edtDesGru, arrGrupos, fRetNomeLinhaGrupo, nil, 'da linha/grupo', 6);
end;

procedure TfrmFiltroEtiItens.edtLinGruKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {********************************}
  {* NOVA CONSULTA DE LINHA/GRUPO *}
  {*****************************RV*}
  If fPesqGrupo(Self, edtLinGru, edtDesGru, Nil, Key, arrGrupos, False) Then
  Begin
    If fValidaCampos(edtLinGru, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFiltroEtiItens.edtLocFinKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;

  If blnCadLoc And fPesqLocFisica(Self, edtLocFin, Nil, Nil, Key, arrSel) And
     fValidaCampos(edtLocFin, True) Then
    SelectNext(ActiveControl, True, True);

end;

procedure TfrmFiltroEtiItens.edtLocFinSupKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;
  If blnCadLoc And fPesqLocFisica(Self, edtLocFinSup, Nil, Nil, Key, arrSel) And
     fValidaCampos(edtLocFinSup, True) Then
    SelectNext(ActiveControl, True, True);
end;

procedure TfrmFiltroEtiItens.edtLocFisKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;

  If blnCadLoc And fPesqLocFisica(Self, edtLocFis, Nil, Nil, Key, arrSel) And
     fValidaCampos(edtLocFis, True) Then
    SelectNext(ActiveControl, True, True);
end;

procedure TfrmFiltroEtiItens.edtLocIniChange(Sender: TObject);
begin
  inherited;
  edtLocFin.Enabled := Not fEmptyStr(edtLocIni.Text);
end;

procedure TfrmFiltroEtiItens.edtLocIniKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;

  If blnCadLoc And fPesqLocFisica(Self, edtLocIni, Nil, Nil, Key, arrSel) And
     fValidaCampos(edtLocIni, True) Then
    SelectNext(ActiveControl, True, True);

end;

procedure TfrmFiltroEtiItens.edtLocIniSupChange(Sender: TObject);
begin
  inherited;
  edtLocFinSup.Enabled := Not fEmptyStr(edtLocIniSup.Text);
end;

procedure TfrmFiltroEtiItens.edtLocIniSupKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;

  If blnCadLoc And fPesqLocFisica(Self, edtLocIniSup, Nil, Nil, Key, arrSel) And
     fValidaCampos(edtLocIniSup, True) Then
    SelectNext(ActiveControl, True, True);

end;

procedure TfrmFiltroEtiItens.edtPrdGruExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtPrdGru, edtDesPrdPro, arrPrdGru, fRetNomeGrupoProduto, nil, 'do Grupo de Produto');
end;

procedure TfrmFiltroEtiItens.edtPrdGruKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqGrupoProduto(Self, edtPrdGru, edtDesPrdPro, Nil, Key, arrPrdGru, False) Then
  Begin
    If fValidaCampos(edtPrdGru, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFiltroEtiItens.edtSitProKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqSituacaoProduto(Self, edtSitPro, edtDesSitPro, Nil, Key,  arrSitPro, False) Then
  Begin
    If fValidaCampos(edtSitPro, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFiltroEtiItens.edtSitProExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtSitPro, edtDesSitPro, arrSitPro, fRetNomSituacaoProduto, Nil, 'da Situação do Produto');
end;

procedure TfrmFiltroEtiItens.FormCreate(Sender: TObject);
begin
  inherited;
  pSetaCodLse(edtCodLse);
  blnCadLoc := fCfgSis('CADLOC', varBoolean);
  edtCodAmz.Enabled := (fCfgSis('CTLEST') = '2');
  mskDataPromoc.Text := DateToStr(fNow);
  chkSalArm.Enabled := (fCfgSis('CTLEST') = '2');

  lblPeriodoDe.Visible := fTabelaExiste('DTAEMB', True);
  lblPeriodoA.Visible := lblPeriodoDe.Visible;
  mskPrecoDtaIni.Visible := lblPeriodoDe.Visible;
  mskPrecoDtaFin.Visible := lblPeriodoDe.Visible;

  chkItensDivergentes.Enabled := (fCfgSis('CFPREP') = 'S');

end;

procedure TfrmFiltroEtiItens.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_Return) And ((ActiveControl Is TRadioButton) Or (ActiveControl Is TRadioGroup)) Then
    SelectNext(ActiveControl, True, True);
end;

procedure TfrmFiltroEtiItens.FormShow(Sender: TObject);
  Var
    intTabPre: integer;
begin
  inherited;
  pSetaCampos;

  edtCodEmpresa.Text := '';

  pnlLocFis.Visible := not fUsaRotinaWMS();
  pnlWMs.Visible    := fUsaRotinaWMS();
  pnlExpEtiEle.Visible := fCfgSis('EEREAT', varBoolean);

  Self.Height := Self.Height - IIF(pnlWMs.Visible, 0 , pnlWMs.Height);
  Self.Height := Self.Height - IIF(pnlLocFis.Visible, 0 , pnlLocFis.Height);
  Self.Height := Self.Height - IIF(pnlExpEtiEle.Visible, 0 , pnlExpEtiEle.Height);


  If fCfgSis('IDSORC', varString) = 'N' Then
  Begin
    lblDesSim.Visible := False;
    edtDesSim.Visible := False;
  End;

  {***************************************************************************}
  {* Verifica a permissão para alterar preço replicando para todas as lojas  *}
  {************************************************************************MA*}
  If (fCfgSis('REPPRC') = '2') Then
    {*********************************}
    {* Qualquer Empresa              *}
    {******************************MA*}
     edtCodEmpresa.Text := VS_strCodEmp
  Else
  Begin
    {*********************************}
    {* Somente Empresa Gerencial     *}
    {******************************MA*}

    If (fCfgSis('INFMAT') = 'N') Then
    Begin
      {*****************************************************}
      {* Não utiliza definição de empresa matriz por loja. *}
      {* Informação obtida nas configurações do sistema.   *}
      {* Busca empresa matriz na configurações do sistema. *}
      {**************************************************MA*}

      edtCodEmpresa.Text := fCfgSis('EMPMAT');
      If fEmptyStr(edtCodEmpresa.Text) Then
        edtCodEmpresa.Text := VS_strCodEmp;
    End
    Else
    Begin
      {*****************************************************}
      {* Utiliza definição de empresa matriz por loja      *}
      {* Informação obtida nas configurações do sistema.   *}
      {* Busca empresa matriz no cadastro de empresas    . *}
      {**************************************************MA*}

      edtCodEmpresa.Text := fRetEmpresaMatrizDoGrupo(VS_strCodEmp);
      If fEmptyStr(edtCodEmpresa.Text) Then
         edtCodEmpresa.Text := VS_strCodEmp;
    End;
  End;

  clbPreTab.Items.Clear;
  for intTabPre:= 1 To Length(Trim(VS_strTabVen)) do
  begin
    if SameText(VS_strTabVen[intTabPre], 'S') then
      clbPreTab.Items.Add(IntToStr(intTabPre));
  end;

  lblSitPro.Visible := fCfgSis('SITPRO', varBoolean);
  edtSitPro.Visible := lblSitPro.Visible;
  edtDesSitPro.Visible := lblSitPro.Visible;

  edtCodEmpresa.OnExit(Sender);

  If pnlExpEtiEle.Visible Then
  Begin
    edtCodEmpresaEtiEle.Text := VS_strCodEmp;
    edtCodEmpresaEtiEle.OnExit(Sender);
  End;

  fValidaCampos(edtCodAmz, true);

  pSetFocus(mskDtaIni);
end;

procedure TfrmFiltroEtiItens.pSetaCampos;
  Var
    objCampo     : TCfgLocFis;
    objCfgLocFis : TCamposCfgLocFis;
Begin
  objCfgLocFis := TCamposCfgLocFis.Create;
  Try

    For objCampo in objCfgLocFis Do
    Begin

      If objCampo.strNomCam = 'LOC_CODLSE' Then
        Continue;

      With objCampo Do
      Begin
        If strNomCam = 'LOC_R_U_A_' Then
        Begin
          pSetaConfiguracoes(edtRuaIni);
          pSetaConfiguracoes(edtRuaFin);
        End

        Else
        If strNomCam = 'LOC_PREDIO' Then
        Begin
          pSetaConfiguracoes(edtPredioIni);
          pSetaConfiguracoes(edtPredioFin);
        End

        Else
        If strNomCam = 'LOC_ANDAR_' Then
        Begin
          pSetaConfiguracoes(edtAndarIni);
          pSetaConfiguracoes(edtAndarFin);
        End

        Else
        If strNomCam = 'LOC_APARTA' Then
        Begin
          pSetaConfiguracoes(edtApartamentoIni);
          pSetaConfiguracoes(edtApartamentoFin);
        End;
      End;
    End;
  Finally
    FreeAndNil(objCfgLocFis);
  End;

End;

end.

