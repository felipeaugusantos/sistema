unit untGeraVisitaCliente;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, ComCtrls, Mask,
  MaskEditFocus, Uni, AppEvnts, EditFocus,
  DB, UniDataSetProvider, UniClientDataSet, BitBtnLockedIncrem, DateUtils,
  cxProgressBar, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, frxClass,
  frxExportCSVTestabilidade;

type
  TfrmGeraVisitaCliente = class(TfrmPai)
    pnlPeriodo: TPanel;
    grbPerido: TGroupBox;
    Label6: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    Label12: TLabel;
    edtCodCliente: TEditFocus;
    edtDesCliente: TEditFocus;
    Label1: TLabel;
    edtCodCid: TEditFocus;
    edtDesCid: TEditFocus;
    btnGerar: TBitBtnLocked;
    Label2: TLabel;
    edtCodRep: TEditFocus;
    edtDesRep: TEditFocus;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodClienteKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodClienteExit(Sender: TObject);
    procedure edtCodCidKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCidExit(Sender: TObject);
    procedure edtCodRepKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodRepExit(Sender: TObject);
    procedure btnGerarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    procedure pInfoStatusGravacao(strInformacao: String; pgbProgresso: TcxProgressBar);
    procedure pStepStatusGravacao(pgbProgresso: TcxProgressBar);

    function fGravaArquivos(pgbStatus: TcxProgressBar = Nil): Boolean;
  public
    { Public declarations }

  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  end;

implementation

uses  untfuncoesSimples, untConsultas, untGravando, untTypesSistema;

{$R *.dfm}

function TfrmGeraVisitaCliente.fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin

    If pnlPeriodo.Visible Then
    Begin

      {***********************}
      {* VALIDA DATA INICIAL *}
      {********************LA*}
      If (Sender = mskDtaIni) Then
      Begin

        If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'O campo Data Inicial deve ser preenchido!', ['&O k']);
          Result := False;
        End

        Else If (StrToDate(mskDtaIni.Text) < VS_Date) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Data Inicial não pode ser anterior à ' + DateToStr(VS_Date), ['&O k']);
          Result := False;
        End;

      End

      {*********************}
      {* VALIDA DATA FINAL *}
      {******************LA}
      Else If (Sender = mskDtaFin) Then
      Begin

        If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
        Begin
          fMensagem('ATENÇÃO!','O campo Data Final deve ser preenchido!', ['&O k']);
          Result := False;
        End

        Else If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
        Begin
          fMensagem('ATENÇÃO!','A data inicial deve ser menor que a data final!',['&O K']);
          Result := False;
        End;

      End;

    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmGeraVisitaCliente.pInfoStatusGravacao(strInformacao: String;
  pgbProgresso: TcxProgressBar);
begin
  If Assigned(pgbProgresso) And (GetParentForm(pgbProgresso).FindComponent('lblGravando') <> Nil) Then
  Begin
    TLabel(GetParentForm(pgbProgresso).FindComponent('lblGravando')).Caption := strInformacao;
    Application.ProcessMessages;
  End;
end;

procedure TfrmGeraVisitaCliente.pStepStatusGravacao(
  pgbProgresso: TcxProgressBar);
begin
  If Assigned(pgbProgresso) Then
  Begin
    pgbProgresso.Position := pgbProgresso.Position + 1;
    Application.ProcessMessages;
  End;
end;

procedure TfrmGeraVisitaCliente.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(mskDtaIni);
end;

procedure TfrmGeraVisitaCliente.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_F10   : btnGerar.Click;
    VK_ESCAPE: Close;
  End;
end;

procedure TfrmGeraVisitaCliente.FormShow(Sender: TObject);
begin
  inherited;
  mskDtaIni.Text := DateToStr(VS_Date);
  mskDtaFin.Text := DateToStr(VS_Date);
end;

procedure TfrmGeraVisitaCliente.edtCodClienteKeyPress(
  Sender: TObject; var Key: Char);
  Var
    arrClientes: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE CLIENTES   *}
  {****************************RV*}
  If fPesqCliente(conCliSimples, Self, edtCodCliente, edtDesCliente, Nil, Key, arrClientes) Then
  Begin
    If fValidaCampos(edtCodCliente, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmGeraVisitaCliente.edtCodRepExit(Sender: TObject);
begin
  inherited;
  If fEmptyStr(edtCodRep.Text) Then
    edtDesRep.Text := 'TODOS'
  Else
    edtDesRep.Text := fRetNomVendRep(edtCodRep.Text);

  If fEmptyStr(edtDesRep.Text) And (Not fEmptyStr(edtCodRep.Text))  Then
  Begin
    fMensagem('AVISO','Código do representante não encontrado.', ['&O K']);
    edtCodRep.Clear;
    pSetFocus(edtCodRep);
  End;
end;

procedure TfrmGeraVisitaCliente.edtCodRepKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrRep: TConsultasArray;
begin
  inherited;
  {*****************************}
  {* NOVA CONSULTA DE VENDEDOR *}
  {**************************MM*}
  if fPesqOperador(Self, edtCodRep, edtDesRep, Nil, Key, arrRep) then
  Begin
    If fValidaCampos(edtCodRep, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmGeraVisitaCliente.fGravaArquivos(pgbStatus: TcxProgressBar = Nil): Boolean;
  Var
    qryGen   : TUniQuery;

    intDiaSem,
    intSemana,
    intMeses,
    iMes,
    iDia : Integer;

    dtaData  : TDate;
    blnSemPar: Boolean;
    strCodLot: String;
    dtaDtaIns: TDate;
    dtaHorIns: TTime;

    function fApagaAgeVis(strCodEmp,
                          strCodCli,
                          strCodCid,
                          strCodRep: String;
                          dtaDtaIni,
                          dtaDtaFin: TDate): Boolean;
      Var
        qrySalva : TUniQuery;
    Begin
      Try
        qrySalva := fCriaQuery;

        With qrySalva, SQL Do
        Begin
          Clear;
          Add('DELETE FROM AGEVIS          ');
          Add('WHERE  AGE_CODEMP = :CODEMP ');
          If Not fEmptyStr(strCodCli) Then
            Add('AND    AGE_CODCLI = :CODCLI ');
          If Not fEmptyStr(strCodCid) Then
            Add('AND    AGE_CODCID = :CODCID ');
          If Not fEmptyStr(strCodRep) Then
            Add('AND    AGE_CODREP = :CODREP ');
          Add('AND    AGE_DTAVIS BETWEEN :DTAINI AND :DTAFIN ');
          Add('AND    AGE_POSITI = "N"     ');

          ParamByName('CODEMP').AsString := strCodEmp;
          If Not fEmptyStr(strCodCli) Then
            ParamByName('CODCLI').AsString := strCodCli;
          If Not fEmptyStr(strCodCid) Then
            ParamByName('CODCID').AsString := strCodCid;
          If Not fEmptyStr(strCodRep) Then
            ParamByName('CODREP').AsString := strCodRep;
          ParamByName('DTAINI').AsDate   := dtaDtaIni;
          ParamByName('DTAFIN').AsDate   := dtaDtaFin;

          ExecSQL;

          Result := True;
        End;
      Except
        On E : Exception Do
        Begin
          pMensagensErro(E.Message,'[TfrmGeraVisitaCliente.fApagaAgeVis]');
          Result := False;
        End;
      End;

      FreeAndNil(qrySalva);
    End;

    function fGravaAgeVis(strCodEmp,
                          strCodVen,
                          strCodRep,
                          strCodCli,
                          strCodCid: String;
                          dtaDtaVis: TDate): Boolean;
      Var
        qrySalva : TUniQuery;
    Begin
      Try
        qrySalva := fCriaQuery;

        With qrySalva, SQL Do
        Begin
          Clear;
          Add('INSERT INTO     ');
          Add('  AGEVIS (      ');
          Add('    AUTOINCREM, ');
          Add('    AGE_CODEMP, ');
          Add('    AGE_CODVEN, ');
          Add('    AGE_CODREP, ');
          Add('    AGE_CODCLI, ');
          Add('    AGE_CODCID, ');
          Add('    AGE_DTAVIS, ');
          Add('    AGE_CODLOT, ');
          Add('    AGE_INDCOL, ');
          Add('    AGE_DTAINS, ');
          Add('    AGE_HORINS  ');
          Add('  ) VALUES (    ');
          Add('    :AUTINC,    ');
          Add('    :CODEMP,    ');
          Add('    :CODVEN,    ');
          Add('    :CODREP,    ');
          Add('    :CODCLI,    ');
          Add('    :CODCID,    ');
          Add('    :DTAVIS,    ');
          Add('    :CODLOT,    ');
          Add('    :INDCOL,    ');
          Add('    :DTAINS,    ');
          Add('    :HORINS)    ');

          ParamByName('AUTINC').AsString := fRetAutoIncrem('AGEVIS', VS_strCodEmp);
          ParamByName('CODEMP').AsString := strCodEmp;
          ParamByName('CODVEN').AsString := strCodVen;
          ParamByName('CODREP').AsString := strCodRep;
          ParamByName('CODCLI').AsString := strCodCli;
          ParamByName('CODCID').AsString := strCodCid;
          ParamByName('DTAVIS').AsDate   := dtaDtaVis;
          ParamByName('CODLOT').AsString := strCodLot;
          ParamByName('INDCOL').AsString := 'C';
          ParamByName('DTAINS').AsDate   := dtaDtaIns;
          ParamByName('HORINS').AsTime   := dtaHorIns;

          ExecSQL;

          Result := True;
        End;
      Except
        On E : Exception Do
        Begin
          pMensagensErro(E.Message,'[TfrmGeraVisitaCliente.fGravaAgeVis]');
          Result := False;
        End;
      End;

      FreeAndNil(qrySalva);
    End;
begin
  Try
    qryGen := fCriaQuery;
    Result := False;

    With qryGen, Sql Do
    Begin
      Close;
      Clear;
      Add('SELECT SQL_NO_CACHE ');
      Add('  CLI_CODCLI, ');
      Add('  CLI_CODCID, ');
      Add('  CLI_CODVEN, ');
      Add('  CLI_CODREP, ');
      Add('  CLI_DIAVIS, ');
      Add('  CLI_PERDVI  ');
      Add('FROM ');
      Add('  CADCLI ');
      Add('WHERE IFNULL(CLI_DIAVIS,"") <> "NNNNNN" ');
      Add('AND   IFNULL(CLI_PERDVI,"") <> ""       ');
      Add('AND   ((IFNULL(CLI_CODVEN,"") <> "") OR ');
      Add('       (IFNULL(CLI_CODREP,"") <> ""))   ');

      If Not fEmptyStr(edtCodCliente.Text) Then
        Add(' AND CLI_CODCLI = :CODCLI ');

      If Not fEmptyStr(edtCodRep.Text) Then
        Add(' AND CLI_CODREP = :CODREP ');

      If Not fEmptyStr(edtCodCid.Text) Then
        Add(' AND CLI_CODCID = :CODCID ');

      If Not fEmptyStr(edtCodCliente.Text) Then
        ParamByName('CODCLI').AsString := edtCodCliente.Text;

      If Not fEmptyStr(edtCodRep.Text) Then
        ParamByName('CODREP').AsString := edtCodRep.Text;

      If Not fEmptyStr(edtCodCid.Text) Then
        ParamByName('CODCID').AsString := edtCodCid.Text;

      Open;

      If Not IsEmpty Then
      Begin
        strCodLot := fAtualizaProCod('AGEVIS', 'AGE_CODLOT');
        dtaDtaIns := VS_Date;
        dtaHorIns := fTime();

        If fApagaAgeVis(VS_strCodEmp,
                        edtCodCliente.Text,
                        edtCodCid.Text,
                        edtCodRep.Text,
                        StrToDate(mskDtaIni.Text),
                        StrToDate(mskDtaFin.Text)) Then
        Begin
          While Not EOF Do
          Begin
            pInfoStatusGravacao('Aguarde... Gerando Visitas (' + IntToStr(RecNo) + '/' + IntToStr(RecordCount) + ')', pgbStatus);

            dtaData    := StrToDate(mskDtaIni.Text);
            pgbStatus.Position:= 0;

            {*************}
            {* SEMANAL   *}
            {*************}
            If (FieldByName('CLI_PERDVI').AsString = 'S') Then
            Begin
              pgbStatus.Properties.Max := DaysBetween(dtaData, StrToDate(mskDtaFin.Text));

              While Not (dtaData > StrToDate(mskDtaFin.Text)) Do
              Begin
                intDiaSem:= DayOfWeek(dtaData) - 1;

                If (intDiaSem <> 0) And
                   (Copy(FieldByName('CLI_DIAVIS').AsString, intDiaSem, 1) = 'S') Then
                Begin
                  If Not fGravaAgeVis(VS_strCodEmp,
                                      FieldByName('CLI_CODVEN').AsString,
                                      FieldByName('CLI_CODREP').AsString,
                                      FieldByName('CLI_CODCLI').AsString,
                                      FieldByName('CLI_CODCID').AsString,
                                      dtaData) Then
                    Exit;
                End;

                pStepStatusGravacao(pgbStatus);

                dtaData := IncDay(dtaData,1);
              End;
            End

            {*************}
            {* QUINZENAL *}
            {*************}
            Else If (FieldByName('CLI_PERDVI').AsString = 'Q') Then
            Begin
              pgbStatus.Properties.Max := DaysBetween(dtaData, StrToDate(mskDtaFin.Text));
              intSemana  := WeekOf(dtaData);
              blnSemPar  := intSemana Mod 2 = 0;

              While Not (dtaData > StrToDate(mskDtaFin.Text)) Do
              Begin
                intDiaSem := DayOfWeek(dtaData) - 1;

                If (intDiaSem <> 0) And
                   (Copy(FieldByName('CLI_DIAVIS').AsString, intDiaSem, 1) = 'S') And
                   ((WeekOf(dtaData) Mod 2 = 0) = blnSemPar) Then
                Begin
                  If Not fGravaAgeVis(VS_strCodEmp,
                                      FieldByName('CLI_CODVEN').AsString,
                                      FieldByName('CLI_CODREP').AsString,
                                      FieldByName('CLI_CODCLI').AsString,
                                      FieldByName('CLI_CODCID').AsString,
                                      dtaData) Then
                    Exit;
                End;

                pStepStatusGravacao(pgbStatus);

                dtaData := IncDay(dtaData,1);
              End;
            End

            {*************}
            {* MENSAL    *}
            {*************}
            Else If (FieldByName('CLI_PERDVI').AsString = 'M') Then
            Begin
              intMeses := MonthsBetween(dtaData, StrToDate(mskDtaFin.Text)) + 1;
              pgbStatus.Properties.Max := intMeses * 7;

              For iMes := 1 To intMeses Do
              Begin
                If iMes > 1 Then
                  dtaData := IncMonth(StrToDate(mskDtaIni.Text),iMes-1);

                For iDia := 1 To 7 Do
                Begin
                  intDiaSem:= DayOfWeek(dtaData) - 1;

                  If (intDiaSem <> 0) And
                     (dtaData <= StrToDate(mskDtaFin.Text)) And
                     (Copy(FieldByName('CLI_DIAVIS').AsString, intDiaSem, 1) = 'S') Then
                  Begin
                    If Not fGravaAgeVis(VS_strCodEmp,
                                        FieldByName('CLI_CODVEN').AsString,
                                        FieldByName('CLI_CODREP').AsString,
                                        FieldByName('CLI_CODCLI').AsString,
                                        FieldByName('CLI_CODCID').AsString,
                                        dtaData) Then
                      Exit;
                  End;

                  pStepStatusGravacao(pgbStatus);

                  dtaData := IncDay(dtaData,1);
                End;
              End;

            End;

            Next;
          End;

          Result := True;
        End
        Else
          Result := False;
      End
      Else
      Begin
        fMensagem('ATENÇÃO!', 'Nenhum cliente foi encontrado para geração de visitas!', ['&O k']);
        Result := False;
      End;
    End;

  Except
    On E : Exception Do
    Begin
      pMensagensErro(E.Message,'[TfrmGeraVisitaCliente.btnGerarClick]');
      Result := False;
    End;
  End;

  FreeAndNil(qryGen);
end;

procedure TfrmGeraVisitaCliente.btnGerarClick(Sender: TObject);
begin
  inherited;

  if fVerificaCampos Then
  Begin
    Try
      pCriarFormularios(TfrmGravando, frmGravando);
      frmGravando.fExecutarAcao := fGravaArquivos;
      frmGravando.ShowModal;

      If frmGravando.blnConfirma Then
        fMensagem('', 'Agendamento de visitas gerado com sucesso. ', ['&O k']);      
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '');
    End;
  End;
end;

procedure TfrmGeraVisitaCliente.edtCodCidExit(Sender: TObject);
begin
  inherited;
  If fEmptyStr(edtCodCid.Text) Then
    edtDesCid.Text := 'TODAS'
  Else
    edtDesCid.Text := fRetCidade(edtCodCid.Text);

  If fEmptyStr(edtDesCid.Text) And (Not fEmptyStr(edtCodCid.Text))  Then
  Begin
    fMensagem('AVISO','Código da cidade não encontrada.', ['&O K']);
    edtCodCid.Clear;
    pSetFocus(edtCodCid);
  End;
end;

procedure TfrmGeraVisitaCliente.edtCodCidKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrCidade: TConsultasArray;
begin
  inherited;
  {****************************}
  {* NOVA CONSULTA DE CIDADES *}
  {*************************RV*}
  If fPesqCidade(Self, edtCodCid, edtDesCid, Nil, Nil, Key, arrCidade) Then
  Begin
    If fValidaCampos(edtCodCid, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmGeraVisitaCliente.edtCodClienteExit(Sender: TObject);
begin
  inherited;
  If fEmptyStr(edtCodCliente.Text) Then
    edtDesCliente.Text := 'TODOS'
  Else
    edtDesCliente.Text := fRetNomCliente(edtCodCliente.Text);

  If fEmptyStr(edtDesCliente.Text) And (Not fEmptyStr(edtCodCliente.Text))  Then
  Begin
    fMensagem('AVISO','Código do cliente não encontrado.', ['&O K']);
    edtCodCliente.Clear;
    pSetFocus(edtCodCliente);
  End;
end;

end.

