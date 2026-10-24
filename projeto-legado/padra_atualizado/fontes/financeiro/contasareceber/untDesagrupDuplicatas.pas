unit untDesagrupDuplicatas;

interface

uses
  SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, ComCtrls, Buttons, ExtCtrls,
  EditFocus, Mask, MaskEditFocus, Menus, AppEvnts, Uni, BitBtnLockedIncrem,
  frxClass, frxExportCSVTestabilidade,
  untTBanCtrRepository, untMovBan;

type
  TfrmDesagrupDuplicatas = class(TfrmPaiSimples)
    Label1: TLabel;
    edtNumAgr: TEditFocus;
    pnlFundo: TPanel;
    edtNomCli: TEditFocus;
    edtCodCli: TEditFocus;
    Label2: TLabel;
    edtCodEmp: TEditFocus;
    edtDesEmpresa: TEditFocus;
    btnConfirmaDes: TBitBtnLocked;
    btnSairDes: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmaDesClick(Sender: TObject);
    procedure btnSairDesClick(Sender: TObject);
    procedure edtNumAgrExit(Sender: TObject);
  private
    { Private declarations }
    qryDesDup: TUniQuery;
    qryConCli: TUniQuery;
    blnBolImp: Boolean;

    procedure pCarregaCliente;
    function fVerificaRegistroAntecipacaoRecebiveis(strNumAgr, strCodCli, strCodEmp: String): Boolean;
    function fVerificacoesDesagrupAntecRecebiveis(strNumAgr, strCodCli, strCodEmp: String): Boolean;
    function fExcluiRelacionadosAntecRecebiveis(strNumAgr, strCodCli, strCodEmp: String): Boolean;
    function fExcluiCartoesChequesAntecRecebiveis(strNumAgr, strCodCli, strCodEmp: String): Boolean;
    function fExcluiCreditosAntecRecebiveis(strNumAgr, strCodCli, strCodEmp: String): Boolean;
    function fLancaMovBancariaAntecRecebiveis(strNumAgr, strCodCli, strCodEmp: String): Boolean;
    function fVerificaTemCartoesBaixadosAntecipacao(strNumAgr, strCodCli,
      strCodEmp: String): Boolean;
    function fVerificaTemChequesBaixadosAntecipacao(strNumAgr, strCodCli,
      strCodEmp: String): Boolean;

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    function fDesagrupaDuplicatas(const strNumAgr, strCodCli,
      strEmpAgr: String; const blnAtivarTransacao: Boolean=True): Boolean;
  end;


implementation

uses untfuncoesSimples, DB, untCadRec, untPesqAux, untConsultas, untTypesSistema,
     untAtualizaOcorrenciasCRM, untTypesCRM, untPgtOnlineApi;

{$R *.dfm}

{ TfrmDesagrupDuplicatas }

function TfrmDesagrupDuplicatas.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtNumAgr) Then
    Begin

      If (fEmptyStr(edtNumAgr.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Número do Agrupamento deve ser preenchido!', ['&O k']);
        Result := False;
      End;
    End

    Else If (Sender = edtCodCli) Then
    Begin
      If Not fEmptyStr(edtCodCli.Text) Then
      Begin
        pCarregaCliente;
        If qryConCli.FieldByName('CLI_CODCLI').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Cliente não está cadastrado!', ['&O k']);
          Result := False;
          pSetFocus(edtCodCli);
        End;

      End
      Else
      Begin
        fMensagem('ATENÇÃO!', 'O código do cliente deve ser preenchido!', ['&O k']);
        Result := False;
      End;
    End;

  End;


end;

procedure TfrmDesagrupDuplicatas.pCarregaCliente;
begin
  pPesquisaCadCli(qryConCli, qryConCli, edtCodCli.Text);
  With qryConCli Do
  Begin
    edtNomCli.Text := FieldbyName('CLI_NOMCLI').AsString;
  End;
end;

procedure TfrmDesagrupDuplicatas.btnConfirmaDesClick(Sender: TObject);
Var
  strChvLoc: String;
  sltDoctos: TStringList;
  intIndex: Integer;
  blnConfirma: Boolean;

begin
  inherited;

  {****** VALIDA CAMPOS DESAGRUPAMENTO *******;;;}

  if fEmptyStr(edtNumAgr.Text) Then
  Begin
    fMensagem('ATENÇÃO', 'Informe número de agrupamento/cliente para realizar o desagrupamento', ['&O k']);
    blnConfirma:= False;
  End
  Else if fEmptyStr(edtCodCli.Text) Then
  Begin
    fMensagem('ATENÇÃO', 'Informe número de agrupamento/cliente para realizar o desagrupamento', ['&O k']);
    blnConfirma:= False;
  End
  Else If (fVerificaNumAgr(edtNumAgr.Text, edtCodCli.Text)) and
          (fPermitiDesagruparDuplicata(edtNumAgr.Text, edtCodCli.Text)) Then
  Begin

      blnConfirma := True;

      If (fCfgSis('CTRARC') = 'S') Then
      Begin
        If fVerificaRegistroAntecipacaoRecebiveis(edtNumAgr.Text, edtCodCli.Text, edtCodEmp.Text) Then
        Begin
          blnConfirma := fVerificacoesDesagrupAntecRecebiveis(edtNumAgr.Text, edtCodCli.Text, edtCodEmp.Text);

          {****************************************}
          {VERIFICA SE TEM CARTOES OU CHEQUES      }
          {JA DEPOSITADOS ANTES DE FAZER A EXCLUSÃO}
          {****************************************}
          If blnConfirma Then
          Begin
            blnConfirma := Not fVerificaTemCartoesBaixadosAntecipacao(edtNumAgr.Text, edtCodCli.Text, edtCodEmp.Text);

            If blnConfirma Then
              blnConfirma := Not fVerificaTemChequesBaixadosAntecipacao(edtNumAgr.Text, edtCodCli.Text, edtCodEmp.Text);
          End;

          If blnConfirma Then
            fMensagem('ATENÇÃO', 'Os lançamentos de crédito, cheques e cartões que forem '+ #13#10 +
                                 'relacionados ao agrupamento nº: ' + edtNumAgr.Text + ' serão excluídos !', ['&O k']);
        End;
      End;

      if TValidacoesPagamentoOnline.fAgrupamentoPossuiLinkPagamento(edtNumAgr.Text, 'AG', edtCodEmp.Text, edtCodCli.Text) then
      begin
        pMensagemOk('Não será possível desagrupar esta duplicata pois existe link de pagamento ');
        blnConfirma := False ;
      end ;

      If blnConfirma Then
      Begin

        If fMensagem('', 'Confirma desagrupamento da(s) duplicata(s)?', ['&Sim', '&Não']) = 1 Then
        Begin

          blnConfirma := True;
          sltDoctos := fRetDoctosCadRecAgr(edtNumAgr.Text, edtCodCli.Text);
            If Assigned(sltDoctos) And (sltDoctos.Count > 0) Then
            Begin
              For intIndex := 0 To sltDoctos.Count-1 Do
              Begin
                strChvLoc := 'CADREC' + Copy(sltDoctos[intIndex], 1, Length(sltDoctos[intIndex]) - 2);
                  If Not fEmptyStr(fGetHostLock(strChvLoc)) Then
                  Begin
                    fMensagem('ATENÇÃO!', 'Este documento está sendo utilizado por outra estação: ' + fGetHostLock(strChvLoc), ['&Ok']);
                    blnConfirma:=False;
                    Break;
                  End
                  Else If Not fLock_Unlock('CADREC' + sltDoctos[intIndex], True, False) Then
                  Begin
                    fMensagem('ATENÇÃO!', 'Esta duplicata está sendo utilizada por outra estação: ' + fGetHostLock('CADREC' + sltDoctos[intIndex]), ['&Ok']);
                    blnConfirma:=False;
                    Break;
                  End;
              End;
            End;

            If blnConfirma Then
            Begin
              If fDesagrupaDuplicatas(edtNumAgr.Text, edtCodCli.Text, edtCodEmp.Text) Then
              Begin
                fMensagem('ATENÇÃO!', 'Duplicata(s) desagrupada(s) com sucesso!', ['&O k']);
                edtNumAgr.Clear;
                edtCodCli.Clear;
                edtNomCli.Clear;
              End
              Else If Not blnBolImp Then
              Begin
                fMensagem('ATENÇÃO!', 'A Duplicata não foi desagrupada. Verifique se ela existe ou se foi enviada para o banco!', ['&O k']);
                edtNumAgr.Clear;
                edtCodCli.Clear;
                edtNomCli.Clear;
              End;
            End;

            If Assigned(sltDoctos) And (sltDoctos.Count > 0) Then
            Begin
              For intIndex := 0 To sltDoctos.Count-1 Do
              Begin
                strChvLoc := 'CADREC' + sltDoctos[intIndex];
                fLock_Unlock(strChvLoc, False);
              End;
            End;

        End;

      End;

      blnConfirma := False;

  End
  Else
  Begin
    edtNumAgr.Clear;
    edtCodCli.Clear;
    edtNomCli.Clear;
    blnConfirma := False;
  End;

  If Not blnConfirma Then
  Begin
    pSetFocus(edtNumAgr);
  End;
End;


procedure TfrmDesagrupDuplicatas.btnSairDesClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmDesagrupDuplicatas.edtCodCliKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrClientes: TConsultasArray;
begin
  inherited;
  If fPesqCliente(conCliSimples, Self, edtCodCli, edtNomCli, Nil, Key, arrClientes) Then
  Begin
    If fValidaCampos(edtCodCli, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmDesagrupDuplicatas.edtNumAgrExit(Sender: TObject);
begin
  inherited;
  {****** FORMATAR TEXTO = 000000000000 ******;;;}
  If Not fEmptyStr(edtNumAgr.Text) Then
  begin
    edtNumAgr.Text := FormatFloat('000000000000',StrtoFloat(edtNumAgr.Text));
  end;
end;

function TfrmDesagrupDuplicatas.fDesagrupaDuplicatas(const strNumAgr, strCodCli,
  strEmpAgr: String; const blnAtivarTransacao: Boolean): Boolean;
  Var
    strSQL      : String;
    blnConfirma : Boolean;
    fltValCom   : Double;
    fltFatCom   : Double;
    qryApgCtr   : TUniQuery;
    fltFatRep   : Double;
    strCodCliDoc: String;
begin

  blnConfirma := True;
  qryApgCtr := fCriaQuery(Self);
  blnBolImp := False;

  Try
    {************************************}
    {* CARREGA DUPLICATA PARA POSTERIOR *}
    {* GRAVAÇÃO DO LOG                  *}
    {*********************************AF*}
    With qryApgCtr Do
    Begin
      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  C.* ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  CADREC C ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  C.CTR_DTAENV IS NULL   AND ';
      strSQL := strSQL + '  C.CTR_NUMDUP = :NUMAGR AND ';
      strSQL := strSQL + '  C.CTR_ESPDOC = "AG"    AND ';
      strSQL := strSQL + '  C.CTR_CODCLI = :CODCLI AND    ';
      strSQL := strSQL + '  EXISTS(SELECT D.CTR_NUMAGR FROM DUPAGR D WHERE ';
      strSQL := strSQL + '                D.CTR_NUMAGR = C.CTR_NUMDUP AND ';
      strSQL := strSQL + '                D.CTR_EMPAGR = C.CTR_CODEMP AND ';
      strSQL := strSQL + '                D.CTR_CODCLI = C.CTR_CODCLI AND ';
      strSQL := strSQL + '                D.CTR_EMPAGR = :EMPAGR)         ';

      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMAGR').AsString := strNumAgr;
      ParamByName('EMPAGR').AsString := strEmpAgr;
      ParamByName('CODCLI').AsString := strCodCli;

      Open;

      {***********************************}
      {* GUARDA O CLIENTE DO AGRUPAMENTO *}
      {********************************JB*}
      strCodCliDoc := FieldByName('CTR_CODCLI').asString;

      If IsEmpty Then
      Begin
        blnConfirma := False;
        Close;
      End
      Else
      If Not fEmptyStr(FieldByName('CTR_NOSNUM').AsString) Then
      Begin
        If fMensagem('', 'Este agrupamento (' + strNumAgr + '-AG) possui boleto(s) já impresso(s). Deseja prosseguir?', ['&Sim', '&Não']) = 2 Then
        Begin
          blnBolImp   := True;
          blnConfirma := False;
          Close;
        End;
      End;

    End;

    If blnConfirma Then
    Begin
      {*****************************************}
      {* INICIA A TRANSAÇÃO                    *}
      {**************************************MV*}
      If blnAtivarTransacao Then
        fStartTransaction;

      Application.ProcessMessages;

      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  R.*, ';

      strSQL := strSQL + ' (SELECT COUNT(*) FROM ';
      strSQL := strSQL + '      CADREC C ';
      strSQL := strSQL + '    WHERE C.CTR_NUMDUP = R.CTR_NUMDUP ';
      strSQL := strSQL + '      AND C.CTR_ESPDOC = R.CTR_ESPDOC ';
      strSQL := strSQL + '      AND C.CTR_PARCEL = R.CTR_PARCEL ';
      strSQL := strSQL + '      AND C.CTR_CODEMP = R.CTR_CODEMP ';
      strSQL := strSQL + '      AND C.CTR_CODCLI = R.CTR_CODCLI) AS CTR_BAIXAS, ';

      strSQL := strSQL + '    (SELECT IFNULL(CTR_FATCOM, 0) FROM ';
      strSQL := strSQL + '      CADREC C ';
      strSQL := strSQL + '    WHERE C.CTR_NUMDUP = R.CTR_NUMDUP ';
      strSQL := strSQL + '      AND C.CTR_ESPDOC = R.CTR_ESPDOC ';
      strSQL := strSQL + '      AND C.CTR_PARCEL = R.CTR_PARCEL ';
      strSQL := strSQL + '      AND C.CTR_CODEMP = R.CTR_CODEMP ';
      strSQL := strSQL + '      AND C.CTR_CODCLI = R.CTR_CODCLI ';
      strSQL := strSQL + '      AND C.CTR_SEQBAI = 1) AS CTR_FATCOM_SEQBAI_01 ';

      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  DUPAGR R ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  CTR_NUMAGR = :DUPAGR AND ';
      strSQL := strSQL + '  CTR_EMPAGR = :EMPAGR AND ';
      strSQL := strSQL + '  CTR_CODCLI = :CODCLI     ';

      With qryDesDup Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('DUPAGR').AsString := strNumAgr;
        ParamByName('EMPAGR').AsString := strEmpAgr;
        ParamByName('CODCLI').AsString := strCodCliDoc;
        Open;

        While Not Eof Do
        Begin

          fltValCom := FieldByName('CTR_VALCOM').AsFloat;
          fltFatCom := 0.00;

          {***************************************************************}
          { AO DESAGRUPAR PARCELAS DE DOCUMENTOS COM BAIXAS PARCIAIS      }
          { NÃO DEVO CALCULAR CTR_VALCOM POIS ESSE VALOR ESTARÁ NO        }
          { CADREC CORRESPONDENTE CUJO CTR_SEQBAI É 1, MAS DEVO RETORNAR  }
          { O FATOR ORIGINAL POIS O MESMO É USADO NOS RELATÓRIOS DE COMIS-}
          { -SÃO PELO CONTAS A RECEBER                                    }
          {************************************************************VA*}
          If (FieldByName('CTR_BAIXAS').AsInteger > 0) Then
          begin
            fltValCom := 0.00;
            fltFatCom := FieldByName('CTR_FATCOM_SEQBAI_01').AsFloat;
          End
          Else
          Begin
            If (Not SameText(FieldByName('CTR_VALDUP').AsString, '0')) Then
              fltFatCom := (fltValCom / FieldByName('CTR_VALDUP').AsFloat);
          End;

          If FieldByName('CTR_VALDUP').AsFloat <> 0 Then
            fltFatRep := FieldByName('CTR_COMREP').AsFloat / FieldByName('CTR_VALDUP').AsFloat
          Else
            fltFatRep := 0;

          blnConfirma := fGravaCadRec(Self.Name,
                                      'INCLUSÃO',
                                      FieldByName('CTR_NUMDUP').AsString,
                                      FieldByName('CTR_PARCEL').AsString,
                                      FieldByName('CTR_SEQBAI').AsInteger,
                                      FieldByName('CTR_ESPDOC').AsString,
                                      FieldByName('CTR_CODCLI').AsString,
                                      FieldByName('CTR_CODEMP').AsString,
                                      FieldByName('CTR_CODVEN').AsString,
                                      FieldByName('CTR_CODDIG').AsString,
                                      FieldByName('CTR_CODPOR').AsString,
                                      FieldByName('CTR_DTACAD').AsDateTime,
                                      FieldByName('CTR_DTAVEN').AsDateTime,
                                      FieldByName('CTR_VALDUP').AsFloat, //+ FieldByName('CTR_VALDES').AsFloat - FieldByName('CTR_VALJUR').AsFloat - FieldByName('CTR_VALCOB').AsFloat - FieldByName('CTR_JURSUJ').AsFloat + FieldByName('CTR_DESSUJ').AsFloat - FieldByName('CTR_DESCOB').AsFloat,
                                      FieldByName('CTR_VALORI').AsFloat, //+ FieldByName('CTR_VALDES').AsFloat - FieldByName('CTR_VALJUR').AsFloat - FieldByName('CTR_VALCOB').AsFloat,
                                      FieldByName('CTR_DESCOB').AsFloat,
                                      FieldByName('CTR_DESCON').AsString,
                                      FieldByName('CTR_HIST01').AsString,
                                      FieldByName('CTR_HIST02').AsString,
                                      '',
                                      '',
                                      '',
                                      '',
                                      0.0,
                                      0,
                                      FieldByName('CTR_ADTCLI').AsString,
                                      FieldByName('CTR_CODEVE').AsString,
                                      FieldByName('CTR_CODVEL').AsString,
                                      FieldByName('CTR_TIPFOR').AsString,
                                      FieldByName('CTR_CODCND').AsString,
                                      IIF(FieldByName('CTR_CONAPR').AsInteger = 1, True, False),
                                      FieldByName('CTR_CODCTA').AsString,
                                      FieldByName('CTR_SEQCON').AsInteger,
                                      FieldByName('CTR_GRVORI').AsFloat,
                                      '',
                                      '',
                                      '',
                                      FieldByName('CTR_CTASER').AsString,
                                      IIF(FieldByName('CTR_SERVAL').IsNull, 0, FieldByName('CTR_SERVAL').AsFloat),
                                      0,                                                                    // intResCai
                                      fltValCom, // fltVlrCom,
                                      fltFatCom, // fltFatCom
                                      '', //strEmpBai
                                      FieldByName('CTR_EMP_PD').AsString, // Empresa de Origem
                                      FieldByName('CTR_DOCDIV').AsString, //strDocDiv
                                      FieldByName('CTR_ESPDIV').AsString, //strEspDiv
                                      FieldByName('CTR_EMPDIV').AsString, //strEmpDiv
                                      FieldByName('CTR_CLIDIV').AsString, //strCliDiv
                                      FieldByName('CTR_COMREP').AsFloat,
                                      fltFatRep,
                                      FieldByName('CTR_CODREP').AsString,
                                      FieldByName('CTR_VALIPI').AsFloat,
                                      FieldByName('CTR_VALRET').AsFloat,
                                      'N', //strOriF11
                                      FieldByName('CTR_DESSUJ').AsFloat,
                                      FieldByName('CTR_JURSUJ').AsFloat,
                                      0,
                                      0,
                                      0,
                                      0,
                                      0,
                                      0,
                                      FieldByName('CTR_BARCON').AsString,
                                      FieldByName('CTR_PERDPO').AsFloat,
                                      FieldByName('CTR_QTDDAV').AsInteger,
                                      0,
                                      '',
                                      FieldByName('CTR_VALACE').AsFloat,
                                      FieldByName('CTR_VALFRE').AsFloat,
                                      FieldByName('CTR_DIFORI').AsFloat,
                                      0,
                                      FieldByName('CTR_COMDIV').AsFloat,
                                      FieldByName('CTR_FATDIV').AsFloat,
                                      FieldByName('CTR_CODDIV').AsString,
                                      FieldByName('CTR_VALFCP').AsFloat,
                                      'ESTORNO',
                                      '',
                                      '',
                                      FieldByName('CTR_INCDOC').AsString,
                                      'N',
                                      'N',
                                      '',
                                      '',
                                      FieldByName('CTR_SEQMPX').AsString,
                                      '',
                                      0,
                                      0,
                                      '',
                                      FieldByName('CTR_VALCBS').AsFloat,
                                      FieldByName('CTR_VALIBS').AsFloat,
                                      FieldByName('CTR_VAL_IS').AsFloat);
          If blnConfirma Then
          Begin
            blnConfirma := fDeletaDel_CadRec(FieldByName('CTR_NUMDUP').AsString,
                                             FieldByName('CTR_PARCEL').AsString,
                                             FieldByName('CTR_ESPDOC').AsString,
                                             FieldByName('CTR_CODEMP').AsString,
                                             FieldByName('CTR_CODCLI').AsString,
                                             FieldByName('CTR_SEQBAI').AsInteger);
          End;

          If Not blnConfirma Then
            Break;

          If VS_strHabilitarCRM And (Not fEmptyStr(fCfgSis('OCOFIN', varString))) Then
          Begin
            TAtuOcoCrm.pAtualizaOcorrenciaFinanceiro(FieldByName('CTR_NUMDUP').AsString,
                                                     FieldByName('CTR_ESPDOC').AsString,
                                                     FieldByName('CTR_CODEMP').AsString,
                                                     FieldByName('CTR_CODCLI').AsString,
                                                     FieldByName('CTR_PARCEL').AsString,
                                                     strLoginUsuarioLogado,
                                                     fRetCgcCpf(FieldByName('CTR_CODCLI').AsString),
                                                     afcDesagrupaDuplicatas, False, True);
          End;

          Next;

        End;
        Close;
      End;

    End;

    If blnConfirma Then
      blnConfirma := fDeletaDupAgr(strNumAgr, strCodCli);

    If blnConfirma Then
    Begin
      qryApgCtr.First;
      While Not qryApgCtr.Eof Do
      Begin
        If Not fApagaDuplicataContasReceber(qryApgCtr, Self.Name) Then
        Begin
          blnConfirma := False;
          Break;
        End;

        If VS_strHabilitarCRM And (Not fEmptyStr(fCfgSis('OCOFIN', varString))) Then
        Begin
          TAtuOcoCrm.pAtualizaOcorrenciaFinanceiro(qryApgCtr.FieldByName('CTR_NUMDUP').AsString,
                                                   qryApgCtr.FieldByName('CTR_ESPDOC').AsString,
                                                   qryApgCtr.FieldByName('CTR_CODEMP').AsString,
                                                   qryApgCtr.FieldByName('CTR_CODCLI').AsString,
                                                   qryApgCtr.FieldByName('CTR_PARCEL').AsString,
                                                   strLoginUsuarioLogado,
                                                   fRetCgcCpf(qryApgCtr.FieldByName('CTR_CODCLI').AsString),
                                                   afcDesagrupaDuplicatas, False, False, True,
                                                   'Desagrupar Duplicata:' + strNumAgr);
        End;

        qryApgCtr.Next;
      End;

    End;

    If (fCfgSis('CTRARC') = 'S') Then
    Begin

      {******************************************************}
      {***** Verfica se tem registros desse agrupamento *****}
      {***** na tabela de antecipação de recebiveis     *****}
      {***** se tiver executa processo de exclusão      *****}
      {******************************************************}
      if fVerificaRegistroAntecipacaoRecebiveis(strNumAgr, strCodCli, VS_strCodEmp) then
         blnConfirma := fExcluiRelacionadosAntecRecebiveis(strNumAgr, strCodCli, VS_strCodEmp);

    End;

    If blnConfirma Then
    Begin
      If blnAtivarTransacao Then
        fCommit;
    End
    Else
    Begin
      If blnAtivarTransacao Then
        fRollBack;
    End;

    Result := blnConfirma;

  Except

    On E: Exception Do
    Begin
      fRollBack;
      Result := FALSE;
      pMensagensErro(E.Message, '[fDesagrupaDuplicatas]');
    End;

  End;

end;

procedure TfrmDesagrupDuplicatas.FormCreate(Sender: TObject);
begin
  inherited;
  edtNumAgr.TamCampo  := fTamDocCadRec();
  edtNumAgr.MaxLength := edtNumAgr.TamCampo;

  qryDesDup := fCriaQuery(Self);

  qryConCli := fCriarQuery('SELECT * FROM CADCLI WHERE FALSE', Self);

  edtCodEmp.Text     := VS_strCodEmp;
  edtDesEmpresa.Text := fRetNomeEmpresaSelec(VS_strCodEmp);
end;

Function TfrmDesagrupDuplicatas.fVerificaRegistroAntecipacaoRecebiveis(strNumAgr, strCodCli, strCodEmp: String): Boolean;
  Var
    strSQL : String;
    qryGen : TUniQuery;
begin

  Try

    qryGen := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + ' SELECT ANT_NUM_AG ';
    strSQL := strSQL + '   FROM ';
    strSQL := strSQL + ' ANTREC ';
    strSQL := strSQL + '  WHERE ';
    strSQL := strSQL + '  ANT_NUM_AG = :NUMAGR AND ';
    strSQL := strSQL + '  ANT_CODEMP = :EMPAGR AND ';
    strSQL := strSQL + '  ANT_CODCLI = :CODCLI ';
    strSQL := strSQL + '  LIMIT 1 ';

    With qryGen Do
    Begin

      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMAGR').AsString := strNumAgr;
      ParamByName('EMPAGR').AsString := strCodEmp; //VS_strCodEmp;
      ParamByName('CODCLI').AsString := strCodCli;
      Open;

      if Not IsEmpty then
         Result := True
      else
         Result := False;
    End;

  Except

    On E: Exception Do
      Raise Exception.Create('[fVerificaRegistroAntecipacaoRecebiveis] - ' + E.Message);

  End;

End;

{***************************************************}
{* EFETUA VALIDAÇÕES PARA DESAGRUPAMENTO DE AGRUP. *}
{* GERADO PELA ANTECIPAÇÃO DE RECEBIVEIS           *}
{***************************************************}
function  TfrmDesagrupDuplicatas.fVerificacoesDesagrupAntecRecebiveis(strNumAgr, strCodCli, strCodEmp: String): Boolean;
  Var
    strSQL    : String;
    qryGen1   : TUniQuery;
    qryGen2   : TUniQuery;
    strANTNCC : String;
begin

  Try
    qryGen1   := fCriaQuery;
    qryGen2   := fCriaQuery;

    strANTNCC := '';

    {*************************************************************}
    {*** BUSCA O CREDITO GERADO PELA ANTECIPAÇÃO DE RECEBIVEIS ***}
    {*************************************************************}
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  * ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  ANTREC ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  ANT_NUM_AG = :NUMAGR AND ';
    strSQL := strSQL + '  ANT_CODEMP = :EMPAGR AND ';
    strSQL := strSQL + '  ANT_CODCLI = :CODCLI AND ';
    strSQL := strSQL + '  ANT_ESPECI = ''CC'' ';

    With qryGen1 Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMAGR').AsString := strNumAgr;
      ParamByName('EMPAGR').AsString := strCodEmp;
      ParamByName('CODCLI').AsString := strCodCli;
      Open;

      If Not IsEmpty Then
         strANTNCC := qryGen1.FieldByName('ANT_NUM_CC').AsString;

      Result := (strANTNCC <> '');

    End;

    If Result Then
    Begin

      {***************************************}
      {***      VERIFICA CC EM ABERTO      ***}
      {***************************************}
      strSQL := '';
      strSQL := strSQL + ' SELECT ';
      strSQL := strSQL + ' * ';
      strSQL := strSQL + ' FROM ';
      strSQL := strSQL + ' CADREC ';
      strSQL := strSQL + ' WHERE ';
      strSQL := strSQL + ' CTR_NUMDUP = :NUM_CC AND ';
      strSQL := strSQL + ' CTR_CODCLI = :CODCLI AND ';
      strSQL := strSQL + ' CTR_CODEMP = :EMPAGR AND ';
      strSQL := strSQL + ' CTR_ESPDOC = ''CC'' AND ';
      strSQL := strSQL + ' IFNULL(CTR_VALDUP, 0) <> 0 ';

      With qryGen2 Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('EMPAGR').AsString := strCodEmp;
        ParamByName('NUM_CC').AsString := strANTNCC;
        ParamByName('CODCLI').AsString := qryGen1.FieldByName('ANT_CODCLI').AsString;
        Open;

        If IsEmpty Then
        Begin
           Result := False; // se não esta aberto

           fMensagem('', 'Não é possivel realizar o desagrupamento, ' + #13 + #10 +
                         'pois o crédito referente a esse agrupamento ' + #13 + #10 +
                         'foi utilizado em um pagamento !' + #13 + #10 +
                         'Para realizar a operação estorne o pagamento no qual foi utilizado o crédito.', ['&O k']);

        End
        Else
          Result := True;

      End;

    End;

    If Result Then // se o credito esta em aberto, verifica se teve baixa parcial utilizando o credito selecionado.
    Begin

      strSQL := '';
      strSQL := strSQL + ' SELECT ';
      strSQL := strSQL + ' CTR_SEQBAI ';
      strSQL := strSQL + ' FROM ';
      strSQL := strSQL + ' CADREC ';
      strSQL := strSQL + ' WHERE ';
      strSQL := strSQL + ' CTR_NUMDUP = :NUM_CC AND ';
      strSQL := strSQL + ' CTR_CODCLI = :CODCLI AND ';
      strSQL := strSQL + ' CTR_CODEMP = :EMPAGR AND ';
      strSQL := strSQL + ' IFNULL(CTR_SEQBAI, 0) > 0 ';

      With qryGen2 Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('EMPAGR').AsString := strCodEmp;
        ParamByName('NUM_CC').AsString := strANTNCC;  //numero do credito gerado;
        ParamByName('CODCLI').AsString := qryGen1.FieldByName('ANT_CODCLI').AsString;
        Open;

        If IsEmpty Then   // QUE NAO TEVE BAIXA PARCIAIS COM O CREDITO
           Result := True
        Else
        Begin
          Result := False;
          fMensagem('', 'Não é possivel realizar o desagrupamento, ' + #13 + #10 +
                        'pois o crédito referente a esse agrupamento ' + #13 + #10 +
                        'foi utilizado em uma baixa parcial !' , ['&O k']);
        End;

      End;

    End;

    qryGen1.Close;
    qryGen2.Close;

    FreeAndNil(qryGen1);
    FreeAndNil(qryGen2);
  Except

    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fVerificacoesDesagrupAntecRecebiveis]');
    End;

  End;

end;

function TfrmDesagrupDuplicatas.fLancaMovBancariaAntecRecebiveis(strNumAgr, strCodCli, strCodEmp: String): Boolean;
  Var
   strSQL    : String;
   qryGen1   : TUniQuery;
   lstBanLog : TBanCtrRepository;
   intSeqCon : Integer;
   strTipo   : String;
   strEsp    : String;
   strHis    : String;
   strSeqLan : String;
Begin

   Try

     qryGen1 := fCriaQuery;

     {**************************************************}
     {***LANÇA A MOVBAN CONTRARIA APENAS DAS ESPECIES***}
     {**************************************************}
     strSQL := '';
     strSQL := strSQL + ' SELECT ';
     strSQL := strSQL + '  * ';
     strSQL := strSQL + ' FROM ';
     strSQL := strSQL + '   ANTREC ';
     strSQL := strSQL + ' WHERE ';
     strSQL := strSQL + '  ANT_NUM_AG = :NUMAGR   AND ';
     strSQL := strSQL + '  ANT_CODEMP = :EMPAGR   AND ';
     strSQL := strSQL + '  ANT_CODCLI = :CODCLI   AND ';
     strSQL := strSQL + '  ANT_ESPECI <> ''AG''  ';
     // strSQL := strSQL + '  ANT_ESPECI <> ''CC'' '; // Desabilitado pois tem que lançar do credito tmb.

     Result := False;

     With qryGen1 Do
     Begin
       Close;
       SQL.Clear;
       SQL.Add(strSQL);
       ParamByName('NUMAGR').AsString := strNumAgr;
       ParamByName('EMPAGR').AsString := strCodEmp;
       ParamByName('CODCLI').AsString := strCodCli;
       Open;

       If Not IsEmpty Then
       Begin

          intSeqCon := 0;
          strTipo   := 'D';
          strEsp    := '';

          first;
          While Not Eof do
          Begin

                   If FieldbyName('ANT_ESPECI').AsString = 'DH' Then strEsp := 'DINHEIRO'
              else If FieldbyName('ANT_ESPECI').AsString = 'CC' Then strEsp := 'CREDITO'
              else If FieldbyName('ANT_ESPECI').AsString = 'CT' Then strEsp := 'CARTAO'
              else If FieldbyName('ANT_ESPECI').AsString = 'CP' Then strEsp := 'CHQ. PRE'
              else If FieldbyName('ANT_ESPECI').AsString = 'CV' Then strEsp := 'CHEQUE'
              else If FieldbyName('ANT_ESPECI').AsString = 'CC' Then strEsp := 'CREDITO';

              strhis := 'REF. LANC. ' + strEsp + ' DES. ANTEC. RECEBIVEIS';

              {************************************}
              {*** GRAVAÇÃO CONTRARIA DA MOVBAN ***}
              {************************************}
              lstBanLog := TBanCtrRepository.Create;

              lstBanLog.fAdd(strNumAgr,
                             'A',
                             'AG',
                             strCodEmp,
                             strCodCli,
                             strHis,
                             '',
                             intSeqCon,
                             Abs(FieldbyName('ANT_VALLAN').AsFloat));

              strSeqLan := fGravaMovBan( FieldbyName('ANT_CODCTA').AsString, // strCodCta,
                                         FieldbyName('ANT_CODPOR').AsString, // strCodPor,
                                         strLoginUsuarioLogado,              // Operador
                                         VS_Date,                            // Data do Lançamento
                                         fTime(),                            // Hora do Lançamento
                                         strNumAgr,                          // Documento
                                         strTipo,                            // Credito / Debito
                                         strCodEmp,                          // Empresa
                                         Abs(FieldbyName('ANT_VALLAN').AsFloat),  // Valor Documento
                                         strHis,                             // Historico 1
                                         '',                                 // Historico 2
                                         strCodCli,                          // Cliente
                                         '',                                 // Fornecedor
                                         '',                                 // Numero da Duplicata
                                         IntSeqCon,                          // Sequencial Duplicata
                                         '',                                 // Parcela da Duplicata
                                         '',                                 // Empresa da Duplicata
                                         '',                                 // Série
                                         //'',                               // Sequencial de Lançamento
                                         '',                                 // Código do Evento
                                         '',                                 // Documento da Baixa
                                         lstBanLog.fGetList );               // Log Bancário

              Result := (Not fEmptyStr(strSeqLan));

              If Not Result Then
              Begin
                 Break;
                 Exit;
              End;

              FreeAndNil(lstBanLog);

            Next;
          End;

       End;

     End;

     FreeAndNil(qryGen1);
   Except
      On E: Exception Do
        Raise Exception.Create('[fLancaMovBancariaAntecRecebiveis] - ' + E.Message);
   End;

End;

function TfrmDesagrupDuplicatas.fExcluiCreditosAntecRecebiveis(strNumAgr, strCodCli, strCodEmp: String): Boolean;
  Var
   strSQL    : String;
   qryGen1   : TUniQuery;
   strNroCC  : String;
Begin

   {***********************************}
   {***BUSCA O LANÇAMENTO DE CREDITO***}
   {***********************************}
   Try

       qryGen1 := fCriaQuery;

       strNroCC := '';

       strSQL := '';
       strSQL := strSQL + ' SELECT ';
       strSQL := strSQL + '  * ';
       strSQL := strSQL + ' FROM ';
       strSQL := strSQL + '   ANTREC ';
       strSQL := strSQL + ' WHERE ';
       strSQL := strSQL + '  ANT_NUM_AG = :NUMAGR AND ';
       strSQL := strSQL + '  ANT_CODEMP = :EMPAGR AND ';
       strSQL := strSQL + '  ANT_CODCLI = :CODCLI AND ';
       strSQL := strSQL + '  ANT_ESPECI = ''CC'' ';

       Result := False;

       With qryGen1 Do
       Begin

         Close;
         SQL.Clear;
         SQL.Add(strSQL);
         ParamByName('NUMAGR').AsString := strNumAgr;
         ParamByName('EMPAGR').AsString := strCodEmp;
         ParamByName('CODCLI').AsString := strCodCli;
         Open;

         If Not IsEmpty Then
            strNroCC := FieldByName('ANT_NUM_CC').AsString // numero do credito na numdup da cadrec;
         Else
            Result := false;

       End;

       If (Not fEmptyStr(strNroCC)) Then
       Begin

           {*********************************************************}
           {*** DELETA DA CADREC O REGISTRO DE CREDITO DO CLIENTE ***}
           {*********************************************************}
           strSQL := '';
           strSQL := strSQL + ' DELETE ';
           strSQL := strSQL + ' FROM ';
           strSQL := strSQL + '   CADREC ';
           strSQL := strSQL + ' WHERE ';
           strSQL := strSQL + '  CTR_NUMDUP = :NUM_CC AND ';
           strSQL := strSQL + '  CTR_CODEMP = :EMPAGR AND ';
           strSQL := strSQL + '  CTR_CODCLI = :CODCLI AND ';
           strSQL := strSQL + '  CTR_ESPDOC = ''CC'' ';

           Try
             With qryGen1 Do
             Begin
               Close;
               SQL.Clear;
               SQL.Add(strSQL);
               ParamByName('NUM_CC').AsString := strNroCC;
               ParamByName('EMPAGR').AsString := strCodEmp;
               ParamByName('CODCLI').AsString := strCodCli;
               ExecSql;
             End;
             Result := True;
           Except
             Result := False;
           End;

       End;

       FreeAndNil(qryGen1);
   Except
      On E: Exception Do
        Raise Exception.Create('[fExcluiCreditosAntecRecebiveis] - ' + E.Message);
   End;

End;

function TFrmDesagrupDuplicatas.fExcluiCartoesChequesAntecRecebiveis(strNumAgr, strCodCli, strCodEmp : String): Boolean;
  Var
   strSQL     : String;
   strSQL2    : String;
   strSQL3    : String;
   strAutInc  : String;
   qryGen1    : TUniQuery;
   qryGen2    : TUniQuery;
Begin
     {************************************************}
     {*** DELETA OS REGISTROS DE CHEQUES E CARTOES ***}
     {*** DA TABELA MOVCAR E CADCHQ                ***}
     {************************************************}
     qryGen1 := fCriaQuery;
     qryGen2 := fCriaQuery;

     strSQL := '';
     strSQL := strSQL + ' SELECT ';
     strSQL := strSQL + ' AUTOINCREM, ANT_ESPECI  ';
     strSQL := strSQL + ' FROM ';
     strSQL := strSQL + ' ANTREC ';
     strSQL := strSQL + ' WHERE ';
     strSQL := strSQL + ' ANT_NUM_AG = :NUM_AG AND ';
     strSQL := strSQL + ' ANT_CODCLI = :CODCLI AND ';
     strSQL := strSQL + ' ANT_CODEMP = :EMPAGR ';
     strSQL := strSQL + ' AND ( (ANT_ESPECI = ''CP'' ) ';
     strSQL := strSQL + '  OR   (ANT_ESPECI = ''CV'' ) ';
     strSQL := strSQL + '  OR   (ANT_ESPECI = ''CT'' ) ';
     strSQL := strSQL + '     ) ';

     {*** DELETE MOVCAR ***}
     strSQL2 := '';
     strSQL2 := strSQL2 + ' DELETE ';
     strSQL2 := strSQL2 + ' FROM ';
     strSQL2 := strSQL2 + ' MOVCAR ';
     strSQL2 := strSQL2 + ' WHERE ';
     strSQL2 := strSQL2 + ' MCA_SEQANT = :AUTINC AND ';
     strSQL2 := strSQL2 + ' MCA_CODCLI = :CODCLI AND ';
     strSQL2 := strSQL2 + ' MCA_CODEMP = :CODEMP ';

     {*** DELETE CADCHQ ***}
     strSQL3 := '';
     strSQL3 := strSQL3 + ' DELETE ';
     strSQL3 := strSQL3 + ' FROM ';
     strSQL3 := strSQL3 + ' CADCHQ ';
     strSQL3 := strSQL3 + ' WHERE ';
     strSQL3 := strSQL3 + ' CHQ_SEQANT = :AUTINC AND ';
     strSQL3 := strSQL3 + ' CHQ_CODCLI = :CODCLI AND ';
     strSQL3 := strSQL3 + ' CHQ_CODEMP = :CODEMP ';

     Result := false;

     Try
       With qryGen1 Do
       Begin
         Close;
         SQL.Clear;
         SQL.Add(strSQL);
         ParamByName('NUM_AG').AsString := strNumAgr;
         ParamByName('CODCLI').AsString := strCodCli;
         ParamByName('EMPAGR').AsString := strCodEmp;
         Open;

         first;
         If Not Isempty Then
         Begin

           While Not Eof Do
           Begin

             strAutInc := fieldbyName('AUTOINCREM').AsString;

             {**************************************************}
             {*** DELETA OS REGISTROS DA MOVCAR RELACIONADOS ***}
             {*** COM A TABELA ANTREC PELO CAMPO AUTOINCREM  ***}
             {**************************************************}
             Try

               If fieldbyName('ANT_ESPECI').AsString = 'CT' Then
               Begin

                  With qryGen2 Do
                  Begin
                    Close;
                    SQL.Clear;
                    SQL.Add(strSQL2);
                    ParamByName('AUTINC').AsString := strAutInc;
                    ParamByName('CODCLI').AsString := strCodCli;
                    ParamByName('CODEMP').AsString := strCodEmp;
                    ExecSql;
                    Result := True;
                  End;

               End;

             Except
               Result := False;
               Break;
             End;

             {**************************************************}
             {*** DELETA OS REGISTROS DA CADCHQ RELACIONADOS ***}
             {*** COM A TABELA ANTREC PELO CAMPO AUTOINCREM  ***}
             {**************************************************}
             Try

               If (fieldbyName('ANT_ESPECI').AsString = 'CV') or
                  (fieldbyName('ANT_ESPECI').AsString = 'CP') Then
               Begin

                  With qryGen2 Do
                  Begin
                    Close;
                    SQL.Clear;
                    SQL.Add(strSQL3);
                    ParamByName('AUTINC').AsString := strAutInc;
                    ParamByName('CODCLI').AsString := strCodCli;
                    ParamByName('CODEMP').AsString := strCodEmp;
                    ExecSql;
                    Result := True;
                  End;

               End;

             Except
               Result := False;
               Break;
             End;

             Next;
           End;

         End
         Else
           Result := True; //Retorna true pq não tem nenhuma especie tipo cartão ou tipo cheque;

       End;

       FreeAndNil(qryGen1);
       FreeAndNil(qryGen2);
     Except
        On E: Exception Do
          Raise Exception.Create('[fExcluiCartoesChequesAntecRecebiveis] - ' + E.Message);
     End;

End;


{******************************************************}
{* EFETUA EXCLUSOES DAS TABELAS RELACIONADAS Á        *}
{* ANTECIPAÇÃO DE RECEBIMENTOS E FAZ OS LANÇAMENTOS   *)
{* CONTRARIOS NA MOVBAN DOS REGITROS GERADOS          *}
{* PELA ANTECIPAÇÃO DE RECEBIVEIS                     *}
{******************************************************}
function TfrmDesagrupDuplicatas.fExcluiRelacionadosAntecRecebiveis(strNumAgr, strCodCli, strCodEmp: String): Boolean;
  Var
   strSQL     : String;
   qryGen1    : TUniQuery;
   blnOk      : Boolean;
begin

  Try

     qryGen1 := fCriaQuery;

     {************************************}
     {*** GRAVAÇÃO CONTRARIA DA MOVBAN ***}
     {************************************}
     blnOk := fLancaMovBancariaAntecRecebiveis(strNumAgr, strCodCli, strCodEmp);

     {***********************************}
     {***BUSCA O LANÇAMENTO DE CREDITO***}
     {***********************************}
     if blnOk then
        blnOk := fExcluiCreditosAntecRecebiveis(strNumAgr, strCodCli, strCodEmp);

     If (blnOk) Then
        blnOk := fExcluiCartoesChequesAntecRecebiveis(strNumAgr, strCodCli, strCodEmp);

     If (blnOk) Then
     Begin

         {********************************************}
         {*** DELETA TODOS OS REGISTROS DA         ***}
         {*** TABELA DE ANTECIPAÇÃO DE RECEBIVIES  ***}
         {*** REFERENTE AO AGRUPAMENTO             ***}
         {********************************************}
         strSQL := '';
         strSQL := strSQL + ' DELETE   ';
         strSQL := strSQL + ' FROM     ';
         strSQL := strSQL + '   ANTREC ';
         strSQL := strSQL + ' WHERE ';
         strSQL := strSQL + '  ANT_NUM_AG = :NUMAGR AND ';
         strSQL := strSQL + '  ANT_CODEMP = :EMPAGR AND ';
         strSQL := strSQL + '  ANT_CODCLI = :CODCLI ';

         Try
           With qryGen1 Do
           Begin
             Close;
             SQL.Clear;
             SQL.Add(strSQL);
             ParamByName('NUMAGR').AsString := strNumAgr;
             ParamByName('EMPAGR').AsString := strCodEmp;
             ParamByName('CODCLI').AsString := strCodCli;
             ExecSql;
           End;
           blnOk := True;
         Except
           blnOk := False;
         End;

     End;

     qryGen1.Close;
     FreeAndNil(qryGen1);

     Result := blnOk;

  Except

    On E: Exception Do
      Raise Exception.Create(E.Message);

  End;

end;

Function TfrmDesagrupDuplicatas.fVerificaTemCartoesBaixadosAntecipacao(strNumAgr, strCodCli, strCodEmp: String): Boolean;
  Var
   strSQL     : String;
   strSQL2    : String;
   strAutInc  : String;
   qryGen1    : TUniQuery;
   qryGen2    : TUniQuery;
   blnOk      : Boolean;
Begin

  Try
     {*************************************}
     {*** BUSCA OS REGISTROS DE CARTOES ***}
     {*************************************}
     qryGen1 := fCriaQuery;
     qryGen2 := fCriaQuery;
     blnOk   := False;

     strSQL := '';
     strSQL := strSQL + ' SELECT ';
     strSQL := strSQL + ' AUTOINCREM, ANT_ESPECI  ';
     strSQL := strSQL + ' FROM ';
     strSQL := strSQL + ' ANTREC ';
     strSQL := strSQL + ' WHERE ';
     strSQL := strSQL + ' ANT_NUM_AG = :NUM_AG AND ';
     strSQL := strSQL + ' ANT_CODCLI = :CODCLI AND ';
     strSQL := strSQL + ' ANT_CODEMP = :EMPAGR AND ';
     strSQL := strSQL + ' ANT_ESPECI = ''CT'' ';

     strSQL2 := '';
     strSQL2 := strSQL2 + ' SELECT ';
     strSQL2 := strSQL2 + '  MCA_NUMDUP ';
     strSQL2 := strSQL2 + ' FROM MOVCAR ';
     strSQL2 := strSQL2 + '  WHERE ';
     strSQL2 := strSQL2 + ' MCA_SEQANT = :SEQANT ';
     strSQL2 := strSQL2 + ' AND MCA_DTAREC IS NOT NULL ';
     strSQL2 := strSQL2 + ' AND MCA_VALREC IS NOT NULL ';

     Try

       With qryGen1 Do
       Begin
         Close;
         SQL.Clear;
         SQL.Add(strSQL);
         ParamByName('NUM_AG').AsString := strNumAgr;
         ParamByName('EMPAGR').AsString := strCodEmp;
         ParamByName('CODCLI').AsString := strCodCli;
         Open;
         If Not IsEmpty Then
         Begin

           strAutInc := FieldByName('AUTOINCREM').AsString;

           With qryGen2 Do
           Begin
             Close;
             SQL.Clear;
             SQL.Add(strSQL2);
             ParamByName('SEQANT').AsString := strAutInc;
             Open;
             If Not IsEmpty Then // tem cartoes baixados
             Begin
                blnOk := True;
                fMensagem('', 'Não é possivel realizar o desagrupamento, ' + #13 + #10 +
                              'pois existem cartões relacionados a esse agrupamento ' + #13 + #10 +
                              'que ja foram baixados !' , ['&O k']);
             End;

           End;

         End;

       End;

     Except
       blnOk := True;
     End;

     qryGen1.Close;
     qryGen2.Close;
     FreeAndNil(qryGen1);
     FreeAndNil(qryGen2);

     Result := blnOk;

  Except

    On E: Exception Do
      Raise Exception.Create('[fVerificaTemCartoesBaixadosAntecipacao] - ' + E.Message);

  End;

End;

Function TfrmDesagrupDuplicatas.fVerificaTemChequesBaixadosAntecipacao(strNumAgr, strCodCli, strCodEmp: String): Boolean;
  Var
   strSQL     : String;
   strSQL2    : String;
   strAutInc  : String;
   strCHQAutoInc : String;
   qryGen1    : TUniQuery;
   qryGen2    : TUniQuery;
   blnOk      : Boolean;
   blnTemChqBx: Boolean;
Begin
  Try
     {*************************************}
     {*** BUSCA OS REGISTROS DE CHEQUES ***}
     {*************************************}
     qryGen1 := fCriaQuery;
     qryGen2 := fCriaQuery;
     blnOk   := False;

     strSQL := '';
     strSQL := strSQL + ' SELECT ';
     strSQL := strSQL + ' C.AUTOINCREM CHQ_AUTO, A.AUTOINCREM, A.ANT_ESPECI ';
     strSQL := strSQL + ' FROM ';
     strSQL := strSQL + ' ANTREC A ';
     strSQL := strSQL + ' INNER JOIN CADCHQ C ON C.CHQ_SEQANT = A.AUTOINCREM ';
     strSQL := strSQL + ' WHERE ';
     strSQL := strSQL + ' A.ANT_NUM_AG = :NUM_AG AND ';
     strSQL := strSQL + ' A.ANT_CODCLI = :CODCLI AND ';
     strSQL := strSQL + ' A.ANT_CODEMP = :EMPAGR ';
     strSQL := strSQL + ' AND ( (A.ANT_ESPECI = ''CP'' ) ';
     strSQL := strSQL + '  OR   (A.ANT_ESPECI = ''CV'' ) ';
     strSQL := strSQL + '     ) ';

     strSQL2 := '';
     strSQL2 := strSQL2 + 'SELECT AUTOINCREM,CHQ_DTADEP, CHQ_DTADP2, CHQ_DTADEV,CHQ_DTADV2, CHQ_DTAREP,CHQ_DEVDEF FROM CADCHQ ';
     strSQL2 := strSQL2 + ' WHERE ';
     strSQL2 := strSQL2 + '       CHQ_SEQANT     = :SEQANT ';
     strSQL2 := strSQL2 + '   AND AUTOINCREM = :AUTOINCREM ';
     strSQL2 := strSQL2 + '   AND (CHQ_DTAREP IS NULL) ';
     strSQL2 := strSQL2 + '   AND ';
     strSQL2 := strSQL2 + '       ( ';
     strSQL2 := strSQL2 + '         ((CHQ_DTADEP IS NULL) AND (CHQ_DTADEV IS NULL)) ';
     strSQL2 := strSQL2 + '         OR ';
     strSQL2 := strSQL2 + '         ((CHQ_DTADEP IS NOT NULL) AND (CHQ_DTADEV IS NOT NULL)) ';
     strSQL2 := strSQL2 + '         OR ';
     strSQL2 := strSQL2 + '         ((CHQ_DTADEP IS NOT NULL) AND (CHQ_DTADEV IS NOT NULL) AND (CHQ_DEVDEF = 1)) ';
     strSQL2 := strSQL2 + '       )';
     strSQL2 := strSQL2 + '   AND ';
     strSQL2 := strSQL2 + '       ( ';
     strSQL2 := strSQL2 + '         ((CHQ_DTADP2 IS NULL) AND (CHQ_DTADV2 IS NULL)) ';
     strSQL2 := strSQL2 + '         OR ';
     strSQL2 := strSQL2 + '         ((CHQ_DTADP2 IS NOT NULL) AND (CHQ_DTADV2 IS NOT NULL)) ';
     strSQL2 := strSQL2 + '         OR ';
     strSQL2 := strSQL2 + '         ((CHQ_DTADP2 IS NOT NULL) AND (CHQ_DTADV2 IS NOT NULL) AND (CHQ_DEVDEF = 1)) ';
     strSQL2 := strSQL2 + '       ) ';

     Try

       With qryGen1 Do
       Begin
         Close;
         SQL.Clear;
         SQL.Add(strSQL);
         ParamByName('NUM_AG').AsString := strNumAgr;
         ParamByName('EMPAGR').AsString := strCodEmp;
         ParamByName('CODCLI').AsString := strCodCli;
         Open;
         If Not IsEmpty Then
         Begin

           // Percorre todos os cheques pre e a vista
           first;
           blnTemChqBx := false; // tem cheque baixado;
           While Not Eof do
           Begin

             strAutInc     := FieldByName('AUTOINCREM').AsString;
             strCHQAutoInc := FieldByName('CHQ_AUTO').AsString;

             With qryGen2 Do
             Begin
               Close;
               SQL.Clear;
               SQL.Add(strSQL2);
               ParamByName('SEQANT'    ).AsString := strAutInc;
               ParamByName('AUTOINCREM').AsString := strCHQAutoInc;
               Open;
               If IsEmpty Then // tem cheques baixados // NOT
                  blnTemChqBx := True;
             End;

             If blnTemChqBx Then
                Break;

             Next;
           End;

           If blnTemChqBx Then
           Begin
              fMensagem('', 'Não é possivel realizar o desagrupamento, ' + #13 + #10 +
                            'pois existem cheques relacionados a esse agrupamento ' + #13 + #10 +
                            'que podem ter sido baixados, depositados ou repassados !' , ['&O k']);
              blnOk := true;
           End;

         End;

       End;

     Except
       blnOk := true;
     End;

     qryGen1.Close;
     qryGen2.Close;
     FreeAndNil(qryGen1);
     FreeAndNil(qryGen2);

     Result := blnOk;

  Except

    On E: Exception Do
    Begin
      Result := True;
      pMensagensErro(E.Message, '[fVerificaTemChequesBaixadosAntecipacao]');
    End;

  End;

End;

end.

