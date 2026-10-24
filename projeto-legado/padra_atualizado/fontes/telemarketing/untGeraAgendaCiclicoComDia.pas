unit untGeraAgendaCiclicoComDia;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, ComCtrls, Mask,
  MaskEditFocus, untFuncoes, Uni, AppEvnts, EditFocus,
  DB, UniDataSetProvider, UniClientDataSet, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade;

type
  TfrmGeraAgendaCiclicoComDia = class(TfrmPai)
    pgbAge: TProgressBar;
    pnlAgeAut: TPanel;
    pnlPeriodo: TPanel;
    grbPerido: TGroupBox;
    Label6: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    Memo1: TMemo;
    Label12: TLabel;
    edtCodCliente: TEditFocus;
    edtDesCliente: TEditFocus;
    Label1: TLabel;
    edtCodAti: TEditFocus;
    edtDesAti: TEditFocus;
    btnGerar: TBitBtnLocked;
    procedure btnGerarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure ApplicationEventsException(Sender: TObject; E: Exception);
    procedure edtCodClienteKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodClienteExit(Sender: TObject);
    procedure pCarregaCliente(Var qryCadCli: TUniQuery);
    procedure edtCodAtiKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    qryAgeTmp: TUniQuery;

    Function fGetNroIntevalosComDia(var intIntevalos: Integer): Boolean;
    Function fGetNroIntevalosContinuo(var intIntevalos: Integer): Boolean;
    Function fGeraPeriodoComDia(intNroIntervalo: Integer; Var intIncluidos: Integer): Boolean;
    Function fGeraAutomatico(Var intIncluidos: Integer): Boolean;
    Function fGeraPeriodoContinuo(intNroIntervalo: Integer; Var intIncluidos: Integer): Boolean;
    Function fSetaAutoInc: Boolean;
    Function fGeraAgendamento(intIntervalos: Integer): Boolean;
    Function fApagaAbertosNoPeriodo: Boolean;
    Function fGeraDatasDeInicio: Boolean;
    function fGravaAutoAgeTel: Boolean;

  public
    { Public declarations }
    tagTipAge: TTipoAgendamento;
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  end;

var
  frmGeraAgendaCiclicoComDia: TfrmGeraAgendaCiclicoComDia;

implementation

uses untfuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}

function TfrmGeraAgendaCiclicoComDia.fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean;
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

      End

      Else If (Sender = edtCodAti) Then
      Begin
        If Not fEmptyStr(edtCodAti.Text) Then
        Begin
          edtDesAti.Text := fCampoTabela('ATI_DESATI','CADATI',['ATI_CODATI'],[edtCodAti.Text]);
          If fEmptyStr(edtDesAti.Text) Then
          Begin
            fMensagem('','Atividade não cadastrada!', ['&Ok']);
            Result := False;
          End;
        End
        Else
          edtDesAti.Text := 'TODOS'
      End;

    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

Function TfrmGeraAgendaCiclicoComDia.fGetNroIntevalosComDia(var intIntevalos: Integer): Boolean;
  Var
    qryGen: TUniQuery;
Begin
  intIntevalos := 0;
  Try
    qryGen := fCriaQuery;
    With qryGen, Sql Do
    Begin
      Clear;
      Add('SELECT     ');
      Add('  MAX( TRUNCATE(((DATEDIFF(:DTAFIN, ');
      Add('                          STR_TO_DATE(CONCAT(YEAR(:DTAINI) ,"-", MONTH(:DTAINI) ,"-",');
      Add('     IF(CLI_INICIC > DAY(LAST_DAY(');
      Add('                                                     STR_TO_DATE(CONCAT(YEAR(:DTAINI) ,"-",  ');
      Add('                                                                        MONTH(:DTAINI) ,"-",');
      Add('                                                                        1),');
      Add('                                                                 "%Y-%m-%d")');
      Add('                                                             )');
      Add('                                                    ),');
      Add('                                   DAY (LAST_DAY(');
      Add('                                                   STR_TO_DATE(CONCAT(YEAR(:DTAINI) ,"-",');
      Add('                                                                      MONTH(:DTAINI) ,"-",');
      Add('                                                                      1),');
      Add('                                                                "%Y-%m-%d")');
      Add('                                                  )');
      Add('                                    ),');
      Add('                                 CLI_INICIC)');
      Add('      ),');
      Add('                                      "%Y-%m-%d")) + 1) / IF(CLI_INTERV > 0, CLI_INTERV, 1 ) ) , 0)) ');
      Add('FROM       ');
      Add(' CADCLI    ');
      Add('WHERE      ');
      Add('  CLI_INICIC > 0 AND ');
      Add('  CLI_INTERV > 0 ');

      If Not fEmptyStr(edtCodCliente.Text) Then
        Add('  AND CLI_CODCLI = ' + QuotedStr(edtCodCliente.Text) + ' ');

      If Not fEmptyStr(edtCodAti.Text) Then
        Add('  AND CLI_CODATI = ' + QuotedStr(edtCodAti.Text) + ' ');

      ParamByName('DTAINI').AsDate   := StrToDate(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDate   := StrToDate(mskDtaFin.Text);

      Open;
      If Not IsEmpty Then
        intIntevalos := Fields[0].AsInteger + 1;
      Result := TRUE;
    End;
  Except
    On E : Exception Do
    Begin
			pMensagensErro(E.Message,'[TfrmGeraAgendaCiclicoComDia.fGetNroIntevalosComDia]');
      Result := False;
    End;
  End;
  FreeAndNil(qryGen);
End;

Function TfrmGeraAgendaCiclicoComDia.fGetNroIntevalosContinuo(var intIntevalos: Integer): Boolean;
  Var
    qryGen: TUniQuery;
Begin
  intIntevalos := 0;
  Try
    qryGen := fCriaQuery;
    With qryGen, Sql Do
    Begin
      Clear;
      Add('SELECT                                                 ');
      Add(' TRUNCATE( (DATEDIFF(:DTAFIN,:DTAINI) + 1) /           ');
      Add('           (SELECT                                     ');
      Add('              MIN(IF(CLI_INTERV > 0, CLI_INTERV, 1 ))  ');
      Add('            FROM                                       ');
      Add('              CADCLI                                   ');
      Add('            WHERE                                      ');

      If Not fEmptyStr(edtCodCliente.Text) Then
        Add(' CLI_CODCLI = ' + QuotedStr(edtCodCliente.Text) + ' AND ');

      If Not fEmptyStr(edtCodAti.Text) Then
        Add(' CLI_CODATI = ' + QuotedStr(edtCodAti.Text) + ' AND ');

      Add('              CLI_INTERV > 0)                          ');
      Add('            ,0)                                        ');

      ParamByName('DTAINI').AsDate   := StrToDate(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDate   := StrToDate(mskDtaFin.Text);

      Open;

      If Not IsEmpty Then
        intIntevalos := Fields[0].AsInteger + 1;

      Result := TRUE;
    End;
  Except
    On E : Exception Do
    Begin
			pMensagensErro(E.Message,'[TfrmGeraAgendaCiclicoComDia.fGetNroIntevalosContinuo]');
      Result := False;
    End;
  End;
  FreeAndNil(qryGen);
End;

Function TfrmGeraAgendaCiclicoComDia.fGeraPeriodoComDia(intNroIntervalo: Integer; Var intIncluidos: Integer): Boolean;
  Var
    qryGen, qryIns: TUniQuery;
Begin

  Result := TRUE;

  Try
    qryGen := fCriaQuery;
    With qryGen, Sql Do
    Begin
      ParamCheck := False;
      Close;
      Clear;

      {Add('INSERT INTO AGETEL');}
      Add('  SELECT');
      Add('    CONCAT(RIGHT(CONCAT("00000000000000000",@INCREMENTO:=@INCREMENTO+1),17),' + QuotedStr(VS_strCodEmp) + ') AS AUTOINCREM,');
      Add(QuotedStr(VS_strCodEmp) + ',');
      Add('    CLI_CODVEN,');
      Add('    CLI_CODCLI,');
      Add('    DATE_ADD(STR_TO_DATE(CONCAT(YEAR(@DTAINI) ,"-",');
      Add('                                MONTH(@DTAINI) ,"-",');
      Add('                                IF(CLI_INICIC > DAY(LAST_DAY(');
      Add('                                                      STR_TO_DATE(CONCAT(YEAR(@DTAINI) ,"-",');
      Add('                                                                          MONTH(@DTAINI) ,"-",');
      Add('                                                                          1),');
      Add('                                                                   "%Y-%m-%d")');
      Add('                                                               )');
      Add('                                                      ),');
      Add('                                     DAY (LAST_DAY(');
      Add('                                                     STR_TO_DATE(CONCAT(YEAR(@DTAINI) ,"-",');
      Add('                                                                        MONTH(@DTAINI) ,"-",');
      Add('                                                                        1),');
      Add('                                                                  "%Y-%m-%d")');
      Add('                                                    )');
      Add('                                      ),');
      Add('                                   CLI_INICIC)),');
      Add('                           "%Y-%m-%d"),');
      Add('             INTERVAL CLI_INTERV * ' + IntToStr(intNroIntervalo) + ' DAY) AS DATA,');
      Add('     NULL, ');
      Add('     NULL, ');
      Add('     NULL, ');
      Add('     NULL, ');
      Add('     NULL  ');
      Add('FROM       ');
      Add('  CADCLI    ');
      Add('  INNER JOIN CADOPE ON OPE_CODOPE = CLI_CODVEN  ');
      Add('WHERE      ');
      Add('  CLI_CODVEN IS NOT NULL AND ');
      Add('  CLI_CODVEN <> ""       AND ');
      Add('  CLI_INICIC > 0         AND ');
      Add('  CLI_INTERV > 0             ');

      If Not fEmptyStr(edtCodCliente.Text) Then
        Add(' AND CLI_CODCLI = ' + QuotedStr(edtCodCliente.Text) + '  ');

      If Not fEmptyStr(edtCodAti.Text) Then
        Add(' AND CLI_CODATI = ' + QuotedStr(edtCodAti.Text) + '  ');

      Add('HAVING DATA BETWEEN @DTAINI AND @DTAFIN ');

      {ExecSQL;}
      Open;

      If Not IsEmpty Then
      Begin

        qryIns := fCriaQuery;

        Try

          Try

            fStartTransaction;

            First;
            While Not Eof Do
            Begin

              qryIns.Close;
              qryIns.SQL.Clear;
              qryIns.SQL.Add('INSERT INTO AGETEL');
              qryIns.SQL.Add('(AUTOINCREM, AGE_CODEMP, AGE_CODVEN, AGE_CODCLI, AGE_DTAAGE)');
              qryIns.SQL.Add('VALUES');
              qryIns.SQL.Add('(:AUTOINCREM, :AGE_CODEMP, :AGE_CODVEN, :AGE_CODCLI, :AGE_DTAAGE)');

              qryIns.ParamByName('AUTOINCREM').AsString := FieldByName('AUTOINCREM').AsString;
              qryIns.ParamByName('AGE_CODEMP').AsString := VS_strCodEmp;
              qryIns.ParamByName('AGE_CODVEN').AsString := FieldByName('CLI_CODVEN').AsString;
              qryIns.ParamByName('AGE_CODCLI').AsString := FieldByName('CLI_CODCLI').AsString;
              qryIns.ParamByName('AGE_DTAAGE').AsDate   := FieldByName('DATA').AsDateTime;

              qryIns.ExecSQL;

              Next;

            End;

            fCommit;

          Except
            On E: Exception Do
            Begin
              fRollBack;
              Result := FALSE;
              pMensagensErro(E.Message, '[TfrmGeraAgendaCiclicoComDia.fGeraPeriodoComDia]');
            End;
          End;

        Finally
          FreeAndNil(qryIns);
        End;

      End;

      inc(intIncluidos, RecordCount);

    End;

  Except
    On E : Exception Do
    Begin
			pMensagensErro(E.Message,'[TfrmGeraAgendaCiclicoComDia.fGeraPeriodoComDia]');
      Result := FALSE;
    End;
  End;
  FreeAndNil(qryGen);
End;

Function TfrmGeraAgendaCiclicoComDia.fGeraPeriodoContinuo(intNroIntervalo: Integer; Var intIncluidos: Integer): Boolean;
  Var
    qryGen: TUniQuery;
    cdsGen: TUniClientDataSet;
    dspGen: TUniDataSetProvider;
    strSQL: String;
    intCont: Integer;
    dteData: TDateTime;
Begin
  Try
    qryGen := fCriaQuery(Self);
    dspGen := TUniDataSetProvider.Create(Self);
    cdsGen := TUniClientDataSet.Create(Self);

    dspGen.DataSet := qryGen;
    cdsGen.SetProvider(dspGen);

    {*****************************************}
    {* CARREGANDO OS CLIENTES QUE SERAO      *}
    {* CADASTRADOS PARA ATENDIMENTOS FUTUROS *}
    {**************************************AN*}
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  CLI_CODVEN, ';
    strSQL := strSQL + '  CLI_CODCLI, ';
    strSQL := strSQL + '  CLI_INTERV  ';
    strSQL := strSQL + 'FROM     ';
    strSQL := strSQL + '  CADCLI ';
    strSQL := strSQL + 'WHERE    ';
    strSQL := strSQL + '  CLI_CODVEN IS NOT NULL AND ';
    strSQL := strSQL + '  CLI_CODVEN <> "" AND       ';
    strSQL := strSQL + '  CLI_INTERV > 0             ';

    If Not fEmptyStr(edtCodCliente.Text) Then
      strSQL := strSQL + '  AND CLI_CODCLI = ' + QuotedStr(edtCodCliente.Text);

    If Not fEmptyStr(edtCodAti.Text) Then
      strSQL := strSQL + '  AND CLI_CODATI = ' + QuotedStr(edtCodAti.Text);

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      Open;

      cdsGen.Open;
      cdsGen.SetProvider(nil);
      dspGen.DataSet := nil;

      {*************************************}
      {* INSERINDO OS CLIENTES QUE POSSUEM *}
      {* ATENDIMENTO FUTURO                *}
      {**********************************AN*}
      Close;
      SQL.Clear;
      SQL.Add('SELECT * FROM AGETEL WHERE FALSE');
      Open;

      intCont := 0;
      cdsGen.First;
      While Not cdsGen.Eof Do
      Begin
        If qryAgeTmp.Locate('TMP_CODCLI', cdsGen.FieldbyName('CLI_CODCLI').AsString, []) Then
        Begin
          dteData := qryAgeTmp.FieldByName('TMP_DTAAGE').AsDateTime +
                     (cdsGen.FieldByName('CLI_INTERV').AsInteger * intNroIntervalo);

          If (dteData >= StrToDate(mskDtaIni.Text)) And (dteData <= StrToDate(mskDtaFin.Text)) Then
          Begin
            Insert;
            FieldByName('AUTOINCREM').Value := fRetAutoIncrem('AGETEL', VS_strCodEmp);
            FieldByName('AGE_CODEMP').Value := VS_strCodEmp;
            FieldByName('AGE_CODVEN').Value := cdsGen.FieldByName('CLI_CODVEN').AsString;
            FieldByName('AGE_CODCLI').Value := cdsGen.FieldByName('CLI_CODCLI').AsString;
            FieldByName('AGE_DTAAGE').Value := dteData;
            FieldByName('AGE_DTABAI').Value := null;
            FieldByName('AGE_HORBAI').Value := null;
            FieldByName('AGE_OBSERV').Value := null;
            Post;
            Inc(intCont);
          End;
        End;

        Application.ProcessMessages;
        cdsGen.Next;
      End;

      Close; //qryGen
    End;

    Result := TRUE;
    Inc(intIncluidos, intCont);
  Except
    On E : Exception Do
    Begin
			pMensagensErro(E.Message,'[TfrmGeraAgendaCiclicoComDia.fGeraPeriodoContinuo]');
      Result := False;
    End;
  End;

  FreeAndNil(qryGen);
  FreeAndNil(dspGen);
  FreeAndNil(cdsGen);
End;

Function TfrmGeraAgendaCiclicoComDia.fSetaAutoInc: Boolean;
  Var
    qryGen: TUniQuery;
Begin
  Try
    qryGen := fCriaQuery;
    With qryGen, Sql Do
    Begin
      Close;
      Clear;
      Add('SET @INCREMENTO=(SELECT IFNULL(CAST( LEFT(MAX(AUTOINCREM),17) AS UNSIGNED),0) AS AUTO FROM AGETEL)');
      ExecSQL;

      If tagTipAge = taAutomatico Then
      Begin

        Close;
        Clear;
        Add('SET @DTAINI=:DTAINI');
        ParamByName('DTAINI').AsDate    := Date;
        ExecSQL;

      End Else
      Begin

        Close;
        Clear;
        Add('SET @DTAINI=:DTAINI');
        ParamByName('DTAINI').AsDate    := StrToDate(mskDtaIni.Text);
        ExecSQL;

        Close;
        Clear;
        Add('SET @DTAFIN=:DTAFIN');
        ParamByName('DTAFIN').AsDate    := StrToDate(mskDtaFin.Text);
        ExecSQL;

      End;

      Result := TRUE;
    End;
  Except
    On E : Exception Do
    Begin
			pMensagensErro(E.Message,'[TfrmGeraAgendaCiclicoComDia.fSetaAutoInc]');
      Result := False;
    End;
  End;
  FreeAndNil(qryGen);
End;

Function TfrmGeraAgendaCiclicoComDia.fGeraAutomatico(Var intIncluidos: Integer): Boolean;
  Var
    qryGen, qryIns: TUniQuery;
Begin

  Result := TRUE;

  Try
    qryGen := fCriaQuery;
    With qryGen, Sql Do
    Begin
      ParamCheck := False;
      Close;
      Clear;

      {Add('INSERT INTO AGETEL');}
      Add('  SELECT');
      Add('    CONCAT(RIGHT(CONCAT("00000000000000000",@INCREMENTO:=@INCREMENTO+1),17),' + QuotedStr(VS_strCodEmp) + ') AS AUTOINCREM,');
      Add(QuotedStr(VS_strCodEmp) + ',');
      Add('    CLI_CODVEN,');
      Add('    CLI_CODCLI,');
      Add('    STR_TO_DATE(CONCAT(YEAR(@DTAINI) ,"-",');
      Add('                       MONTH(@DTAINI) ,"-",');
      Add('                       IF(IF((CLI_INICIC IS NULL) OR (CLI_INICIC = 0), DAY(@DTAINI) ,CLI_INICIC) > DAY(LAST_DAY(');
      Add('                                                    STR_TO_DATE(CONCAT(YEAR(@DTAINI) ,"-",');
      Add('                                                                       MONTH(@DTAINI) ,"-",');
      Add('                                                                       1),');
      Add('                                                                "%Y-%m-%d")');
      Add('                                                    )');
      Add('                                           ),');
      Add('                          DAY (LAST_DAY(');
      Add('                                        STR_TO_DATE(CONCAT(YEAR(@DTAINI) ,"-",');
      Add('                                                           MONTH(@DTAINI) ,"-",');
      Add('                                                           1),');
      Add('                                                    "%Y-%m-%d")');
      Add('                                        )');
      Add('                               ),');
      Add('                          IF((CLI_INICIC IS NULL) OR (CLI_INICIC = 0), DAY(@DTAINI) ,CLI_INICIC))),');
      Add('                "%Y-%m-%d") AS DATA,');
      Add('     NULL, ');
      Add('     NULL, ');
      Add('     NULL, ');
      Add('     NULL, ');
      Add('     NULL  ');
      Add('FROM       ');
      Add('  CADCLI    ');
      Add('  INNER JOIN CADOPE ON OPE_CODOPE = CLI_CODVEN  ');
      Add('WHERE      ');
      Add('  CLI_CODVEN IS NOT NULL AND ');
      Add('  CLI_CODVEN <> ""       AND ');
      Add('  CLI_INTERV > 0             ');

      If Not fEmptyStr(edtCodCliente.Text) Then
        Add('  AND CLI_CODCLI = ' + QuotedStr(edtCodCliente.Text) + ' ');

      If Not fEmptyStr(edtCodAti.Text) Then
        Add(' AND CLI_CODATI = ' + QuotedStr(edtCodAti.Text) + ' ');

      {ExecSQL;}
      Open;

      If Not IsEmpty Then
      Begin

        qryIns := fCriaQuery;

        Try

          Try

            fStartTransaction;

            First;
            While Not Eof Do
            Begin

              qryIns.Close;
              qryIns.SQL.Clear;
              qryIns.SQL.Add('INSERT INTO AGETEL');
              qryIns.SQL.Add('(AUTOINCREM, AGE_CODEMP, AGE_CODVEN, AGE_CODCLI, AGE_DTAAGE)');
              qryIns.SQL.Add('VALUES');
              qryIns.SQL.Add('(:AUTOINCREM, :AGE_CODEMP, :AGE_CODVEN, :AGE_CODCLI, :AGE_DTAAGE)');

              qryIns.ParamByName('AUTOINCREM').AsString := FieldByName('AUTOINCREM').AsString;
              qryIns.ParamByName('AGE_CODEMP').AsString := VS_strCodEmp;
              qryIns.ParamByName('AGE_CODVEN').AsString := FieldByName('CLI_CODVEN').AsString;
              qryIns.ParamByName('AGE_CODCLI').AsString := FieldByName('CLI_CODCLI').AsString;
              qryIns.ParamByName('AGE_DTAAGE').AsDate   := FieldByName('DATA').AsDateTime;

              qryIns.ExecSQL;

              Next;

            End;

            fCommit;

          Except
            On E: Exception Do
            Begin
              fRollBack;
              Result := FALSE;
              pMensagensErro(E.Message, '[TfrmGeraAgendaCiclicoComDia.fGeraAutomatico]');
            End;
          End;

        Finally
          FreeAndNil(qryIns);
        End;

      End;

      inc(intIncluidos,RecordCount);

    End;

  Except
    On E : Exception Do
    Begin
			pMensagensErro(E.Message,'[TfrmGeraAgendaCiclicoComDia.fGeraAutomatico]');
      Result := FALSE;
    End;
  End;
  
  FreeAndNil(qryGen);
End;

Function TfrmGeraAgendaCiclicoComDia.fGeraAgendamento(intIntervalos: Integer): Boolean;
  Var
    intIndex,
    intIncluidos: Integer;
Begin
  Result := True;

  pgbAge.Position := 0;
  pgbAge.Max      := intIntervalos;
  intIncluidos    := 0;

  For intIndex := 0 To intIntervalos - 1 Do
  Begin

    Case tagTipAge Of
      taDiaInicio : If Not fGeraPeriodoComDia(intIndex,intIncluidos) Then
                    Begin
                      Result := False;
                      Break;
                    End;
      taContinuo :  If Not fGeraPeriodoContinuo(Succ(intIndex),intIncluidos) Then
                    Begin
                      Result := False;
                      Break;
                    End;
      taAutomatico: If Not fGeraAutomatico(intIncluidos) Then
                    Begin
                      Result := False;
                      Break;
                    End;
    End;

    pgbAge.StepBy(1);
    pgbAge.Refresh;
    Application.ProcessMessages;
  End;

  pgbAge.Position := 0;

  If Result Then
  Begin
    fMensagem('', 'Agendamento gerado com sucesso. ' +
                  IIF(tagTipAge <> taAutomatico,'Registros incluidos: ' + IntToStr(intIncluidos) + '.',''), ['&O k']);
    Close;              
  End;                
End;

Function TfrmGeraAgendaCiclicoComDia.fApagaAbertosNoPeriodo: Boolean;
  Var
    qryGen: TUniQuery;
Begin
  Try
    qryGen := fCriaQuery;
    With qryGen, Sql Do
    Begin

      Close;
      Clear;
      Add('DELETE FROM AGETEL');
      Add('WHERE ');
      Add('  AGE_CODEMP = :CODEMP AND                   ');

      If Not fEmptyStr(edtCodCliente.Text) Then
        Add('  AGE_CODCLI = ' + QuotedStr(edtCodCliente.Text) + ' AND ');

      If Not fEmptyStr(edtCodAti.Text) Then
        Add('  EXISTS(SELECT CLI_CODCLI FROM CADCLI WHERE CLI_CODCLI = AGE_CODCLI AND CLI_CODATI = ' + QuotedStr(edtCodAti.Text) + ') AND ');

      if tagTipAge <> taAutomatico Then
        Add('  AGE_DTAAGE  >= :DTAINI AND ');

      Add('  AGE_DTABAI IS NULL           ');

      ParamByName('CODEMP').AsString := VS_strCodEmp;

      if tagTipAge <> taAutomatico Then
        ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);

      ExecSQL;

      Result := TRUE;

    End;
    
  Except
    On E : Exception Do
    Begin
			pMensagensErro(E.Message,'[TfrmGeraAgendaCiclicoComDia.fApagaAbertosNoPeriodo]');
      Result := False;
    End;
  End;
  FreeAndNil(qryGen);
End;

Function TfrmGeraAgendaCiclicoComDia.fGeraDatasDeInicio: Boolean;
Begin
  Try
    {************************************}
    {* CARREGANDO OS CLIENTE E ULTIMAS  *}
    {* DATAS DE ATENDIMENTOS REALIZADOS *}
    {*********************************AN*}
    With qryAgeTmp, SQL Do
    Begin
      Close;
      Clear;
      Add('SELECT');
      Add('  CLI_CODCLI AS TMP_CODCLI,');
      Add('  CONVERT(IFNULL(MAX(AGE_DTAAGE), DATE_SUB(:DTAINI, INTERVAL CLI_INTERV DAY)), DATE) AS TMP_DTAAGE');
      Add('FROM');
      Add('  CADCLI');
      Add('  LEFT JOIN AGETEL ON');
      Add('    AGE_CODEMP = :CODEMP AND');
      Add('    AGE_CODCLI = CLI_CODCLI ');
      Add('WHERE');
      Add('  CLI_INTERV > 0 AND');
      Add('  CLI_CODVEN IS NOT NULL AND');
      Add('  CLI_CODVEN <> ""');

      If Not fEmptyStr(edtCodCliente.Text) Then
        Add('  AND CLI_CODCLI = ' + QuotedStr(edtCodCliente.Text));

      If Not fEmptyStr(edtCodAti.Text) Then
        Add('  AND CLI_CODATI = ' + QuotedStr(edtCodAti.Text));

      Add('GROUP BY ');
      Add('  CLI_CODCLI');

      ParamByName('CODEMP').AsString := VS_strCodEmp;
      ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);

      Open;
      Result := True;
    End;
  Except
    On E : Exception Do
    Begin
      Result := False;
			pMensagensErro(E.Message,'[TfrmGeraAgendaCiclicoComDia.fGeraDatasDeInicio]');
    End;
  End;
End;

function TfrmGeraAgendaCiclicoComDia.fGravaAutoAgeTel: Boolean;
  Var
    qryGen: TUniQuery;
Begin
  Try
    qryGen := fCriaQuery;
    With qryGen, Sql Do
    Begin
      Close;
      Clear;
      Add('SELECT IFNULL(CAST( LEFT(MAX(AUTOINCREM),17) AS UNSIGNED),0) AS AUTO FROM AGETEL');
      Open;

      fGravaAutoIncrem('AGETEL',Succ(Fields[0].AsInteger));

      Result := TRUE;
    End;
  Except
    On E : Exception Do
    Begin
			pMensagensErro(E.Message,'[TfrmGeraAgendaCiclicoComDia.fGravaAutoAgeTel]');
      Result := False;
    End;
  End;
  FreeAndNil(qryGen);
End;

procedure TfrmGeraAgendaCiclicoComDia.btnGerarClick(
  Sender: TObject);
  Var
    intIntervalos: Integer;
begin
  inherited;

  if fVerificaCampos Then
  Begin

    Case tagTipAge Of
      taDiaInicio : if Not fGetNroIntevalosComDia(intIntervalos) Then
                      Exit;
      taContinuo  : if Not fGetNroIntevalosContinuo(intIntervalos) Then
                      Exit;
      taAutomatico: intIntervalos := 1;
    End;

    If Not fSetaAutoInc Then
      Exit;

    {*****************************************}
    {* TRAVA A ROTINA                        *}
    {**************************************LA*}
    If Not fLock_Unlock('AGENDAMENTO_TEL', True, False ) Then
    Begin
      Screen.Cursor := crDefault;
      fMensagem('', 'Essa rotina está sendo executada em Outra Estação por ' +
                     fGetHostLock('AGENDAMENTO_TEL') + '!', ['&Ok']);
    End Else
    Begin

      Case tagTipAge Of
        taDiaInicio,
        taAutomatico: Begin
                        if fApagaAbertosNoPeriodo And fGeraAgendamento(intIntervalos) Then
                          fGravaAutoAgeTel;
                      End;
        taContinuo  : Begin
                        If fApagaAbertosNoPeriodo And fGeraDatasDeInicio And fGeraAgendamento(intIntervalos) Then
                          fGravaAutoAgeTel;
                      End;
      End;

      {*****************************************}
      {* DESTRAVA A ROTINA                     *}
      {**************************************LA*}
      fLock_Unlock('AGENDAMENTO_TEL', False, False );
    End;

  End;

end;

procedure TfrmGeraAgendaCiclicoComDia.FormCreate(Sender: TObject);
begin
  inherited;
  qryAgeTmp := fCriaQuery(Self);
end;

procedure TfrmGeraAgendaCiclicoComDia.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_F10   : btnGerar.Click;
    VK_ESCAPE: Close;
  End;
end;

procedure TfrmGeraAgendaCiclicoComDia.FormShow(Sender: TObject);
begin
  inherited;

  Case tagTipAge Of
    taDiaInicio  : Caption := 'Agendamento cíclico com dia de início do ciclo';
    taContinuo   : Caption := 'Agendamento cíclico contínuo';
    taAutomatico : Caption := 'Agendamento automático';
  End;

  If tagTipAge = taAutomatico Then
  Begin
    pnlPeriodo.Visible := FALSE;
    Self.ClientHeight  := Self.ClientHeight - pnlPeriodo.Height;
  End Else
  Begin
    pnlAgeAut.Visible := FALSE;
    Self.ClientHeight  := Self.ClientHeight - pnlAgeAut.Height;
  End;

end;

procedure TfrmGeraAgendaCiclicoComDia.ApplicationEventsException(
  Sender: TObject; E: Exception);
begin
  inherited;

  If Pos(Uppercase('is not a valid date'),Uppercase(E.Message)) > 0 Then
    fMensagem('', 'Data inválida.', ['&O k'])
  Else
    fMensagem('', E.Message, ['&O k']);
  
end;

procedure TfrmGeraAgendaCiclicoComDia.edtCodClienteKeyPress(
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

procedure TfrmGeraAgendaCiclicoComDia.edtCodClienteExit(Sender: TObject);
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

procedure TfrmGeraAgendaCiclicoComDia.pCarregaCliente(Var qryCadCli: TUniQuery);
Begin
  If Not (fEmptyStr(edtCodCliente.Text)) Then
    edtDesCliente.Text := qryCadCli.FieldByName('CLI_NOMCLI').AsString
  Else
    edtDesCliente.Text := '';
End;


procedure TfrmGeraAgendaCiclicoComDia.edtCodAtiKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrAtiv: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE ATIVIDADES *}
  {****************************RV*}
  If fPesqAtividade(Self, edtCodAti, edtDesAti, Nil, Key, arrAtiv) Then
  Begin
    If fValidaCampos(edtCodAti, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

end.

