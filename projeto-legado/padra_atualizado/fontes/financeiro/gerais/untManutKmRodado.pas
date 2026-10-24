unit untManutKmRodado;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiCad, AppEvnts, Menus, ComCtrls, StdCtrls, Buttons,
  ExtCtrls, Mask, DBCtrls, DBEditFocus, System.StrUtils, MaskEditFocus, EditFocus, DB, untManKmt, Uni,
  QColorLabel, DBMemoFocus, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxCalendar, cxDBEdit;

type
  TfrmManutKmRodado = class(TfrmPaiCad)
    pnlFundo: TPanel;
    dbePlaVei: TDBEditFocus;
    dbeKmtIni: TDBEditFocus;
    dbeKmtFin: TDBEditFocus;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    lblConsLt: TLabel;
    lblConsKM: TLabel;
    edtDesVei: TEditFocus;
    dbeAbaVlr: TDBEditFocus;
    dbeAbaLit: TDBEditFocus;
    edtConLit: TEditFocus;
    edtConVlr: TEditFocus;
    dtsManKm_: TDataSource;
    edtNomMot: TEditFocus;
    dbeCodMot: TDBEditFocus;
    Label9: TLabel;
    edtKmRoda: TEditFocus;
    lbl1: TLabel;
    lbl2: TLabel;
    edtKm_Lit: TEditFocus;
    dbeHistor: TDBMemoFocus;
    Label10: TLabel;
    dbeManVlr: TDBEditFocus;
    Label11: TLabel;
    gpbTipLan: TGroupBox;
    ColorLabel1: TColorLabel;
    dbeTipLan: TDBEditFocus;
    Label7: TLabel;
    dbeAutAba: TDBEditFocus;
    pnlDadosPedagio: TPanel;
    Label8: TLabel;
    dbeVltPdg: TDBEditFocus;
    lblFornecedor: TLabel;
    dbeCodFor: TDBEditFocus;
    edtNomFor: TEditFocus;
    btnGerarContasAPagar: TBitBtnLocked;
    mskDtaCad: TcxDBDateEdit;
    lbl3: TLabel;
    edtValor_lit: TEditFocus;
    lblKmAtual: TLabel;
    procedure btnPesquisaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure dbePlaVeiKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnGravarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure dbeCodMotKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure dbeHistorKeyPress(Sender: TObject; var Key: Char);
    procedure dbeAutAbaKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodForKeyPress(Sender: TObject; var Key: Char);
    procedure btnGerarContasAPagarClick(Sender: TObject);
    procedure dtsManKm_DataChange(Sender: TObject; Field: TField);
  private
    objManKmt: TManKmt;
    strUtilizada: String;   // SE A AUTORIZAÇÃO FOI OU NAO UTILIZADA -> MO
    blnEncontrado: Boolean;  // SE ENCONTROU OU NAO O REGISTRO PROCURADO -> MO
    blnGravaExclui: Boolean; // VAI DETERMINAR DE ONDE VEIO A CHAMADA DA PROCEDURE pAtualizaAutAba -> MO

    FSequencialExclusao: String;
    FPlacaVeiculoAnterior: String;

    FFornecedor: TUniQuery;

    procedure pCarregaDadosAdicionais;
    procedure pTrataKmConserto;
    procedure pCalculaKmRodado;
    procedure pInsereHistAutAbast;
    procedure pAtualizaAutAba;
    procedure pAtualizaCadVeiculo;
    procedure pHabDadosPedagioApenas(blnhab: boolean);

    procedure CarregaFornecedor;

    procedure GerarContasAPagar;
    function ValidaSeGerouContasAPagar: Boolean;
  protected
    function  fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; override;
    procedure pAfterScroll(DataSet: TDataSet);
  public
    { Public declarations }
  end;


implementation

uses untFuncoesSimples, untPai, untConsultas, untTypesSistema, untGravando,
     untCadPag, untFuncoes, untSelVenc, untPesqAux;

{$R *.dfm}

function TfrmManutKmRodado.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    intKmtIni: Integer;
    intKmtFin: Integer;
    strUltKmt: String;
    fltTotLitros,
    fltAbaVlr : double;
Begin

  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = mskDtaCad) Then
    Begin
      If (fEmptyStr(fTiraCaracEspeciais(mskDtaCad.Text))) Then
      Begin
        fMensagem('ATENÇÃO!','A data deve ser preenchida!',['&O k']);
        Result := False;
      End;
    End;

    {********************}
    {* VALIDA O VEICULO *}
    {*****************PZ*}
    If (Sender = dbePlaVei) Then
    Begin
      lblKmAtual.Caption := '';
      If (fEmptyStr(dbePlaVei.Text)) Then
      Begin
        fMensagem('ATENÇÃO!','A placa do veículo deve ser preenchida!',['&O k']);
        Result := False;
      End
      Else
      Begin
        If fVeiculoInativo(dbePlaVei.Text) Then
        Begin
          edtDesVei.Text := '';
          fMensagem('','Este veículo está inativo.',['&O k']);
          Result := False;
        End
        Else
        Begin
          edtDesVei.Text := fRetornaDescricaoVeic(dbePlaVei.Text);

          If (fEmptyStr(edtDesVei.Text)) Then
          Begin
            fMensagem('','Este veículo não está cadastrado, ou a placa digitada não é válida.',['&O k']);
            Result := False;
          End
          Else
            lblKmAtual.Caption := 'KM Atual do Cadastro de Veiculo: ' + IntToStr(fCampoTabela('VEI_KMATUA', 'CADVEI', ['VEI_PLAVEI'], [dbePlaVei.Text]));
        End;

      End;

      If (Result And
      (fEmptyStr(Trim(dbeKmtIni.Text)) Or SameText(dbeKmtIni.Text, '000000')) And
      (qryTabela.State = dsInsert)) And (FPlacaVeiculoAnterior <> dbePlaVei.Text)   Then
      Begin
        dbeKmtIni.Field.Value := objManKmt.fRetornaKmFinal(dbePlaVei.Text);
        dbeKmtFin.Field.Value := objManKmt.fRetornaKmFinal(dbePlaVei.Text);
        FPlacaVeiculoAnterior := dbePlaVei.Text;
      End;


    End

    Else If (Sender = dbeAutAba) Then
    Begin

      If Not fEmptyStr(dbeAutAba.Text) And (qryTabela.State = dsInsert) Then
      Begin
        pInsereHistAutAbast;

        If blnEncontrado Then
        Begin
          If strUtilizada = 'S' Then
          Begin
            fMensagem('AVISO!','Esta Autorização de Abastecimento já foi utilizada.',['&O k']);
            Result := False;
            Exit;
          End;

          dbeTipLan.Text := 'A';
          fValidaCampos(dbeTipLan, blnBuscaPorChave);
          dbeTipLan.Enabled := False;
        End
        Else
        Begin
          pSetFocus(Sender);
          Result := False;
        End;
      End
      Else
        dbeTipLan.Enabled := True;

    End

    {********************}
    {* VALIDA MOTORISTA *}
    {*****************JU*}
    Else If Sender = dbeCodMot Then
    Begin

      If fEmptyStr(dbeCodMot.Text) Then
      Begin
        fMensagem('', 'O campo Motorista deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        dbeCodMot.Text := fStrZero(dbeCodMot.Text, 5);

        edtNomMot.Text := fRetNomeMotorista(dbeCodMot.Text, True);

        If fEmptyStr(edtNomMot.Text) Then
        Begin
          fMensagem('', 'Código de motorista não encontrado!', ['&Ok']);
          Result := False;
        End;

      End;

    End

    {******************************}
    {* VALIDA O KILÔMETRO INICIAL *}
    {***************************PZ*}
    Else If (Sender = dbeKmtIni) Then
    Begin
      If (fEmptyStr(dbeKmtIni.Text)) And
         (dbeTipLan.Text = 'A')      Then
      Begin
        fMensagem('ATENÇÃO!','O quilômetro inicial deve ser preenchido!',['&O k']);
        Result := False;
      End
      Else
      Begin
        intKmtIni := StrToIntDef(dbeKmtIni.Text, 0);

        If (qryTabela.State = dsEdit) Then
          strUltKmt := objManKmt.fRetornaKmFinal(dbePlaVei.Text, qryTabela.FieldByName('AUTOINCREM').AsString, IIF(dbeTipLan.Text = 'A', 'A', '') )
        Else
          strUltKmt := objManKmt.fRetornaKmFinal(dbePlaVei.Text, '', IIF(dbeTipLan.Text = 'A', 'A', ''));

        If (intKmtIni <= 0) And Not MatchStr(dbeTipLan.Text,['C','P']) Then
        Begin
          fMensagem('ATENÇÃO!','O quilômetro inicial deve ser maior que zero!',['&O k']);
          Result := False;
        End;
      End;
    End

    {****************************}
    {* VALIDA O KILÔMETRO FINAL *}
    {*************************PZ*}
    Else If (Sender = dbeKmtFin) Then
    Begin
      If (fEmptyStr(dbeKmtFin.Text)) And
         (dbeTipLan.Text = 'A')      Then
      Begin
        fMensagem('ATENÇÃO!','O quilômetro final deve ser preenchido!',['&O k']);
        Result := False;
      End
      Else
      Begin
        intKmtIni := StrToIntDef(dbeKmtIni.Text, 0);
        intKmtFin := StrToIntDef(dbeKmtFin.Text, 0);

        If (intKmtFin <= 0) And Not MatchStr(dbeTipLan.Text,['C','P']) Then
        Begin
          fMensagem('ATENÇÃO!','O quilômetro final deve ser maior que zero!',['&O k']);
          Result := False;
        End
        Else If (intKmtIni > intKmtFin) And Not MatchStr(dbeTipLan.Text,['C','P']) Then
        Begin
          fMensagem('ATENÇÃO!','O quilômetro final deve ser maior ou igual ao quilômetro inicial!',['&O k']);
          blnMudarFoco := False;
          pSetFocus(dbeKmtIni);
          Result := False;
        End;
      End;

    End

    {***********************************}
    {* VALIDA O VALOR DO ABASTECIMENTO *}
    {********************************PZ*}
    Else If (Sender = dbeAbaVlr) Then
    Begin
      If (fEmptyStr(dbeAbaVlr.Text)) Then
      Begin
        fMensagem('ATENÇÃO!','O Valor do abastecimento deve ser preenchido!',['&O k']);
        Result := False;
      End
      Else If (fStrToFloat(dbeAbaVlr.Text) < 0) And
              (dbeAbaVlr.Enabled) Then
      Begin
        fMensagem('ATENÇÃO!','O Valor do abastecimento deve ser maior ou igual a zero!',['&O k']);
        Result := False;
      End
      Else If (fStrToFloat(dbeAbaVlr.Text) > 0) Then
      Begin

        If (Not fEmptyStr(dbeKmtIni.Text)) Then
          intKmtIni := strToIntDef(dbeKmtIni.Text, 0)
        Else
          intKmtIni := 0;

        If (Not fEmptyStr(dbeKmtFin.Text)) Then
          intKmtFin := strToIntDef(dbeKmtFin.Text, 0)
        Else
          intKmtFin := 0;

        If (Not fEmptyStr(dbeAbaLit.Text)) Then
           fltTotLitros := fStrToFloat(dbeAbaLit.Text)
        Else
           fltTotLitros := 0;

        edtConVlr.Text := objManKmt.fCalculaConsumoValor(intKmtIni, intKmtFin, fStrToFloat(dbeAbaVlr.Text));
        edtKm_Lit.Text := objManKmt.fCalculaKmPorLitro(intKmtIni, intKmtFin, fStrToFloat(dbeAbaLit.Text));
        edtValor_lit.Text := objManKmt.fCalculaValorDoLitro(fStrToFloat(dbeAbaVlr.Text), fltTotLitros);
      End;
    End

    {*************************************}
    {* VALIDA OS LITROS DO ABASTECIMENTO *}
    {**********************************PZ*}
    Else If (Sender = dbeAbaLit) Then
    Begin
      If dbeTipLan.Field.AsString = 'A' Then
      Begin
        If (fEmptyStr(dbeAbaLit.Text)) Then
        Begin
          fMensagem('ATENÇÃO!','Os litros do abastecimento deve ser preenchido!',['&O k']);
          Result := False;
        End
        Else If (fStrToFloat(dbeAbaLit.Text) <= 0) And
                (dbeAbaLit.Enabled) Then
        Begin
          fMensagem('ATENÇÃO!','Os litros do abastecimento deve maior que zero!',['&O k']);
          Result := False;
        End
        Else
        Begin
          If (Not fEmptyStr(dbeKmtIni.Text)) Then
            intKmtIni := strToIntDef(dbeKmtIni.Text, 0)
          Else
            intKmtIni := 0;

          If (Not fEmptyStr(dbeKmtFin.Text)) Then
            intKmtFin := strToIntDef(dbeKmtFin.Text, 0)
          Else
            intKmtFin := 0;

          If (Not fEmptyStr(dbeAbaVlr.Text)) Then
             fltAbaVlr := fStrToFloat(dbeAbaVlr.Text)
          Else
             fltAbaVlr := 0;

          edtConLit.Text := objManKmt.fCalculaConsumoLitros(intKmtIni, intKmtFin, fStrToFloat(dbeAbaLit.Text));
          edtConVlr.Text := objManKmt.fCalculaConsumoValor(intKmtIni, intKmtFin, fStrToFloat(dbeAbaVlr.Text));
          edtKm_Lit.Text := objManKmt.fCalculaKmPorLitro(intKmtIni, intKmtFin, fStrToFloat(dbeAbaLit.Text));
          edtValor_lit.Text := objManKmt.fCalculaValorDoLitro(fltAbaVlr, fStrToFloat(dbeAbaLit.Text));
        End;
      End;
    End
    {*****************************}
    {* VALIDA TIPO DE LANÇAMENTO *}
    {**************************JU*}
    Else If (Sender = dbeTipLan) Then
    Begin
      If fEmptyStr(dbeTipLan.Text) Then
      Begin
        fMensagem('', 'O Campo Tipo de lançamento deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        If Pos(dbeTipLan.Text, 'A_C_P') <= 0 Then
        Begin
          fMensagem('', 'O campo Tipo de lançamento de ser A, C ou P!', ['&O k']);
          Result := False;
        End;

        If (Result And
          (fEmptyStr(Trim(dbeKmtIni.Text)) Or SameText(dbeKmtIni.Text, '000000')) And
          (qryTabela.State = dsInsert)) And  (FPlacaVeiculoAnterior <> dbePlaVei.Text)  Then
        begin
          dbeKmtIni.Field.Value := objManKmt.fRetornaKmFinal(dbePlaVei.Text, '', IIF(dbeTipLan.Text = 'A', 'A', ''));
          FPlacaVeiculoAnterior := dbePlaVei.Text;
        end;

        if fEmptyStr(dbeKmtIni.Text) And (FPlacaVeiculoAnterior <> dbePlaVei.Text)  then
        Begin
          dbeKmtIni.Field.Value := objManKmt.fRetornaKmFinal(dbePlaVei.Text);
          FPlacaVeiculoAnterior := dbePlaVei.Text;
        End;

        If (dbeTipLan.Text = 'C') Then
        Begin
          dbeAbaVlr.Field.Value := 0.00;
          dbeAbaLit.Field.Value := 0.000;
        end;

      End;
    End
    {******************************}
    {* VALIDA VALOR DE MANUTENÇÃO *}
    {***************************JU*}
    Else If (Sender = dbeManVlr) And
            (dbeManVlr.Enabled) Then
    Begin
      If (fEmptyStr(dbeManVlr.Text)) Then
      Begin
        fMensagem('ATENÇÃO!','O Valor de manutenção deve ser preenchido!',['&O k']);
        Result := False;
      End
      Else If (fStrToFloat(dbeManVlr.Text) < 0) Then
      Begin
        fMensagem('ATENÇÃO!','O Valor de manutenção deve ser maior ou igual a zero!',['&O k']);
        Result := False;
      End
    End

    {******************************}
    {* VALIDA VALOR DO PEDAGIO    *}
    {***************************JU*}
    Else If (Sender = dbeVltPdg) And
            (pnldadosPedagio.Visible) Then
    Begin
      If (fEmptyStr(dbeVltPdg.Text)) Then
      Begin
        fMensagem('ATENÇÃO!','O Valor do Pedágio deve ser preenchido!',['&O k']);
        Result := False;
      End
      Else If (fStrToFloat(dbeVltPdg.Text) <= 0) Then
      Begin
        fMensagem('ATENÇÃO!','O Valor do Pedágio deve ser maior ou igual a zero!',['&O k']);
        Result := False;
      End
    End

    Else If (Sender = dbeCodFor) Then
    Begin
      CarregaFornecedor;

      If Not fEmptyStr(dbeCodFor.Text) Then
      Begin
        If FFornecedor.FieldByName('FOR_NOMFOR').AsString.IsEmpty Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Fornecedor não está cadastrado!', ['&Ok']);
          Result := False;
        End
        Else If FFornecedor.FieldByName('FOR_STATUS').AsString <> 'A' Then
        Begin
          If qryTabela.FieldByName('KMT_CODFOR').Value <> qryTabela.FieldByName('KMT_CODFOR').OldValue then
          begin
            fMensagem('ATENÇÃO!', 'Esse fornecedor está inativo!', ['&Ok']);
            Result := False;
          END;
        End;
      End;
    End;

  End;

  //if blnEncontrado then
  //Begin
  pTrataKmConserto;

  pHabDadosPedagioApenas( dbeTipLan.Text = 'P' );

  pCalculaKmRodado;
  //End;

  If ((Not Result) And (blnMudarFoco)) Then
    pSetFocus(Sender);

End;

procedure TfrmManutKmRodado.GerarContasAPagar;
  Var
    frmSelVen: TfrmSelVen;

    LDuplucataCTP: String;

    LValor: Double;
begin
  Try
    pCriarFormularios(TfrmSelVen, frmSelVen);
    frmSelVen.mskCompet.Text    := FormatDateTime('mm/yyyy', fNow);
    frmSelVen.mskDtaVen.Date    := VS_Date;

    frmSelVen.edtCodEmp.Text := VS_strCodEmp;
    frmSelVen.edtNomEmp.Text := fRetNomeEmpresa;

    frmSelVen.HabilitaPrevisao;

    If dbeTipLan.Text = 'A' Then
    Begin
      frmSelVen.memHistorico.Text := 'KM RODADO - VEÍCULO: ' + dbePlaVei.Text + '-' + edtDesvei.Text + #13 +
                                     'AUTORIZAÇÃO: ' + dbeAutAba.Text;

      LValor := qryTabela.FieldByName('KMT_ABAVLR').AsFloat +
                qryTabela.FieldByName('KMT_MANVLR').AsFloat;
    End
    Else If  dbeTipLan.Text = 'C' Then
    Begin
      frmSelVen.memHistorico.Text := 'KM RODADO - VEÍCULO: ' + dbePlaVei.Text + '-' + edtDesvei.Text + #13 +
                                     'CONSERTO/MANUTENÇÃO';

      LValor := qryTabela.FieldByName('KMT_MANVLR').AsFloat;
    End
    Else
    Begin
      frmSelVen.memHistorico.Text := 'KM RODADO - VEÍCULO: ' + dbePlaVei.Text + '-' + edtDesvei.Text + #13 +
                                     'PEDÁGIO';

      LValor := qryTabela.FieldByName('KMT_VLTPDG').AsFloat;
    End;

    frmSelVen.strFUNCPG := 'KMT';

    frmSelVen.ShowModal;

    If frmSelVen.ModalResult <> mrOk Then
      Exit;


    If qryTabela.FieldByName('KMT_DTACAD').AsDateTime > frmSelVen.mskDtaVen.Date Then
    Begin
      fMensagem('ATENÇÃO', 'A data de vencimento não pode ser menor que a data de cadastro do registro.', ['&Ok']);
      Exit;
    End;

    fStartTransaction;

    LDuplucataCTP := fRetSequencialCadPag;

    If Not fGravaCadPag(Self.Name,
                       'INCLUSÃO - KM RODADO',
                       dbeCodFor.Text,
                       LDuplucataCTP,
                       'A',
                       frmSelVen.edtCodEmp.Text,
                       frmSelVen.fraPlanoDeContas.MskCodCta.Text,
                       '1',
                       0,
                       qryTabela.FieldByName('KMT_DTACAD').AsDateTime,
                       frmSelVen.mskDtaVen.Date,
                       LValor,
                       LValor,
                       frmSelVen.edtPrevis.Text,
                       'N',
                       'N',
                       frmSelVen.memHistorico.Text,
                       EmptyStr,
                       EmptyStr,
                       EmptyStr,
                       EmptyStr,
                       EmptyStr,
                       EmptyStr,
                       0,
                       0,
                       0,
                       0,
                       VS_strCodEmp,
                       frmSelVen.fraCentroCusto.edtCodEve.Text,
                       'N',
                       frmSelVen.edtCodPor.Text,
                       EmptyStr,
                       0,
                       0,
                       0,
                       False,
                       0,
                       '',
                       0,
                       'N',
                       '',
                       '',
                       '',
                       '',
                       '',
                       '',
                       '',
                       '',
                       '',
                       frmSelVen.mskCompet.Text,
                       '',
                       '',
                       '',
                       '',
                       0,
                       0,
                       0,
                       0,
                       '',
                       0,
                       0,
                       '',
                       '',
                       '',
                       '',
                       '',
                       '0',
                       '',
                       '',
                       '',
                       '',
                       'N',
                       '',
                       '',
                       '',
                       '',
                       0,
                       '',
                       0) Then
    Begin
      fRollback;
      fMensagem('ATENÇÃO', 'Geração do Contas a Pagar não foi realizada.', ['&Ok']);
      Exit;
    End;

    qryTabela.Edit;
    qryTabela.FieldByName('KMT_CTPDOC').AsString := LDuplucataCTP +
                                                    '-A-' +
                                                    frmSelVen.edtCodEmp.Text + '-' +
                                                    dbeCodFor.Text + '-1';
    qryTabela.Post;

    fCommit;

    fMensagem('ATENÇÃO', 'Geração do Contas a Pagar realizada com sucesso.', ['&Ok']);
  Finally
    FreeAndNil(frmSelVen);
  End;
end;

procedure TfrmManutKmRodado.pCalculaKmRodado;
begin
  If (Not dbeKmtIni.Field.IsNull) And
     (Not dbeKmtFin.Field.IsNull) Then
  Begin
    edtKmRoda.Text := IntToStr(StrToIntDef(dbeKmtFin.Text, 0) - StrToIntDef(dbeKmtIni.Text, 0));
  End;
end;

{************************************************}
{* Prepara tela quando é lançamento de Conserto *}
{* RQ.16593 ********************************* BB*}
procedure TfrmManutKmRodado.pTrataKmConserto;
begin
  If dbeTipLan.Text = 'C' Then
  Begin
    If dbeKmtFin.Text = '' Then
      dbeKmtFin.Field.Value := dbeKmtIni.field.Value;

    dbeAbaVlr.Enabled := False;
    dbeAbaLit.Enabled := False;
    dbeManVlr.Enabled := True;
    lblConsKM.Visible := False;
    edtConVlr.Visible := False;
    lblConsLt.Visible := False;
    edtConLit.Visible := False;
    lbl2.Visible      := False;
    edtKm_Lit.Visible := False;
    lbl3.Visible      := False;
    edtValor_Lit.Visible := False;
  End
  Else
  If dbeTipLan.Text = 'A' Then
  Begin
    if strUtilizada = 'N' Then
    Begin
      dbeKmtIni.Enabled := True;
      dbeKmtFin.Enabled := True;
      dbeAbaVlr.Enabled := True;
      dbeAbaLit.Enabled := True;
      dbeManVlr.Enabled := False;
    End;

    lblConsKM.Visible := True;
    edtConVlr.Visible := True;
    lblConsLt.Visible := True;
    edtConLit.Visible := True;
    lbl2.Visible      := True;
    edtKm_Lit.Visible := True;
    lbl3.Visible      := True;
    edtValor_Lit.Visible := True;
  End;

end;

function TfrmManutKmRodado.ValidaSeGerouContasAPagar: Boolean;
begin
  Result := True;

  If qryTabela.FieldByName('KMT_CTPDOC').AsString.IsEmpty Then
    Exit;

  If qryTabela.State <> dsBrowse Then
    btnCancela.Click;

  fMensagem('ATENÇÃO', 'Não é possível alterar ou excluir um registro com Contas a Pagar gerado.', ['&Ok']);
  Exit(False);
end;

procedure TfrmManutKmRodado.pInicializaIndices;
Begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;
End;

procedure TfrmManutKmRodado.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrVeic: TConsultasArray;
begin
  {*****************************************}
  {* NOVA CONSULTA DE MANUTENÇÃO KM RODADO *}
  {**************************************RV*}
  chrKey := '/';
  If fPesqKmRodadoVeic(Self, Nil, Nil, qryTabela, chrKey, arrVeic) Then
  Begin
    edtConLit.Text := objManKmt.fCalculaConsumoLitros(strToIntDef(qryTabela.FieldByName('KMT_KMTINI').AsString, 0), strToIntDef(qryTabela.FieldByName('KMT_KMTFIN').AsString, 0), qryTabela.FieldByName('KMT_ABALIT').AsFloat);
    edtConVlr.Text := objManKmt.fCalculaConsumoValor(strToIntDef(qryTabela.FieldByName('KMT_KMTINI').AsString, 0), strToIntDef(qryTabela.FieldByName('KMT_KMTFIN').AsString, 0), qryTabela.FieldByName('KMT_ABAVLR').AsFloat);
    edtKm_Lit.Text := objManKmt.fCalculaKmPorLitro(strToIntDef(qryTabela.FieldByName('KMT_KMTINI').AsString, 0), strToIntDef(qryTabela.FieldByName('KMT_KMTFIN').AsString, 0), qryTabela.FieldByName('KMT_ABALIT').AsFloat);
    edtValor_lit.Text := objManKmt.fCalculaValorDoLitro( qryTabela.FieldByName('KMT_ABAVLR').AsFloat, qryTabela.FieldByName('KMT_ABALIT').AsFloat );
    edtNomFor.Clear;

    pSetFocus(btnAlterar);
  End;

  mskDtaCad.Enabled := False;

  pCarregaDadosAdicionais;
  pHabDadosPedagioApenas( (dbeTipLan.Text = 'P') );
end;

procedure TfrmManutKmRodado.CarregaFornecedor;
begin
  pPesquisaCadFor(FFornecedor, FFornecedor, dbeCodFor.Text);
  edtNomFor.Text := FFornecedor.FieldByName('FOR_NOMFOR').AsString;
end;

procedure TfrmManutKmRodado.FormCreate(Sender: TObject);
begin
  objManKmt := TManKmt.Create(Self);
  inherited;
  strNomeTabela         := 'MANKMT';
  strNomeCampo          := 'AUTOINCREM';
  qryTabela             := objManKmt.qryTabela;
  qryTabela.AfterScroll := pAfterScroll;
  dtsManKm_.DataSet     := qryTabela;

  FFornecedor := fCriarQuery('SELECT * FROM CADFOR WHERE FALSE');
  FPlacaVeiculoAnterior := '';
end;

procedure TfrmManutKmRodado.FormShow(Sender: TObject);
begin
  inherited;
  pCarregaDadosAdicionais;
  (qryTabela.FieldByName('KMT_VLTPDG') As TFloatField).DisplayFormat := '#,##0.00';
end;

procedure TfrmManutKmRodado.btnIncluirClick(Sender: TObject);
begin
  if blnEncontrado Then
    qryTabela.Cancel;

  inherited;
  // A TRAVA QUE EVITA RECARREGAR O KM VALE SO PARA A INCLUSAO EM ANDAMENTO
  FPlacaVeiculoAnterior := '';
  mskDtaCad.DataBinding.Field.Value := VS_Date;
  dbeAbaVlr.Field.Value := 0.00;
  dbeAbaLit.Field.Value := 0.000;
  dbeManVlr.Field.Value := 0.00;
  edtConLit.Text        := '0,00';
  edtConVlr.Text        := '0,00';
  edtKm_Lit.Text        := '0,00';
  edtValor_lit.Text     := '0,000';
  edtKmRoda.Text        := '0';
  edtDesVei.Clear;
  edtNomMot.Clear;
  edtNomFor.Clear;
  pHabDadosPedagioApenas( False );
  dbeVltPdg.Field.Value := 0.00;

  mskDtaCad.Enabled := True;
  btnGerarContasAPagar.Enabled := False;

  pSetFocus(mskDtaCad);
end;

procedure TfrmManutKmRodado.dbeAutAbaKeyPress(Sender: TObject; var Key: Char);
  Var
    arrAbastecimento: TConsultasArray;
begin
  inherited;

  If fPesqAbastecimento(Self, dbeAutAba, Nil, Key, arrAbastecimento, True, 'Consulta de Autorização de Abastecimento', VS_strCodEmp) Then
  Begin
    If fValidaCampos(dbeAutAba, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmManutKmRodado.dbeCodForKeyPress(Sender: TObject; var Key: Char);
  Var
    arrFornec: TConsultasArray;
begin
  inherited;
  {*********************************}
  {* NOVA CONSULTA DE FORNECEDORES *}
  {******************************RV*}
  If fPesqFornecedor(conForCompleta, Self, dbeCodFor, edtNomFor, Nil, Key, arrFornec) Then
  Begin
    If fValidaCampos(dbeCodFor, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmManutKmRodado.dbeCodMotKeyPress(Sender: TObject; var Key: Char);
  Var
    arrMotorista: TConsultasArray;

begin
  inherited;

  If fPesqMotorista(Self, dbeCodMot, edtNomMot, Nil, Key, arrMotorista, True, True) Then
  Begin
    If fValidaCampos(dbeCodMot, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmManutKmRodado.dbeHistorKeyPress(Sender: TObject; var Key: Char);
  Var
    strKey : String;
begin
  inherited;
  strKey := Key;
  strKey := AnsiUpperCase(strKey);
  Key    := strKey[1];
end;

procedure TfrmManutKmRodado.dbePlaVeiKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrVeic: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE VEÍCULOS   *}
  {****************************RV*}
  If fPesqVeiculos(Self, dbePlaVei, edtDesVei, Nil, Key, arrVeic, True, False, ' VEI_STATUS = "A" ' ) Then
  Begin
    If fValidaCampos(dbePlaVei, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmManutKmRodado.dtsManKm_DataChange(Sender: TObject; Field: TField);
begin
  inherited;
  If (Not fEmptyStr(dbePlaVei.Text)) Then
    lblKmAtual.Caption := 'KM Atual do Cadastro de Veiculo: ' + IntToStr(fCampoTabela('VEI_KMATUA', 'CADVEI', ['VEI_PLAVEI'], [dbePlaVei.Text]))
  Else
    lblKmAtual.Caption := '';
end;

procedure TfrmManutKmRodado.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  If (Action <> CaNone) Then
  Begin
    qryTabela.AfterScroll := Nil;
    FreeAndNil(objManKmt);

    FreeAndNil(FFornecedor);
  End;
end;

procedure TfrmManutKmRodado.btnGerarContasAPagarClick(Sender: TObject);
  Var
    LDireitos: String;
begin
  inherited;
  If Not btnGerarContasAPagar.Enabled Then
    Exit;

  If qryTabela.IsEmpty Then
  Begin
    fMensagem('ATENÇÃO', 'É necessário selecionar um registro para utilizar essa função.', ['&Ok']);
    Exit;
  End;

  fValidarDirEspecificos(LDireitos, strLoginUsuarioLogado, Self.Name);
  If Pos('I', LDireitos) <= 0 Then
  Begin
    fMensagem('ATENÇÃO', 'O operador não possui permissão para utilizar essa função.', ['&Ok']);
    Exit;
  End;

  If qryTabela.FieldByName('KMT_CODFOR').AsString.IsEmpty Then
  Begin
    fMensagem('ATENÇÃO', 'É necessário selecionar um Fornecedor para utilizar essa função.', ['&Ok']);
    Exit;
  End;

  If fFormataFloat(qryTabela.FieldByName('KMT_ABAVLR').AsFloat +
                   qryTabela.FieldByName('KMT_MANVLR').AsFloat +
                   qryTabela.FieldByName('KMT_VLTPDG').AsFloat, 2) = 0 Then
  Begin
    fMensagem('ATENÇÃO', 'É necessário possuir valor maior que zero para utilizar essa função.', ['&Ok']);
    Exit;
  End;

  If fMensagem('ATENÇÃO', 'Tem certeza que deseja gerar o contas a pagar desse registro?', ['&Sim', '&Não']) = 2 Then
    Exit;

  TfrmGravando.fExecutarModal(GerarContasAPagar, 'Aguarde... Gerando Contas a Pagar.', '');
  pCarregaDadosAdicionais;
end;

procedure TfrmManutKmRodado.btnGravarClick(Sender: TObject);
begin
  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  If Not fEmptyStr(dbeKmtIni.Text) Then
    dbeKmtIni.Text := fStrZero(dbeKmtIni.Text, dbeKmtIni.MaxLength)
  Else
  If dbeKmtIni.Field.Value = '' Then
    dbeKmtIni.Field.Value := Null;

  If Not fEmptyStr(dbeKmtFin.Text) Then
    dbeKmtFin.Text := fStrZero(dbeKmtFin.Text, dbeKmtFin.MaxLength)
  Else
  If dbeKmtFin.Field.Value = '' Then
    dbeKmtFin.Field.Value := Null;

  mskDtaCad.Enabled := False;
  btnGerarContasAPagar.Enabled := qryTabela.FieldByName('KMT_CTPDOC').AsString.IsEmpty;

  If fEmptyStr(dbeCodFor.Text) Then
    qryTabela.FieldByName('KMT_CODFOR').Value := Null;

  Try
    inherited;

    blnGravaExclui := True;
    pAtualizaAutAba;
    pAtualizaCadVeiculo;

    If blnGravou Then
      fCommit
    Else
      fRollBack;
  Except
    On E: Exception Do
    Begin
      fRollBack;

      pMensagensErro('Ocorreu um erro ao gravar o registro!.' + #13 +
                     'Erro gerado: ' + E.Message, '[TfrmManutKmRodado.btnGravarClick]');
    End;
  End;
end;

procedure TfrmManutKmRodado.btnAlterarClick(Sender: TObject);
begin
  inherited;
  dbeAutAba.Enabled := False;
  dbeTipLan.Enabled := False;

  mskDtaCad.Enabled := True;
  btnGerarContasAPagar.Enabled := False;

  ValidaSeGerouContasAPagar;

  If (mskDtaCad.Enabled) Then
    pSetFocus(mskDtaCad);
end;

procedure TfrmManutKmRodado.btnCancelaClick(Sender: TObject);
Var
  intKmtIni: Integer;
  intKmtFin: Integer;
  fltTotLit,
  fltAbaVlr : double;
begin
  inherited;

  fltTotLit := 0;
  fltAbaVlr := 0;

  If dbeTipLan.Field.AsString = 'A' Then
  Begin
    intKmtIni := strToIntDef(dbeKmtIni.Text, 0);
    intKmtFin := strToIntDef(dbeKmtFin.Text, 0);

    If (Not fEmptyStr(dbeAbaLit.Text)) Then
       fltTotLit := fStrToFloat(dbeAbaLit.Text);

    If (Not fEmptyStr(dbeAbaVlr.Text)) Then
       fltAbaVlr := fStrToFloat(dbeAbaVlr.Text);

  End
  Else
  Begin
    intKmtIni := 0;
    intKmtFin := 0;
  End;

  edtConLit.Text := objManKmt.fCalculaConsumoLitros(intKmtIni, intKmtFin, fStrToFloat(dbeAbaLit.Text));
  edtConVlr.Text := objManKmt.fCalculaConsumoValor(intKmtIni, intKmtFin, fStrToFloat(dbeAbaVlr.Text));
  edtKm_Lit.Text := objManKmt.fCalculaKmPorLitro(intKmtIni, intKmtFin, fStrToFloat(dbeAbaLit.Text));
  edtValor_lit.Text := objManKmt.fCalculaValorDoLitro(fltAbaVlr, fltTotLit);

  edtDesVei.text := '';
  edtNomMot.Text := '';
  edtNomFor.Clear;

  mskDtaCad.Enabled := False;
  btnGerarContasAPagar.Enabled := qryTabela.FieldByName('KMT_CTPDOC').AsString.IsEmpty;

  pCarregaDadosAdicionais;
  pHabDadosPedagioApenas( (dbeTipLan.Text = 'P') );
end;

procedure TfrmManutKmRodado.btnExcluirClick(Sender: TObject);
Var
  strUltReg: String;
begin
  If (Not qryTabela.IsEmpty) Then
  Begin
    strUltReg := objManKmt.fUltimoLanc(qryTabela.FieldByName('KMT_PLAVEI').AsString);

    If (Not fEmptyStr(strUltReg)) And
       (strUltReg <> qryTabela.FieldByName('KMT_KMTFIN').AsString) Then
    Begin
      fMensagem('ATENÇÃO!','Só é permitido excluir o ultimo lançamento realizado para este veículo!',['&O k']);
      Exit;
    End;
  End
  Else
  Begin
    fMensagem('ATENÇÃO!','Deve selecionar um registro para utilizar essa função!',['&Ok']);
    Exit;
  End;

  If Not ValidaSeGerouContasAPagar Then
    Exit;

  Try
    blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

    FSequencialExclusao := dbeAutAba.Text;

    inherited;

    If (fEmptyStr(dbePlaVei.Text)) Then
    Begin
      blnGravaExclui := False;
      pAtualizaAutAba;

      edtDesVei.Clear;
      edtNomFor.Clear;
      edtConLit.Text := '0,00';
      edtConVlr.Text := '0,00';
      edtKm_Lit.Text := '0,00';
      edtNomMot.Clear;
    End;

    If blnExcluiu Then
      fCommit
    Else
      fRollBack;

    mskDtaCad.Enabled := False;
    btnGerarContasAPagar.Enabled := qryTabela.FieldByName('KMT_CTPDOC').AsString.IsEmpty;

    pCarregaDadosAdicionais;
    pHabDadosPedagioApenas( False );
  Except
    On E: Exception Do
    Begin
      fRollBack;

      pMensagensErro('Ocorreu um erro ao excluir o registro!.' + #13 +
                     'Erro gerado: ' + E.Message, '[TfrmManutKmRodado.btnExcluirClick]');
    End;
  End;

end;

procedure TfrmManutKmRodado.pAfterScroll(DataSet: TDataSet);
begin
  pCalculaKmRodado;
end;

procedure TfrmManutKmRodado.pCarregaDadosAdicionais;
begin
  If Not fEmptyStr(dbePlaVei.Text) Then
    edtDesVei.Text := fRetornaDescricaoVeic(dbePlaVei.Text);

  If Not fEmptyStr(dbeCodMot.Text) Then
    edtNomMot.Text := fRetNomeMotorista(dbeCodMot.Text, True);

  If Not fEmptyStr(dbeCodFor.Text) Then
    edtNomFor.Text := fRetNomFornecedor(dbeCodFor.Text);

  btnGerarContasAPagar.Enabled := qryTabela.FieldByName('KMT_CTPDOC').AsString.IsEmpty;
end;


{******************************************}
{* PROCEDURE QUE ATUALIZA A TABELA AUTABA *}
{***************************************MO*}
procedure TfrmManutKmRodado.pAtualizaAutAba;
Var
  strSQL: String;
  qryGrava: TUniQuery;
begin
  Try
    qryGrava := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'UPDATE AUTABA ';
    strSQL := strSQL + 'SET           ';

    if blnGravaExclui Then
    Begin
      strSQL := strSQL + '  ABA_PLAVEI = :ABA_PLAVEI, ';
      strSQL := strSQL + '  ABA_CODMOT = :ABA_CODMOT, ';
      strSQL := strSQL + '  ABA_VLRABA = :ABA_VLRABA, ';
      strSQL := strSQL + '  ABA_QTDLTS = :ABA_QTDLTS, ';
      strSQL := strSQL + '  ABA_STATUS = ''S''        ';
    End
    Else
      strSQL := strSQL + '  ABA_STATUS = ''N''        ';

    strSQL := strSQL + 'WHERE                       ';
    strSQL := strSQL + '  ABA_SEQABA = :ABA_SEQABA  ';
    strSQL := strSQL + '  AND ABA_CODEMP = :CODEMP ';

    With qryGrava, SQL Do
    Begin
      Close;
      Clear;
      Add(strSQL);

      if blnGravaExclui then
      Begin
        ParamByName('ABA_PLAVEI').AsString := dbePlaVei.Text;

        ParamByName('ABA_CODMOT').Value := Null;
        If Not fEmptyStr(dbeCodMot.Text) Then
          ParamByName('ABA_CODMOT').AsString := dbeCodMot.Text;

        ParamByName('ABA_VLRABA').AsString := dbeAbaVlr.Text;
        ParamByName('ABA_QTDLTS').AsString := dbeAbaLit.Text;
      End;

      ParamByName('ABA_SEQABA').AsString := dbeAutAba.Text;
      ParamByName('CODEMP').AsString := VS_strCodEmp;

      If Not blnGravaExclui Then
        ParamByName('ABA_SEQABA').AsString := FSequencialExclusao;

      ExecSql;
    End;

  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;
end;

procedure TfrmManutKmRodado.pAtualizaCadVeiculo;
  Var
    strSQL : String;
    qryGrava : TUniQuery;
begin
  qryGrava := fCriaQuery;
  Try
    Try
      strSQL := '';
      strSQL := strSQL + 'UPDATE CADVEI SET      ';
      strSQL := strSQL + '  VEI_KMATUA = :KMFINAL ';
      strSQL := strSQL + 'WHERE                  ';
      strSQL := strSQL + '  VEI_PLAVEI = :PLAVEI ';

      qryGrava.Close;
      qryGrava.SQL.Clear;
      qryGrava.SQL.Add(strSQL);
      qryGrava.ParamByName('KMFINAL').AsInteger := StrToIntDef(dbeKmtFin.Text, 0);
      qryGrava.ParamByName('PLAVEI').AsString   := dbePlaVei.Text;
      qryGrava.ExecSql;
    Except
      On E: Exception Do
        Raise Exception.Create(E.Message);
    End;
  Finally
    FreeAndNil(qryGrava);
  End;
end;

procedure TfrmManutKmRodado.pInsereHistAutAbast;
  Var
    strSQL: String;
    qryGen: TUniQuery;
Begin
  Try
    qryGen := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT                 ';
    strSQL := strSQL + '  ABA_SEQABA,          ';
    strSQL := strSQL + '  ABA_VLRABA,          ';
    strSQL := strSQL + '  ABA_COMBUS,          ';
    strSQL := strSQL + '  ABA_PLAVEI,          ';
    strSQL := strSQL + '  ABA_QTDLTS,          ';
    strSQL := strSQL + '  ABA_CODMOT,          ';
    strSQL := strSQL + '  ABA_CODFOR,          ';
    strSQL := strSQL + '  FOR_NOMFOR,          ';
    strSQL := strSQL + '  ABA_STATUS           ';
    strSQL := strSQL + 'FROM                   ';
    strSQL := strSQL + '  AUTABA               ';
    strSQL := strSQL + '  LEFT JOIN CADFOR ON FOR_CODFOR = ABA_CODFOR ';
    strSQL := strSQL + 'WHERE                  ';
    strSQL := strSQL + '  ABA_SEQABA = :SEQABA ';
    strSQL := strSQL + '  AND ABA_CODEMP = :CODEMP ';

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('SEQABA').AsString := dbeAutAba.Text;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;
    End;

    if qryGen.RecordCount > 0 Then
    Begin
      strUtilizada := qryGen.FieldByName('ABA_STATUS').AsString;
      blnEncontrado := True;

      If strUtilizada.Equals('S') Then Exit;

      If dbePlaVei.Field.AsString.IsEmpty Then
        dbePlaVei.Field.Value := qryGen.FieldByName('ABA_PLAVEI').AsString;
      fValidaCampos(dbePlaVei, True);

      dbeTipLan.Text := 'A';
      dbeTipLan.Field.Value := 'A';

      If dbeAbaLit.Field.AsFloat = 0 Then
        dbeAbaLit.Field.Value := qryGen.FieldByName('ABA_QTDLTS').AsFloat;

      If dbeAbaVlr.Field.AsFloat = 0 Then
        dbeAbaVlr.Field.Value := qryGen.FieldByName('ABA_VLRABA').AsFloat;

      If dbeCodMot.Field.AsString.IsEmpty Then
        dbeCodMot.Field.Value := qryGen.FieldByName('ABA_CODMOT').AsString;

      If dbeCodFor.Field.AsString.IsEmpty Then
        dbeCodFor.Field.Value := qryGen.FieldByName('ABA_CODFOR').AsString;

      fValidaCampos(dbeCodMot, True);
      fValidaCampos(dbeCodFor, True);

      If dbeHistor.Field.AsString.IsEmpty Then
        If dbeHistor.Lines.Count = 0 Then
        Begin
          dbeHistor.Lines.Add('Fornecedor: ' + qryGen.FieldByName('ABA_CODFOR').AsString + '-' +
                                               qryGen.FieldByName('FOR_NOMFOR').AsString);
          dbeHistor.Lines.Add('Combustível: ' + qryGen.FieldByName('ABA_COMBUS').AsString);
        End;
    End
    Else
    Begin
      fMensagem('ATENÇÃO!','Autorização não cadastrada!',['&O k']);
      blnEncontrado := False;
      Exit;
    End;

  Except
    On E: Exception Do
      pMensagensErro(E.Message,'');
  End;

  FreeAndNil(qryGen);
End;

Procedure TfrmManutKmRodado.pHabDadosPedagioApenas( blnhab : boolean );
Begin

   If blnhab Then
   Begin

      lbl1.visible := False;
      edtKmRoda.visible := False;

      Label5.visible    := False;
      dbeAbaVlr.visible := False;

      Label6.visible    := False;
      dbeAbaLit.visible := False;

      Label11.visible   := False;
      dbeManVlr.visible := False;

      lblConsKM.visible := False;
      edtConVlr.visible := False;

      lblConsLt.visible := False;
      edtConLit.visible := False;

      lbl2.visible      := False;
      edtKm_Lit.visible := False;

      lbl3.visible      := False;
      edtValor_Lit.visible := False;

      pnlDadosPedagio.visible := True;

      pnlDadosPedagio.left := 0;
      pnlDadosPedagio.Top  := 185;

   End
   Else
   Begin

      lbl1.visible      := True;
      edtKmRoda.visible := True;

      Label5.visible    := true;
      dbeAbaVlr.visible := true;

      Label6.visible    := true;
      dbeAbaLit.visible := true;

      Label11.visible   := true;
      dbeManVlr.visible := true;

      lblConsKM.visible := true;
      edtConVlr.visible := true;

      lblConsLt.visible := true;
      edtConLit.visible := true;

      lbl2.visible      := true;
      edtKm_Lit.visible := true;

      lbl3.visible         := True;
      edtValor_Lit.visible := True;

      pnlDadosPedagio.visible := False;

      pnlDadosPedagio.left := 526;
      pnlDadosPedagio.Top  := 147;

   End;

End;

end.
