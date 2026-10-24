unit untDigPeriodo;

interface

uses
  SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms, 
  Dialogs, StdCtrls, untPaiSimples, Menus, ComCtrls, Buttons, Uni,
  ExtCtrls, Mask, MaskEditFocus, AppEvnts, EditFocus, StrUtils,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  dxCore, cxDateUtils, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar,
  untConsultas, untTypesSistema, untPesqAux, cxCheckBox, untFechamentoFinanceiro,
  untTLock;

type
  TfrmDigPeriodo = class(TfrmPaiSimples)
    Label1: TLabel;
    mskDtaIni: TMaskEditFocus;
    Label2: TLabel;
    mskDtaFin: TMaskEditFocus;
    pnlConfirma: TPanel;
    pnlFundo: TPanel;
    btnConfirmaDados: TBitBtnLocked;
    btnCancelaDados: TBitBtnLocked;
    pnlFundoConcil: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    mskDtaFinConcil: TcxDateEdit;
    mskDtaIniConcil: TcxDateEdit;
    edtCodEmp: TEditFocus;
    edtDesEmp: TEditFocus;
    edtPonVen: TEditFocus;
    edtDesPon: TEditFocus;
    lblPeriodoConciliacao: TLabel;
    chkDataImportacao: TcxCheckBox;
    lblIDConciliacao: TLabel;
    edtIDConciliacao: TEditFocus;
    btnAjuda: TBitBtnLocked;
    procedure btnCancelaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtPonVenKeyPress(Sender: TObject; var Key: Char);
    procedure PesquisaArquivosKeyPress(Sender: TObject; var Key: Char);
    procedure chkDataImportacaoClick(Sender: TObject);
    procedure btnAjudaClick(Sender: TObject);
  private
    { Private declarations }
    objFechamento: TFechamentoFinanceiro;
    FTravaPorEstabelecimento: Boolean;
    FobjLockEstabelecimento: TLock;

    strPesquisaEmpresa: String;
    function ExibeFiltroPorEmpresa:Boolean;
    function RetornaSQLEmpresas:String;
    function RetornaSQLSelecionaEmpresas:String;
    function TravarPorEstabelecimento(AEstabelecimento:String):Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    blnConfirma: Boolean;
    blnDtaCurta: Boolean;
    blnConcil  : Boolean;
    objConcil  : TCamposConcil;
    arrPonVen  : TConsultasArray;
    arrCodigoConciliacao  : TConsultasArray;
    arrEmpresa : TConsultasArray;
    strEmpresas: String;
    strPonVen  : String;
    property objLockEstabelecimento : TLock read FobjLockEstabelecimento Write FobjLockEstabelecimento;
  end;


implementation

uses  untfuncoesSimples, untDllLayoutsFR3Funcoes;

{$R *.dfm}

procedure TfrmDigPeriodo.btnAjudaClick(Sender: TObject);
begin
  inherited;
  pExibirAjudaRegistroCSGetnet;
end;

procedure TfrmDigPeriodo.btnCancelaClick(Sender: TObject);
begin
  inherited;
  Close;
end;

function TfrmDigPeriodo.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    LContador: Integer;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Not blnConcil) Then
    Begin
      If (Sender = mskDtaIni) Then
      Begin

        If (fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Data inicial deve ser preenchida!', ['&O k']);
          Result := False;
        End;

      End
      Else If (Sender = mskDtaFin) Then
      Begin

        If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Data final deve ser preenchida!', ['&O k']);
          Result := False;
        End
        Else If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) And
                (    fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then
        Begin
          fMensagem('ATENÇÃO!', 'Caso informe um período digite primeiramente a data inicial!', ['&O k']);
          Result := False;
        End
        Else If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) And
                (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then
        Begin
          If Not blnDtaCurta Then
          Begin
            If (Not fValidaPeriodo(mskDtaIni.Text, mskDtaFin.Text)) Then
            Begin
              fMensagem('ATENÇÃO!', 'A data final deve ser maior ou igual a data inicial!', ['&O k']);
              Result := False;
            End;
          End;
        End;

      End;
    End
    Else
    Begin
      If (Sender = mskDtaIniConcil) Then
      Begin

        If (fEmptyStr(fTiraCaracEspeciais(mskDtaIniConcil.Text))) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Data inicial deve ser preenchida!', ['&O k']);
          Result := False;
        End;

      End
      Else If (Sender = mskDtaFinConcil) Then
      Begin

        If fEmptyStr(fTiraCaracEspeciais(mskDtaFinConcil.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Data final deve ser preenchida!', ['&O k']);
          Result := False;
        End
        Else If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFinConcil.Text))) And
                (    fEmptyStr(fTiraCaracEspeciais(mskDtaIniConcil.Text))) Then
        Begin
          fMensagem('ATENÇÃO!', 'Caso informe um período digite primeiramente a data inicial!', ['&O k']);
          Result := False;
        End
        Else If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFinConcil.Text))) And
                (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIniConcil.Text))) Then
        Begin
          If (Not fValidaPeriodo(mskDtaIniConcil.Text, mskDtaFinConcil.Text)) Then
          Begin
            fMensagem('ATENÇÃO!', 'A data final deve ser maior ou igual a data inicial!', ['&O k']);
            Result := False;
          End;
        End;

      End

      Else If (Sender = edtCodEmp) And (Not fEmptyStr(objConcil.strConfEs)) Then
      Begin

        If Not fEmptyStr(edtCodEmp.Text) Then
        Begin
          If Not SameText(edtCodEmp.Text, '000') Then
          Begin
            pPesquisaCadEmp(Nil, qryTabela, edtCodEmp.Text);
            edtDesEmp.Text := qryTabela.FieldByName('EMP_NOMEMP').AsString;

            If Pos(edtCodEmp.Text, strEmpresas) <= 0 Then
            Begin

              If MatchStr(objConcil.strTabCon, ['MER_MLPGTO','SHO_SHPGTO']) Then
                fMensagem('', 'Empresa sem arquivo(s) vinculado(s)!', ['&Ok'])
              Else
                fMensagem('', 'Empresa sem ponto de venda vinculada!', ['&Ok']);

              Result := False;
            End;

            SetLength(arrEmpresa, 0);

            If Result Then
            Begin
              SetLength(arrEmpresa, 1);
              arrEmpresa[0].strCodigo := edtCodEmp.Text;
            End
          End;
        End
        Else If fEmptyStr(edtCodEmp.Text) Then
          edtDesEmp.Text := 'TODAS';

      End

      Else If (Sender = edtPonVen) And (Not fEmptyStr(objConcil.strConfEs)) Then
      Begin

        If ((Not fEmptyStr(edtPonVen.Text)) And (High(arrPonVen) < 0)) Then
        Begin
          edtDesPon.Text := edtPonVen.Text;

          If Pos(edtPonVen.Text, strPonVen) <= 0 Then
          Begin
            fMensagem('', 'Esse Ponto de Venda não foi importado pela ' + objConcil.strNomCon + '!', ['&Ok']);
            Result := False;
          End;

          If Result Then
          Begin
            SetLength(arrPonVen, 1);
            arrPonVen[0].strCodigo := edtPonVen.Text;
          End;
        End
        Else If fEmptyStr(edtPonVen.Text) Then
          edtDesPon.Text := 'TODOS';

        If Result Then
        Begin
          FobjLockEstabelecimento.pDestravarTodos;

          If  ((Not fEmptyStr(edtPonVen.Text)) And (High(arrPonVen) >= 0)) Then
          Begin
            For LContador := 0 To High(arrPonVen) Do
            Begin
              Result := TravarPorEstabelecimento(arrPonVen[LContador].strCodigo);

              If Not Result Then
                Exit;
            End;
          End
          Else
            Result := TravarPorEstabelecimento(edtPonVen.Text);
        End;

      End;
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmDigPeriodo.PesquisaArquivosKeyPress(Sender: TObject;
  var Key: Char);
begin
  If fPesqArquivosYapay(Self, edtIDConciliacao , Nil, Nil, Key, arrCodigoConciliacao, objConcil, False) Then
  Begin
    If fValidaCampos(edtPonVen) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmDigPeriodo.RetornaSQLEmpresas: String;
begin

  If MatchStr(objConcil.strTabCon, ['MER_MLPGTO','SHO_SHPGTO']) Then
  Begin
    Result := 'EMP_CODEMP IN (SELECT                 '+
                             '  DISTINCT CAR_CODEST  '+
                             'FROM                   '+
                             '  ESTCAR WHERE CAR_NOMOPE = '+ objConcil.strNomCon.QuotedString + ')';
    Exit;
  End;

  Result := 'EMP_CODEMP IN (SELECT DISTINCT SIS_CODEMP FROM CFGSIS WHERE SIS_CODCFG ';

  If objConcil.strConfEs = 'CFG_CIEEST' Then
    Result := Result + ' IN ("CFG_CIEEST", "CFG_CIELNK") '
  Else If (objConcil.strConfEs = 'CFG_REDEST') Then
    Result := Result + ' IN ("CFG_REDEST", "CFG_REDECO") '
  Else If objConcil.strConfEs = 'CFG_STOEST' Then
    Result := Result + ' IN ("CFG_STOEST", "CFG_STOLNK") '
  Else If objConcil.strConfEs = 'CFG_GETEST' Then
    Result := Result + ' IN ("CFG_GETEST", "CFG_GETECO") '
  Else If objConcil.strConfEs = 'CFG_PAGEST' Then
    Result := Result + ' IN ("CFG_PAGEST", "CFG_PAGLNK") '
  Else
   Result := Result + '="' + objConcil.strConfEs +'" ';

  Result := Result + ' AND SIS_VALCFG <> "" AND SIS_VALCFG IS NOT NULL )';
end;

function TfrmDigPeriodo.RetornaSQLSelecionaEmpresas: String;
begin

  If MatchStr(objConcil.strTabCon, ['MER_MLPGTO','SHO_SHPGTO']) Then
  Begin
    Result := ' SELECT                             '+
              '  DISTINCT CAR_CODEST AS SIS_CODEMP '+
              'FROM                                '+
              '  ESTCAR WHERE CAR_NOMOPE = '+ objConcil.strNomCon.QuotedString ;
    Exit;
  End;

  Result := 'SELECT DISTINCT SIS_CODEMP FROM CFGSIS ';

  If objConcil.strConfEs = 'CFG_CIEEST' Then
    Result := Result + ' WHERE SIS_CODCFG IN ("CFG_CIEEST", "CFG_CIELNK") AND '
  Else If objConcil.strConfEs = 'CFG_REDEST' Then
    Result := Result + ' WHERE SIS_CODCFG IN ("CFG_REDEST", "CFG_REDECO") AND '
  Else If objConcil.strConfEs = 'CFG_PAGEST' Then
    Result := Result + ' WHERE SIS_CODCFG IN ("CFG_PAGEST", "CFG_PAGLNK") AND '
  Else If objConcil.strConfEs = 'CFG_STOEST' Then
    Result := Result + ' WHERE SIS_CODCFG IN ("CFG_STOEST", "CFG_STOLNK") AND '
  Else If objConcil.strConfEs = 'CFG_GETEST' Then
    Result := Result + ' WHERE SIS_CODCFG IN ("CFG_GETEST", "CFG_GETECO") AND '
  Else If objConcil.strConfEs = 'CFG_PGMKEY' Then
    Result := Result + ' WHERE SIS_CODCFG IN ("CFG_PGMKEY") AND '
  Else
    Result := Result + ' WHERE SIS_CODCFG="' + objConcil.strConfEs + '" AND ';

  Result := Result + ' SIS_VALCFG <> "" AND SIS_VALCFG IS NOT NULL ';
end;

function TfrmDigPeriodo.TravarPorEstabelecimento(AEstabelecimento:String): Boolean;
  Var
    LConciliadora: String;
    LChaveLckatc: String;
    LChaveCompleta: String;
begin
  Result := True;

  If Not FTravaPorEstabelecimento Then
    Exit;

  LConciliadora := StringReplace(objConcil.strNomCon, ' ', '_', [rfReplaceAll]);

  If fEmptyStr(AEstabelecimento) Then
  Begin

    LChaveLckatc := 'CONCILIACAO_BAIXA_CARTOES_' + LConciliadora + '_';
    If fVerificaLCKATCNomeParcialRetornaChave(LChaveLckatc,LChaveCompleta) Then
    Begin
      fMensagem('ATENÇÃO','Não será permitido selecionar todos os estabelecimentos da operadora '
                           + LConciliadora + ', pois alguns já estão sendo ' +
                           'conciliados/baixados por outra estação: ' +
                           fGetHostLock(LChaveCompleta), ['&OK'], 1);
      Exit(False);
    End;

    LChaveLckatc := 'CONCILIACAO_BAIXA_CARTOES_' + LConciliadora + '_TODOS';
    If Not FobjLockEstabelecimento.fLock_Unlock(LChaveLckatc, True, False) Then
    Begin
      fMensagem('ATENÇÃO', 'Todos os estabelecimentos da operadora ' + LConciliadora + ' já estão sendo ' +
                           'conciliados/baixados por outra estação: ' +
                           fGetHostLock(LChaveLckatc), ['&OK'], 1);
      Exit(False);
    End;


    Exit;
  End;

  LChaveLckatc := 'CONCILIACAO_BAIXA_CARTOES_' + LConciliadora + '_TODOS';
  If fVerificaLCKATCNomeParcial(LChaveLckatc) Then
  Begin
    fMensagem('ATENÇÃO', 'Todos os estabelecimentos da operadora ' + LConciliadora + ' já estão sendo ' +
                         'conciliados/baixados por outra estação: ' +
                         fGetHostLock(LChaveLckatc), ['&OK'], 1);
    Exit(False);
  End;

  LChaveLckatc := 'CONCILIACAO_BAIXA_CARTOES_' + LConciliadora + '_' + AEstabelecimento;
  If Not FobjLockEstabelecimento.fLock_Unlock(LChaveLckatc, True, False) Then
  Begin
    fMensagem('ATENÇÃO', 'O estabelecimento '+AEstabelecimento+' da operadora ' + LConciliadora + ' já está sendo ' +
                         'conciliado/baixado por outra estação: ' +
                         fGetHostLock(LChaveLckatc), ['&OK'], 1);
    Exit(False);
  End;

end;

procedure TfrmDigPeriodo.FormCreate(Sender: TObject);
begin
  inherited;
  blnConfirma := False;
  blnDtaCurta := False;
  blnConcil   := False;

  Height := 146;
  Width  := 328;
  btnCancelaDados.Left := 240;
  FobjLockEstabelecimento := TLock.Create;
end;

procedure TfrmDigPeriodo.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;

  //FECHAMENTO FINANCEIRO
  if edtCodEmp.Visible then
    if objFechamento.FechamentoFinanceiroJaRealizado(IIF(not fEmptyStr(edtCodEmp.Text), edtCodEmp.Text, VS_strCodEmp), StrToDate(mskDtaIniConcil.Text)) then
     Exit;

  If fVerificaCampos Then
  Begin
    blnConfirma := True;
    Close;
  End;
end;

procedure TfrmDigPeriodo.chkDataImportacaoClick(Sender: TObject);
begin
  inherited;
  If chkDataImportacao.Checked Then
    lblPeriodoConciliacao.Caption := 'Digite o período da finalização a ser conciliado'
  Else
    lblPeriodoConciliacao.Caption := 'Digite o período do pagamento a ser conciliado';
end;

procedure TfrmDigPeriodo.edtCodEmpKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  {********************************************}
  {* CONSULTA DE EMPRESAS COM PONTO DE VENDAS *}
  {*****************************************AJ*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtDesEmp, Nil, Key, arrEmpresa, False, False, '', False, '',
     strPesquisaEmpresa) Then
  Begin
    If fValidaCampos(edtCodEmp) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmDigPeriodo.edtPonVenKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  {*******************************}
  {* CONSULTA DE PONTOS DE VENDA *}
  {****************************AJ*}
  If fPesqEstConcil(Self, edtPonVen, edtDesPon, Nil, Key, arrPonVen, objConcil, False) Then
  Begin
    If fValidaCampos(edtPonVen) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmDigPeriodo.ExibeFiltroPorEmpresa: Boolean;
begin
  Result := True;

  If fEmptyStr(strEmpresas) Then
    Exit(False);

  If MatchStr(objConcil.strTabCon, ['KON_KOPGTO','YAP_YAPGTO']) Then
    Exit(False);

  If MatchStr(objConcil.strTabCon, ['MER_MLPGTO']) Then
  Begin
    If Not fCfgSis('MEREMP',varBoolean) Then
      Exit(False);
  End;

  If MatchStr(objConcil.strTabCon, ['SHO_SHPGTO']) Then
  Begin
    If Not fCfgSis('SHOEMP',varBoolean) Then
      Exit(False);
  End;

end;

procedure TfrmDigPeriodo.FormShow(Sender: TObject);
Var
  qryEmpPV: TUniQuery;
  strSQL  : String;
begin
  inherited;
  FTravaPorEstabelecimento :=  MatchStr(AnsiUpperCase(objConcil.strNomCon), ['GETNET']);

  If Not blnConcil Then
  Begin
    pnlFundo.Visible := True;
    pnlFundoConcil.Visible := False;
    If blnDtaCurta Then
    Begin
      Self.Caption   := Self.Caption + ' - (dd/mm)';

      mskDtaIni.Text := LeftStr(DateToStr(VS_Date),5);
      mskDtaFin.Text := LeftStr(DateToStr(VS_Date),5);
    End
    Else
    Begin
      mskDtaIni.Text := DateToStr(VS_Date);
      mskDtaFin.Text := DateToStr(VS_Date);
    End;
  End
  Else
  Begin
    pnlFundo.Visible := False;
    pnlFundoConcil.Visible := True;
    pSetFocus(mskDtaIniConcil);
    mskDtaIniConcil.Date := VS_Date;
    mskDtaFinConcil.Date := VS_Date;

    If Not fEmptyStr(objConcil.strConfEs) Then
    Begin
      Height := 175;
      Width  := 376;
      btnCancelaDados.Left := 286;

      btnAjuda.Visible := MatchStr(objConcil.strTabCon, ['GET_GEPGTO']);

      qryEmpPV := fCriaQuery;

      Try
        //Selecionando pontos de venda
        strSQL := 'SELECT CAR_CODEST FROM ' +
                  ' ESTCAR WHERE CAR_NOMOPE="' + objConcil.strNomCon + '"';

        qryEmpPV.SQL.Text := strSQL;
        qryEmpPV.Open;

        strPonVen := '';
        While Not qryEmpPV.Eof Do
        Begin
          strPonVen := strPonVen + qryEmpPV.FieldByName('CAR_CODEST').AsString + '_';
          qryEmpPV.Next;
        End;

        //Selecionando empresas
        qryEmpPV.Close;
        qryEmpPV.SQL.Text := RetornaSQLSelecionaEmpresas;
        qryEmpPV.Open;

        strEmpresas := '';
        While Not qryEmpPV.Eof Do
        Begin
          strEmpresas := strEmpresas + qryEmpPV.FieldByName('SIS_CODEMP').AsString + '_';
          qryEmpPV.Next;
        End;
      Finally
        qryEmpPV.Close;

        FreeAndNil(qryEmpPV);
      End;

      chkDataImportacao.Visible := objConcil.strTabCon = 'KON_KOPGTO';
      lblIDConciliacao.Visible  := MatchStr(objConcil.strTabCon, ['KON_KOPGTO','YAP_YAPGTO']);
      edtIDConciliacao.Visible  := MatchStr(objConcil.strTabCon, ['KON_KOPGTO','YAP_YAPGTO']);

      Label6.Visible    := Not Matchstr(objConcil.strTabCon, ['KON_KOPGTO', 'MER_MLPGTO','YAP_YAPGTO','SHO_SHPGTO','PGM_PMPGTO','PGM_PMRECE']);
      edtPonVen.Visible := Not Matchstr(objConcil.strTabCon, ['KON_KOPGTO', 'MER_MLPGTO','YAP_YAPGTO','SHO_SHPGTO','PGM_PMPGTO','PGM_PMRECE']);
      edtDesPon.Visible := Not Matchstr(objConcil.strTabCon, ['KON_KOPGTO', 'MER_MLPGTO','YAP_YAPGTO','SHO_SHPGTO','PGM_PMPGTO','PGM_PMRECE']);

      Label5.Visible    := ExibeFiltroPorEmpresa;
      edtCodEmp.Visible := ExibeFiltroPorEmpresa;
      edtDesEmp.Visible := ExibeFiltroPorEmpresa;

      If MatchStr(objConcil.strTabCon, ['YAP_YAPGTO']) Then
      Begin
        lblIDConciliacao.Left := 4;
        lblIDConciliacao.Top  := 51;

        Label4.Left := 33;

        edtIDConciliacao.Left  := 87;
        edtIDConciliacao.Top   := 48;
        edtIDConciliacao.OnKeyPress := PesquisaArquivosKeyPress;

        Self.Height := 148;
      End;

      Caption   := Caption + ' (' + objConcil.strNomCon + ')';
      qryTabela := fCriaQuery;

      strPesquisaEmpresa := RetornaSQLEmpresas;
    End
    Else
    Begin
      mskDtaIniConcil.Top  := edtCodEmp.Top - 20;
      mskDtaIniConcil.Left := 67;
      mskDtaFinConcil.Top  := edtCodEmp.Top - 20;
      mskDtaFinConcil.Left := 219;
      Label4.Top           := Label5.Top - 20;
      Label4.Left          := 9;
      Label3.Top           := Label5.Top - 20;
      Label3.Left          := 163;
    End;
  End;
end;

End.

