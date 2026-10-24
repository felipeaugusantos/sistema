unit untAltEfetivacaoPrecos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, ComCtrls, ImgList,
  DB, UniClientDataSet, AppEvnts, Uni,
  frxClass, BitBtnLockedIncrem, frxExportCSVTestabilidade,untPreAlt_Trigger, Dateutils, Math,
  untAltEfetivacaoManut, System.ImageList, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxProgressBar;

type
  TfrmAltEfetivacaoPrecos = class(TfrmPai)
    lsvDtaDis: TListView;
    ImageList1: TImageList;
    frxDBImpEti: TfrxUserDataSet;
    btnConfirma: TBitBtnLocked;
    btnImprimir: TBitBtnLocked;
    btnCancel: TBitBtnLocked;
    btnAltDat: TBitBtnLocked;
    lblTot: TLabel;
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure lsvDtaDisDblClick(Sender: TObject);
    procedure lsvDtaDisKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    function fGravaPrecosPrg(pgbBarra: TcxProgressBar = Nil): Boolean;
    function fGravaPrecos: Boolean;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnImprimirClick(Sender: TObject);
    procedure frxDBImpEtiGetValue(const VarName: string; var Value: Variant);
    procedure frxDBImpEtiCheckEOF(Sender: TObject; var Eof: Boolean);
    procedure frxDBImpEtiFirst(Sender: TObject);
    procedure frxDBImpEtiNext(Sender: TObject);
    procedure frxDBImpEtiPrior(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnAltDatClick(Sender: TObject);
  private
    { Private declarations }
    blnInfMat: Boolean;
    intInfFed,
    intInfOpe,
    intInfSai: Integer;

    qryPreAlt: TUniQuery;
    IntQtdEti: Integer;
    intPreTab: Integer;
    cdsItens: TUniClientDataSet;
    strAgrupadorPreAlt: String;

    FdtaData: TDateTime;
    FblnResFor: Boolean;
    qryComand: TUniQuery;

    procedure pAbreConsulta;
    function  fApagaPreIte(dtaDtaPre: TDate; strCodEmp: String): Boolean;
    function  fRetSQLItens(blnCodFor: Boolean): String;
    procedure pSetaParametrosItens(Var qryGenIte: TUniQuery; dtaData: TDate; strCodEmp: String);
    function fRetornaDocumentosRelacionados(dtaDataPRE: TDate): String;

    procedure pAlteraDataEfetivacao(dtaDtaPre: TDateTime);
    procedure pAtualizaPreIte(blnResFor: Boolean; strAutInc: String);
    function fTrataTextoTempo(segundos: Integer): String;
    function fApagaReservaEnderecamento(AStrSeqPre, AStrCodIte, AStrCodEmp: String): boolean;


  public
      function fConfirmaEfetivacaoPreco(dtaDtaPre: TDate): Boolean;

    { Public declarations }
  end;

var
  frmAltEfetivacaoPrecos: TfrmAltEfetivacaoPrecos;

implementation

uses untFuncoesSimples, untEntEtiquetas, untPreAlt, untFuncoesAuxiliares,
     untAltDataEfetivacao, untTCalculaVariacaoPreco, untGravando;

{$R *.dfm}

procedure TfrmAltEfetivacaoPrecos.btnImprimirClick(Sender: TObject);
  Var
    lsiItem: TListItem;
begin
  inherited;

  Try
    lsiItem := nil;

    If lsvDtaDis.SelCount > 0 Then
      lsiItem := lsvDtaDis.ItemFocused
    Else
      fMensagem('Informação','Nenhuma data foi selecionada',['&OK']);

    If Not Assigned(lsiItem) Then
      Exit;

    TfrmEntEtiquetas.pImpEtiAtivacaoLotePreco( StrToDate(lsiItem.Caption) );

  Except

    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmEntEtiquetas.btnImprimirClick]');
    End;

  End;

end;

function TfrmAltEfetivacaoPrecos.fApagaPreIte(dtaDtaPre: TDate;
  strCodEmp: String): Boolean;
Var
  qryGenIte: TUniQuery;
begin
  Result := False;

  Try

    qryGenIte := fCriaQuery(Self);

    With qryGenIte Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(fRetSQLItens(False));
      pSetaParametrosItens(qryGenIte, dtaDtaPre, strCodEmp);
      Open;
      First;

      While Not Eof Do
      Begin
        fStartTransaction;
        Try
          fVerificaIntegridade(Self.Name,'PREITE', qryGenIte, True, False);
          lblTot.Caption := IntToStr(qryGenIte.RecordCount) + '/' + IntToStr(qryGenIte.RecNo);
          Application.ProcessMessages;
          Next;
          fCommit;
        Except
          on e: Exception do
          Begin
            fRollback;
            raise e;
          End;
        End
      End;

    End;

    fStartTransaction;
    With qryGenIte Do
    Begin
      SQL.Clear;
      SQL.Add('DELETE FROM ');
      SQL.Add('  PREITE    ');
      SQL.Add('WHERE ');
      SQL.Add('  PRE_DTAPRE = :DTAPRE AND ');
      SQL.Add('  PRE_CODEMP = :CODEMP     ');

      ParamByName('DTAPRE').AsDateTime := dtaDtaPre;
      ParamByName('CODEMP').AsString   := strCodEmp;

      ExecSQL;

      Result := True;
    End;
    fCommit;

  Finally
    FreeAndNil(qryGenIte);
  End;
end;

function TfrmAltEfetivacaoPrecos.fApagaReservaEnderecamento(AStrSeqPre,
  AStrCodIte, AStrCodEmp: String): boolean;
var
  lAutIncFatDor, lAutIncFatgor: string;
begin
  Result := True;

  Try
    QryComand.SQL.Clear;

    QryComand.SQL.Add('SELECT FATDOR.AUTOINCREM AS INCDOR, FATGOR.AUTOINCREM AS INCGOR FROM FATGOR ');
    QryComand.SQL.Add(' INNER JOIN FATDOR ON FATGOR.AUTOINCREM = FATDOR.FDO_SEQGER ');
    QryComand.SQL.Add(' INNER JOIN EXTDOR ON FDO_SEQFDO = FATDOR.AUTOINCREM ');
    QryComand.SQL.Add(' WHERE FDO_SEQPRE = ' + QuotedStr(AStrSeqPre));
    QryComand.Open;

    If QryComand.IsEmpty Then
      Exit;

    lAutIncFatgor  := QryComand.FieldByName('INCGOR').AsString;
    lAutIncFatDor  := QryComand.FieldByName('INCDOR').AsString;


    QryComand.sql.Clear;
    QryComand.sql.Add('DELETE FROM FATDOR WHERE AUTOINCREM = ' + QuotedStr(lAutIncFatDor) + ';');
    QryComand.sql.Add('DELETE FROM FATGOR');
    QryComand.sql.Add(' WHERE FATGOR.AUTOINCREM =  "'+lAutIncFatgor+'"');
    QryComand.sql.Add('   AND (SELECT COUNT(1) FROM FATDOR WHERE AUTOINCREM = "' + lAutIncFatDor + '") = 0;');
    QryComand.ExecSQL;

    QryComand.SQL.Clear;
    QryComand.SQL.Add('UPDATE ITEGER SET ITE_REPAUD = "S" WHERE ITE_CODITE = :CODITE AND ITE_CODEMP = :CODEMP');
    QryComand.ParamByName('CODITE').AsString := AStrCodIte;
    QryComand.ParamByName('CODEMP').AsString := AStrCodEmp;
    QryComand.ExecSQL;

  Except On
    E:Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TfrmAltEfetivacaoPrecos.fApagaReservaEnderecamento]');
    End;
  End;
end;

function TfrmAltEfetivacaoPrecos.fConfirmaEfetivacaoPreco(
  dtaDtaPre: TDate): Boolean;

  var qryTrava: TUniQuery;
      objCalculaVariacaoPreco: TCalculaVariacaoPreco;

begin
  Try
    objCalculaVariacaoPreco := TCalculaVariacaoPreco.Create;
    Try
      If  objCalculaVariacaoPreco.blnBloqueia then
      Begin
        objCalculaVariacaoPreco.strNewFieldPreve := 'PRE_PREVE';
        qryTrava := fCriaQuery;
        Try
          qryTrava.SQL.Add(fRetSQLItens(True));
          pSetaParametrosItens(qryTrava, dtaDtaPre, VS_strCodEmp);

          qryTrava.Open;

          If Not objCalculaVariacaoPreco.fTravaPrecosForaPermitido(qryTrava) Then
            Exit(False);
        Finally
          FreeAndNil(qryTrava);
        End;

      End;
    Finally
      FreeAndNil(objCalculaVariacaoPreco);
    End;



//    fStartTransaction;
    strAgrupadorPreAlt := '';

    FdtaData  := dtaDtaPre;
    FblnResFor := False;


    Result := fGravaPrecos();

    If fCfgSis('INFMAT', varBoolean) Then
    Begin
      FblnResFor := True;
      Result := Result And fGravaPrecos();
    End;

    {*****************************************}
    {* APAGA OS REGISTROS DA TABELA PREITE Q *}
    {* JÁ FORAM ATUALIZADOS NA TABELA ITEGER *}
    {**************************************ER*}
    Result := Result And fApagaPreIte(dtaDtaPre, VS_strCodEmp);
{    If (Result) Then
      fCommit
    Else
      fRollBack;     }
    strAgrupadorPreAlt := '';

  Except
    on E: Exception do
    Begin
//      fRollBack;
      strAgrupadorPreAlt := '';
      pMensagensErro(E.Message, 'TfrmAltEfetivacaoPrecos.fConfirmaEfetivacaoPreco');
      Result := False;
    End;
  End;
end;

function TfrmAltEfetivacaoPrecos.fGravaPrecos: Boolean;
  var frmEsperaGravando: TfrmGravando;
begin
  pCriarFormularios(TfrmGravando, frmEsperaGravando);
  Try
    If FblnResFor Then
      frmEsperaGravando.lblGravando.Caption := 'Efetivando os preços dos itens onde empresa é resposavel pelo fornecedor.'
    Else
      frmEsperaGravando.lblGravando.Caption := 'Efetivando os preços dos itens.';

    frmEsperaGravando.fExecutarAcao := fGravaPrecosPrg;
    frmEsperaGravando.ShowModal;

    Result := frmEsperaGravando.blnConfirma;
  Finally
    FreeAndNil(frmEsperaGravando)
  End;

end;

function TfrmAltEfetivacaoPrecos.fGravaPrecosPrg(pgbBarra: TcxProgressBar = Nil): Boolean;
  Var
    qryAtuIte,
    qryGenIte  : TUniQuery;
    qryGenIt2  : TUniQuery;
    strEmpresas: String;
    blnIteTbp : Boolean;
    intContador: Integer;
    blnMarIde: Boolean;
    qtdSegundos: integer;
    ValidacoesPorSegundo: dOUBLE;
    horIni: TTime;
    TempoExtimado: String;
    qtdProcess: integer;
begin

  blnIteTbp := fCfgSis('ITETBP', varBoolean);
  blnMarIde := fCfgSis('MARIDE', varBoolean);

  qryGenIte := fCriaQuery(Self);
  qryGenIt2 := fCriaQuery(Self);
  qryAtuIte := fCriaQuery(Self);

  Screen.Cursor := crSQLWait;

  Result := True;

  {**********************************}
  {* PEGA AS EMPRESAS COM PREMAT    *}
  {*******************************JB*}
  strEmpresas := fRetEmpresasUsamPrecoMatriz;
    qtdProcess := 0;

  With qryGenIte Do
  Begin
    SQL.Clear;
    SQL.Add(fRetSQLItens(True));
    pSetaParametrosItens(qryGenIte, FdtaData, VS_strCodEmp);
    Open;
    pgbBarra.Properties.Max      := RecordCount;
    pgbBarra.Position := 0;

    pPreAltDefineVariaveisAltPre(fNow, 'EFETIVACAO DE PRECOS - ' + qryGenIte.FieldByName('PRE_NOMFRM').AsString, strLoginUsuarioLogado, VS_StrCodEmp, strAgrupadorPreAlt);
    HorIni := fTime(True);

    If Not IsEmpty Then
    Begin
      Try
        qryGenIt2.SQL.Text := ('SELECT COUNT(1) QTD FROM EMPFOR WHERE EFR_CODEMP = "'+VS_strCodEmp+'"');
        qryGenIt2.Open;
        If FblnResFor Then
          If qryGenIt2.FieldByName('QTD').AsInteger = 0 Then
            Exit(True);
        qryGenIt2.SQL.Clear;


        While Not Eof Do
        Begin
          Try

            If FblnResFor and (qryGenIte.FieldByName('PRE_PRCPFO').AsInteger = 1) Then
            begin
              HorIni := fTime(True);
              qtdProcess := 0;
              Continue;
            End;

            If (Not FblnResFor) and (qryGenIte.FieldByName('PRE_PRCNOR').AsInteger = 1) Then
            begin
              HorIni := fTime(True);
              qtdProcess := 0;
              Continue;
            End;

            fStartTransaction;

            If (Not FblnResFor) Or (FblnResFor And fEhEmpresaResponsavelFornecedor(qryGenIte.FieldByName('ITE_CODFOR').AsString)) Then
            With qryGenIt2 Do
            Begin
              SQL.Clear;
              SQL.Add(' UPDATE ITEGER ');
              SQL.Add('   SET         ');
              SQL.Add('    ITE_CODITE = ITE_CODITE,');
              SQL.Add('    ITE_PEFAVE = "S", ');
              SQL.Add('    ITE_PREALT = "'+strAgrupadorPreAlt+'", ');

              If Not qryGenIte.FieldByName('PRE_PRECOM').IsNull Then
              Begin
                SQL.Add('   ITE_PRECOM = :PRECOM,');
                ParamByName('PRECOM').AsFloat := qryGenIte.FieldByName('PRE_PRECOM').AsFloat;
              End;

              If Not qryGenIte.FieldByName('PRE_DESF01').IsNull Then
              Begin
                SQL.Add('   ITE_DESF01 = :DESF01,');
                ParamByName('DESF01').AsFloat := qryGenIte.FieldByName('PRE_DESF01').AsFloat;
              End;

              If Not qryGenIte.FieldByName('PRE_DESF02').IsNull Then
              Begin
                SQL.Add('   ITE_DESF02 = :DESF02,');
                ParamByName('DESF02').AsFloat := qryGenIte.FieldByName('PRE_DESF02').AsFloat;
              End;

              If Not qryGenIte.FieldByName('PRE_DESF03').IsNull Then
              Begin
                SQL.Add('   ITE_DESF03 = :DESF03,');
                ParamByName('DESF03').AsFloat := qryGenIte.FieldByName('PRE_DESF03').AsFloat;
              End;

              If Not qryGenIte.FieldByName('PRE_DESF04').IsNull Then
              Begin
                SQL.Add('   ITE_DESF04 = :DESF04,');
                ParamByName('DESF04').AsFloat := qryGenIte.FieldByName('PRE_DESF04').AsFloat;
              End;

              If Not qryGenIte.FieldByName('PRE_DESF05').IsNull Then
              Begin
                SQL.Add('   ITE_DESF05 = :DESF05,');
                ParamByName('DESF05').AsFloat := qryGenIte.FieldByName('PRE_DESF05').AsFloat;
              End;

              If Not qryGenIte.FieldByName('PRE_DESF06').IsNull Then
              Begin
                SQL.Add('   ITE_DESF06 = :DESF06,');
                ParamByName('DESF06').AsFloat := qryGenIte.FieldByName('PRE_DESF06').AsFloat;
              End;

              If Not qryGenIte.FieldByName('PRE_ICMENT').IsNull Then
              Begin
                SQL.Add('   ITE_ICMENT = :ICMENT,');
                ParamByName('ICMENT').AsFloat := qryGenIte.FieldByName('PRE_ICMENT').AsFloat;
              End;

              If Not qryGenIte.FieldByName('PRE_SUBFED').IsNull Then
              Begin
                SQL.Add('   ITE_SUBFED = :SUBFED,');
                ParamByName('SUBFED').AsFloat := qryGenIte.FieldByName('PRE_SUBFED').AsFloat;
              End;

              If Not qryGenIte.FieldByName('PRE_IPIENT').IsNull Then
              Begin
                SQL.Add('   ITE_IPIENT = :IPIENT,');
                ParamByName('IPIENT').AsFloat := qryGenIte.FieldByName('PRE_IPIENT').AsFloat;
              End;

              If Not qryGenIte.FieldByName('PRE_FREENT').IsNull Then
              Begin
                SQL.Add('   ITE_FREENT = :FREENT,');
                ParamByName('FREENT').AsFloat := qryGenIte.FieldByName('PRE_FREENT').AsFloat;
              End;

              If Not qryGenIte.FieldByName('PRE_VALFRE').IsNull Then
              Begin
                SQL.Add('   ITE_VALFRE = :VALFRE,');
                ParamByName('VALFRE').AsFloat := qryGenIte.FieldByName('PRE_VALFRE').AsFloat;
              End;

              If Not qryGenIte.FieldByName('PRE_ACRFIN').IsNull Then
              Begin
                SQL.Add('   ITE_ACRFIN = :ACRFIN,');
                ParamByName('ACRFIN').AsFloat := qryGenIte.FieldByName('PRE_ACRFIN').AsFloat;
              End;

              If Not qryGenIte.FieldByName('PRE_SUBSTI').IsNull Then
              Begin
                SQL.Add('   ITE_SUBSTI = :SUBSTI,');
                ParamByName('SUBSTI').AsFloat := qryGenIte.FieldByName('PRE_SUBSTI').AsFloat;
              End;

              If Not qryGenIte.FieldByName('PRE_DESADB').IsNull Then
              Begin
                SQL.Add('   ITE_DESADB = :DESADB,');
                ParamByName('DESADB').AsFloat := qryGenIte.FieldByName('PRE_DESADB').AsFloat;
              End;

              If Not qryGenIte.FieldByName('PRE_TCIFCU').IsNull Then
              Begin
                SQL.Add('   ITE_TCIFCU = :TCIFCU,');
                ParamByName('TCIFCU').AsFloat := qryGenIte.FieldByName('PRE_TCIFCU').AsFloat;
              End;

              If Not qryGenIte.FieldByName('PRE_TSCUST').IsNull Then
              Begin
                SQL.Add('   ITE_TSCUST = :TSCUST,');
                ParamByName('TSCUST').AsFloat := qryGenIte.FieldByName('PRE_TSCUST').AsFloat;
              End;

              If Not qryGenIte.FieldByName('PRE_DEPICO').IsNull Then
              Begin
                SQL.Add('   ITE_DEPICO = :DEPICO,');
                ParamByName('DEPICO').AsFloat := qryGenIte.FieldByName('PRE_DEPICO').AsFloat;
              End;

              If Not qryGenIte.FieldByName('PRE_DEICMS').IsNull Then
              Begin
                SQL.Add('   ITE_DEICMS = :DEICMS,');
                ParamByName('DEICMS').AsFloat := qryGenIte.FieldByName('PRE_DEICMS').AsFloat;
              End;

              If Not qryGenIte.FieldByName('PRE_FATREG').IsNull Then
              Begin
                SQL.Add('   ITE_FATREG = :FATREG,');
                ParamByName('FATREG').AsFloat := qryGenIte.FieldByName('PRE_FATREG').AsFloat;
              End;

              If Not qryGenIte.FieldByName('PRE_PRECUS_NOV').IsNull Then
              Begin
                SQL.Add('   ITE_PRECUS = :PRECUS,');
                ParamByName('PRECUS').AsFloat := qryGenIte.FieldByName('PRE_PRECUS_NOV').AsFloat;
              End;

              If Not FblnResFor Then
              Begin
                If Not qryGenIte.FieldByName('PRE_OUTVAL').IsNull Then
                Begin
                  SQL.Add('   ITE_OUTVAL = :OUTVAL,');
                  ParamByName('OUTVAL').AsFloat := qryGenIte.FieldByName('PRE_OUTVAL').AsFloat;
                End;

                If Not qryGenIte.FieldByName('PRE_DESOPE').IsNull Then
                Begin
                  If blnInfMat And (intInfOpe = 1) Then
                    SQL.Add('   ITE_DESOPE = IF(:EMPLOG = ITE_CODEMP, :DESOPE, ITE_DESOPE),')
                  Else
                    SQL.Add('   ITE_DESOPE = :DESOPE,');

                  ParamByName('DESOPE').AsFloat := qryGenIte.FieldByName('PRE_DESOPE').AsFloat;
                End;

                If Not qryGenIte.FieldByName('PRE_ICMSAI').IsNull Then
                Begin
                  If blnInfMat And (intInfSai = 1) Then
                    SQL.Add('   ITE_ICMSAI = IF(:EMPLOG = ITE_CODEMP, :ICMSAI, ITE_ICMSAI),')
                  Else
                    SQL.Add('   ITE_ICMSAI = :ICMSAI,');

                  ParamByName('ICMSAI').AsFloat := qryGenIte.FieldByName('PRE_ICMSAI').AsFloat;
                End;

                If Not qryGenIte.FieldByName('PRE_IMPFED').IsNull Then
                Begin
                  If blnInfMat And (intInfFed = 1) Then
                    SQL.Add('   ITE_IMPFED = IF(:EMPLOG = ITE_CODEMP, :IMPFED, ITE_IMPFED),')
                  Else
                    SQL.Add('   ITE_IMPFED = :IMPFED,');

                  ParamByName('IMPFED').AsFloat := qryGenIte.FieldByName('PRE_IMPFED').AsFloat;
                End;

                if not blnIteTbp Then
                Begin
                  If Not qryGenIte.FieldByName('PRE_DESMAX').IsNull Then
                  Begin
                    SQL.Add('   ITE_DESMAX = :DESMAX,');
                    ParamByName('DESMAX').AsFloat := qryGenIte.FieldByName('PRE_DESMAX').AsFloat;
                  End;
                  If Not qryGenIte.FieldByName('PRE_DESMSU').IsNull Then
                  Begin
                    SQL.Add('   ITE_DESMSU = :DESMSU,');
                    ParamByName('DESMSU').AsFloat := qryGenIte.FieldByName('PRE_DESMSU').AsFloat;
                  End;
                  If Not qryGenIte.FieldByName('PRE_DESMGE').IsNull Then
                  Begin
                    SQL.Add('   ITE_DESMGE = :DESMGE,');
                    ParamByName('DESMGE').AsFloat := qryGenIte.FieldByName('PRE_DESMGE').AsFloat;
                  End;
                  If Not qryGenIte.FieldByName('PRE_DESMVM').IsNull Then
                  Begin
                    SQL.Add('   ITE_DESMVM = :DESMVM,');
                    ParamByName('DESMVM').AsFloat := qryGenIte.FieldByName('PRE_DESMVM').AsFloat;
                  End;
                  If Not qryGenIte.FieldByName('PRE_DESMGM').IsNull Then
                  Begin
                    SQL.Add('   ITE_DESMGM = :DESMGM,');
                    ParamByName('DESMGM').AsFloat := qryGenIte.FieldByName('PRE_DESMGM').AsFloat;
                  End;
                  If Not qryGenIte.FieldByName('PRE_DESMSM').IsNull Then
                  Begin
                    SQL.Add('   ITE_DESMSM = :DESMSM,');
                    ParamByName('DESMSM').AsFloat := qryGenIte.FieldByName('PRE_DESMSM').AsFloat;
                  End;
                End;

                If (Not qryGenIte.FieldByName('PRE_PREDOL_NOV').IsNull) And
                   (Pos(qryGenIte.FieldByName('PRE_PREDOL_NOV').AsString, 'SN') > 0) Then
                Begin
                  SQL.Add('   ITE_PREDOL = :PREDOL,');
                  ParamByName('PREDOL').AsString := qryGenIte.FieldByName('PRE_PREDOL_NOV').AsString;
                End;

                If Not qryGenIte.FieldByName('PRE_MARBR1_NOV').IsNull Then
                Begin
                  SQL.Add('   ITE_MARBR1 = :MARBR1,');
                  ParamByName('MARBR1').AsFloat := qryGenIte.FieldByName('PRE_MARBR1_NOV').AsFloat;
                End;
                If Not qryGenIte.FieldByName('PRE_PREVE1_NOV').IsNull Then
                Begin
                  SQL.Add('   ITE_PREVE1 = :PREVE1,');
                  ParamByName('PREVE1').AsFloat := qryGenIte.FieldByName('PRE_PREVE1_NOV').AsFloat;
                End;
                If Not qryGenIte.FieldByName('PRE_MARBR2_NOV').IsNull Then
                Begin
                  SQL.Add('   ITE_MARBR2 = :MARBR2,');
                  ParamByName('MARBR2').AsFloat := qryGenIte.FieldByName('PRE_MARBR2_NOV').AsFloat;
                End;
                If Not qryGenIte.FieldByName('PRE_PREVE2_NOV').IsNull Then
                Begin
                  SQL.Add('   ITE_PREVE2 = :PREVE2,');
                  ParamByName('PREVE2').AsFloat := qryGenIte.FieldByName('PRE_PREVE2_NOV').AsFloat;
                End;
                If Not qryGenIte.FieldByName('PRE_MARBR3_NOV').IsNull Then
                Begin
                  SQL.Add('   ITE_MARBR3 = :MARBR3,');
                  ParamByName('MARBR3').AsFloat := qryGenIte.FieldByName('PRE_MARBR3_NOV').AsFloat;
                End;
                If Not qryGenIte.FieldByName('PRE_PREVE3_NOV').IsNull Then
                Begin
                  SQL.Add('   ITE_PREVE3 = :PREVE3,');
                  ParamByName('PREVE3').AsFloat := qryGenIte.FieldByName('PRE_PREVE3_NOV').AsFloat;
                End;

                If Not qryGenIte.FieldByName('PRE_MARBR4_NOV').IsNull Then
                Begin
                  SQL.Add('   ITE_MARBR4 = :MARBR4,');
                  ParamByName('MARBR4').AsFloat := qryGenIte.FieldByName('PRE_MARBR4_NOV').AsFloat;
                End;
                If Not qryGenIte.FieldByName('PRE_PREVE4_NOV').IsNull Then
                Begin
                  SQL.Add('   ITE_PREVE4 = :PREVE4,');
                  ParamByName('PREVE4').AsFloat := qryGenIte.FieldByName('PRE_PREVE4_NOV').AsFloat;
                End;

                If Not qryGenIte.FieldByName('PRE_MARBR5_NOV').IsNull Then
                Begin
                  SQL.Add('   ITE_MARBR5 = :MARBR5,');
                  ParamByName('MARBR5').AsFloat := qryGenIte.FieldByName('PRE_MARBR5_NOV').AsFloat;
                End;
                If Not qryGenIte.FieldByName('PRE_PREVE5_NOV').IsNull Then
                Begin
                  SQL.Add('   ITE_PREVE5 = :PREVE5,');
                  ParamByName('PREVE5').AsFloat := qryGenIte.FieldByName('PRE_PREVE5_NOV').AsFloat;
                End;

                If Not qryGenIte.FieldByName('PRE_MARBR6_NOV').IsNull Then
                Begin
                  SQL.Add('   ITE_MARBR6 = :MARBR6,');
                  ParamByName('MARBR6').AsFloat := qryGenIte.FieldByName('PRE_MARBR6_NOV').AsFloat;
                End;
                If Not qryGenIte.FieldByName('PRE_PREVE6_NOV').IsNull Then
                Begin
                  SQL.Add('   ITE_PREVE6 = :PREVE6,');
                  ParamByName('PREVE6').AsFloat := qryGenIte.FieldByName('PRE_PREVE6_NOV').AsFloat;
                End;

                If Not qryGenIte.FieldByName('PRE_MARBR7_NOV').IsNull Then
                Begin
                  SQL.Add('   ITE_MARBR7 = :MARBR7,');
                  ParamByName('MARBR7').AsFloat := qryGenIte.FieldByName('PRE_MARBR7_NOV').AsFloat;
                End;

                If Not qryGenIte.FieldByName('PRE_PREVE7_NOV').IsNull Then
                Begin
                  SQL.Add('   ITE_PREVE7 = :PREVE7,');
                  ParamByName('PREVE7').AsFloat := qryGenIte.FieldByName('PRE_PREVE7_NOV').AsFloat;
                End;

                If Not qryGenIte.FieldByName('PRE_COMTB1').IsNull Then
                Begin
                  SQL.Add('   ITE_COMTB1 = :COMTB1,');
                  ParamByName('COMTB1').AsFloat := qryGenIte.FieldByName('PRE_COMTB1').AsFloat;
                End;

                If Not qryGenIte.FieldByName('PRE_COMTB2').IsNull Then
                Begin
                  SQL.Add('   ITE_COMTB2 = :COMTB2,');
                  ParamByName('COMTB2').AsFloat := qryGenIte.FieldByName('PRE_COMTB2').AsFloat;
                End;

                If Not qryGenIte.FieldByName('PRE_COMTB3').IsNull Then
                Begin
                  SQL.Add('   ITE_COMTB3 = :COMTB3,');
                  ParamByName('COMTB3').AsFloat := qryGenIte.FieldByName('PRE_COMTB3').AsFloat;
                End;

                If Not qryGenIte.FieldByName('PRE_COMTB4').IsNull Then
                Begin
                  SQL.Add('   ITE_COMTB4 = :COMTB4,');
                  ParamByName('COMTB4').AsFloat := qryGenIte.FieldByName('PRE_COMTB4').AsFloat;
                End;

                If Not qryGenIte.FieldByName('PRE_COMTB5').IsNull Then
                Begin
                  SQL.Add('   ITE_COMTB5 = :COMTB5,');
                  ParamByName('COMTB5').AsFloat := qryGenIte.FieldByName('PRE_COMTB5').AsFloat;
                End;

                If Not qryGenIte.FieldByName('PRE_COMTB6').IsNull Then
                Begin
                  SQL.Add('   ITE_COMTB6 = :COMTB6,');
                  ParamByName('COMTB6').AsFloat := qryGenIte.FieldByName('PRE_COMTB6').AsFloat;
                End;

                If Not qryGenIte.FieldByName('PRE_COMTB7').IsNull Then
                Begin
                  SQL.Add('   ITE_COMTB7 = :COMTB7,');
                  ParamByName('COMTB7').AsFloat := qryGenIte.FieldByName('PRE_COMTB7').AsFloat;
                End;

                If Not qryGenIte.FieldByName('PRE_MARMIN').IsNull Then
                Begin
                  SQL.Add('   ITE_MARMIN = :MARMIN,');
                  ParamByName('MARMIN').AsFloat := qryGenIte.FieldByName('PRE_MARMIN').AsFloat;
                End;

              End; {If Not blnResFor Then}

              If blnMarIde Then
              For intContador := 1 To 7 Do
                If Not qryGenIte.FieldByName('PRE_MARID' + IntToStr(intContador) + '_NOV').IsNull Then
                Begin
                  SQL.Add('   ITE_MARID' + IntToStr(intContador) + ' = :MARID' + IntToStr(intContador) + ',');
                  ParamByName('MARID' + IntToStr(intContador)).AsFloat := qryGenIte.FieldByName('PRE_MARID' + IntToStr(intContador) + '_NOV').AsFloat;
                End;

              SQL.Text := Copy(SQL.Text, 1, Length(SQL.Text)-3);

              SQL.Add(' WHERE ITE_CODITE = :CODITE AND ');

              If FblnResFor Then
                SQL.Add('       LOCATE(ITE_CODEMP, :CODEMP) = 0 ')
              Else
                SQL.Add('       LOCATE(ITE_CODEMP, :CODEMP) > 0 ');

              ParamByName('CODITE').AsString := qryGenIte.FieldByName('PRE_CODITE').AsString;

              ParamByName('CODEMP').AsString := strEmpresas;

              If Params.FindParam('EMPLOG') <> Nil Then
                ParamByName('EMPLOG').AsString := VS_strCodEmp;

              If FblnResFor Then
              Begin

                ExecSQL;
                pRecalculaItensResponsavelFornecedor(strEmpresas, qryGenIte.FieldByName('PRE_CODITE').AsString, FblnResFor);

                Result := True;

              End Else
              Begin

                ExecSQL;

                If blnInfMat Then
                  pRecalculaItensResponsavelFornecedor(strEmpresas, qryGenIte.FieldByName('PRE_CODITE').AsString, FblnResFor);

                pAtualizaUltimaAlteracaoItem(qryAtuIte, qryGenIte.FieldByName('PRE_CODITE').AsString, VS_Date);
                If (Not VS_blnPreAltViaTrigger) Then
                  Result := fGravaPreAlt(qryGenIte.FieldByName('PRE_CODITE').AsString,
                             qryGenIte.FieldByName('ITE_PRECUS').AsFloat,
                             qryGenIte.FieldByName('PRE_PRECUS_NOV').AsFloat,
                             qryGenIte.FieldByName('ITE_PREVE1').AsFloat,
                             qryGenIte.FieldByName('PRE_PREVE1_NOV').AsFloat,
                             qryGenIte.FieldByName('ITE_MARBR1').AsFloat,
                             qryGenIte.FieldByName('PRE_MARBR1_NOV').AsFloat,
                             qryGenIte.FieldByName('ITE_PREVE2').AsFloat,
                             qryGenIte.FieldByName('PRE_PREVE2_NOV').AsFloat,
                             qryGenIte.FieldByName('ITE_MARBR2').AsFloat,
                             qryGenIte.FieldByName('PRE_MARBR2_NOV').AsFloat,
                             qryGenIte.FieldByName('ITE_PREVE3').AsFloat,
                             qryGenIte.FieldByName('PRE_PREVE3_NOV').AsFloat,
                             qryGenIte.FieldByName('ITE_MARBR3').AsFloat,
                             qryGenIte.FieldByName('PRE_MARBR3_NOV').AsFloat,
                             qryGenIte.FieldByName('ITE_PREVE4').AsFloat,
                             qryGenIte.FieldByName('PRE_PREVE4_NOV').AsFloat,
                             qryGenIte.FieldByName('ITE_MARBR4').AsFloat,
                             qryGenIte.FieldByName('PRE_MARBR4_NOV').AsFloat,
                             qryGenIte.FieldByName('ITE_PREVE5').AsFloat,
                             qryGenIte.FieldByName('PRE_PREVE5_NOV').AsFloat,
                             qryGenIte.FieldByName('ITE_MARBR5').AsFloat,
                             qryGenIte.FieldByName('PRE_MARBR5_NOV').AsFloat,
                             qryGenIte.FieldByName('ITE_PREVE6').AsFloat,
                             qryGenIte.FieldByName('PRE_PREVE6_NOV').AsFloat,
                             qryGenIte.FieldByName('ITE_MARBR6').AsFloat,
                             qryGenIte.FieldByName('PRE_MARBR6_NOV').AsFloat,
                             qryGenIte.FieldByName('ITE_PREVE7').AsFloat,
                             qryGenIte.FieldByName('PRE_PREVE7_NOV').AsFloat,
                             qryGenIte.FieldByName('ITE_MARBR7').AsFloat,
                             qryGenIte.FieldByName('PRE_MARBR7_NOV').AsFloat,

                             qryGenIte.FieldByName('ITE_PRECOM').AsFloat,
                             qryGenIte.FieldByName('PRE_PRECOM').AsFloat,

                             'EFETIVACAO DE PRECOS - ' +
                             qryGenIte.FieldByName('PRE_NOMFRM').AsString);

                If Not Result Then
                  Break;

                pAtualizaItensGrupoPrecos(qryGenIte.FieldByName('PRE_CODITE').AsString,
                                          'EFETIVACAO DE PRECOS - ' +
                                          qryGenIte.FieldByName('PRE_NOMFRM').AsString, strAgrupadorPreAlt);
                pAtualizaPreIte(FblnResFor, qryGenIte.FieldByName('AUTOINCREM').AsString);
              End;

            End; {With qryGenIt2 Do}

            Result := Result And fApagaReservaEnderecamento(FieldByName('PRE_LOTPRE').AsString,
                                                            qryGenIte.FieldByName('PRE_CODITE').AsString,
                                                            qryGenIte.FieldByName('PRE_CODEMP').AsString);

            If Result Then
              fCommit
            Else
              fRollBack;


          finally

            qtdSegundos := SecondsBetween(fTime(True), HorIni);
            ValidacoesPorSegundo := RoundTo(qtdProcess/qtdSegundos, -4);
            TempoExtimado := fTrataTextoTempo(Trunc((qryGenIte.RecordCount - qryGenIte.Recno)/ValidacoesPorSegundo));
            TempoExtimado := IntToStr(qryGenIte.RecordCount) + '/' +  IntToStr(qryGenIte.RecNo) + ' Qtd. Por Segundo: ' + FloatToStr(ValidacoesPorSegundo) + ' Tempo Estimado: ' + TempoExtimado;

            lblTot.Caption := TempoExtimado;
            pgbBarra.Position := pgbBarra.Position + 1;
            Application.ProcessMessages;
            Next;
            inc(qtdProcess);
          End
        End;

{
        If (Result) Then
          fCommit
        Else
          fRollBack;
}
        Screen.Cursor := crDefault;
        lblTot.Caption := '';

      Except
        on E: Exception do
        Begin
          fRollBack;
          pMensagensErro(E.Message, '[fGravaPrecos]');
          Result := False;
        End;
      End;
    End;
  End;

  Screen.Cursor := crDefault;

  FreeAndNil(qryGenIte);
  FreeAndNil(qryGenIt2);
  FreeAndNil(qryAtuIte);
End;

function TfrmAltEfetivacaoPrecos.fTrataTextoTempo(segundos: Integer): String;
var
  Seg, Min, Hora: Cardinal;
begin
  Result := '';
  Hora := Segundos div 3600;
  Seg := Segundos mod 3600;
  Min := Seg div 60;
  Seg := Seg mod 60;
  If Hora > 0 Then
    Result := FormatFloat('00', Hora) + 'hs. ';
  If Min > 0 Then
     Result :=  Result + FormatFloat('00', Min) + 'min.';
  Result :=  Result + FormatFloat('00', Seg) + 'seg.'
end;


procedure TfrmAltEfetivacaoPrecos.pAtualizaPreIte(blnResFor: Boolean;
  strAutInc: String);
  var strField: string;
begin
  strField :=  IIF(blnResFor ,   'PRE_PRCPFO', 'PRE_PRCNOR');
  qryComand.SQL.Clear;
  qryComand.SQL.Add('UPDATE PREITE SET ' + strField + ' = 1 WHERE AUTOINCREM = "' + strAutInc + '"');
  qryComand.ExecSQL;
end;



procedure TfrmAltEfetivacaoPrecos.FormShow(Sender: TObject);
Begin
  inherited;

  pAbreConsulta;
End;


function TfrmAltEfetivacaoPrecos.fRetornaDocumentosRelacionados(dtaDataPRE: TDate): String;
var
  qryGenTemp: TUniQuery;
Begin
  Result:= '';
  qryGenTemp := fCriaQuery(Self);
  Try
    qryGenTemp.Close;
    qryGenTemp.SQL.Clear;
    qryGenTemp.SQL.Add(' SELECT ');
    qryGenTemp.SQL.Add('   CONCAT(DET_NUMDOC,"-",DET_ESPDOC) AS DOCUMENTO');
    qryGenTemp.SQL.Add(' FROM ');
    qryGenTemp.SQL.Add('   PREITE ');
    qryGenTemp.SQL.Add(' LEFT JOIN MOVDET ON MOVDET.AUTOINCREM = PRE_SEQDET ');
    qryGenTemp.SQL.Add(' WHERE PRE_CODEMP = :CODEMP AND ');
    qryGenTemp.SQL.Add('       PRE_DTAPRE = :DTAPRE     ');
    qryGenTemp.SQL.Add(' ORDER BY DET_NUMDOC ');
    qryGenTemp.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryGenTemp.ParamByName('DTAPRE').AsDate := dtaDataPRE;
    qryGenTemp.Open;

    qryGenTemp.First;

    While Not qryGenTemp.eof do
    Begin
      If Not fEmptyStr(Result) Then
        Result:= Result + ' / '+ qryGenTemp.FieldByName('DOCUMENTO').AsString
      Else
        Result:= Result + qryGenTemp.FieldByName('DOCUMENTO').AsString;
      qryGenTemp.Next;
    End;


  Finally
    FreeAndNil(qryGenTemp);
  End;
End;


procedure TfrmAltEfetivacaoPrecos.pAbreConsulta;
var
  lsvLista : TListItem;
  qryGenIte: TUniQuery;
begin

  Try

    qryGenIte := fCriaQuery(Self);

    With qryGenIte Do
    Begin
      SQL.Clear;
      SQL.Add(' SELECT ');
      SQL.Add('   PRE_DTAPRE, COUNT(*) AS QTD ');
      SQL.Add(' FROM ');
      SQL.Add('   PREITE ');
      SQL.Add(' WHERE (PRE_CODEMP = :CODEMP) ');
      SQL.Add(' GROUP BY PRE_DTAPRE ');
      SQL.Add(' ORDER BY PRE_DTAPRE ');

      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;

      lsvDtaDis.Clear;

      If Not IsEmpty Then
      Begin

        While Not EOF Do
        Begin
          lsvLista := lsvDtaDis.Items.Add;
          If FieldByName('PRE_DTAPRE').AsDateTime < VS_Date Then
          Begin
            lsvLista.ImageIndex := 0;
            lsvLista.StateIndex := 2;
          End
          Else Begin
            lsvLista.ImageIndex := 0;
            lsvLista.StateIndex := 3;
          End;
          lsvLista.Caption := FieldByName('PRE_DTAPRE').AsString;
          lsvLista.SubItems.Add(FieldByName('QTD').AsString);
          lsvLista.SubItems.Add(fRetornaDocumentosRelacionados(StrToDate(FieldByName('PRE_DTAPRE').AsString)));
          Next;
        End;

        pSetFocus(lsvDtaDis);
      End

      Else
      Begin
        fMensagem('Atenção', 'Nenhuma alteração de preços está agendada',['&OK']);
        lsvDtaDis.Clear;
        Self.Close;
      End;

    End;

  Finally
    FreeAndNil(qryGenIte);
  End;


  pSetFocus(lsvDtaDis);
end;

procedure TfrmAltEfetivacaoPrecos.frxDBImpEtiCheckEOF(Sender: TObject;
  var Eof: Boolean);
begin
  inherited;
  Eof := cdsItens.Eof;
end;

procedure TfrmAltEfetivacaoPrecos.frxDBImpEtiFirst(Sender: TObject);
begin
  inherited;
  cdsItens.First;
//  IntQtdEti := Pred(cdsItens.FieldByName('QTDETI').AsInteger);
  IntQtdEti := Pred(1);
end;

procedure TfrmAltEfetivacaoPrecos.frxDBImpEtiGetValue(const VarName: string;
  var Value: Variant);
begin
  inherited;
  With cdsItens Do
  If SameText('VALITE',VarName) Or SameText('VALVIS',VarName) Then
  Begin
    Value := FieldByName('PREVE' + IntToStr(intPreTab)).Value;
  End

  Else If SameText('PROMOC',VarName) Then
  Begin
    If FieldByName('PROMOC').IsNull Then
      Value := FieldByName('PREVE' + IntToStr(intPreTab)).AsFloat
    Else
      Value := FieldByName('PROMOC').AsFloat;
  End

  Else If SameText('CODBAR',VarName) And
     ((Length(FieldByName( VarName ).AsString) > 13) Or
      (StrToInt64Def(FieldByName( VarName ).AsString,-1) = -1)) Then
    Value := '0'

  Else If SameText('QTDETI',VarName) Then
    Value := 1 {IntQtdEti}

  Else
    Value := FieldByName( VarName ).AsString;
end;

procedure TfrmAltEfetivacaoPrecos.frxDBImpEtiNext(Sender: TObject);
begin
  inherited;
  If IntQtdEti <= 0 Then
  Begin

    cdsItens.Next;
//  IntQtdEti := cdsItens.FieldByName('QTDETI').AsInteger;
    IntQtdEti := 1;

  End;

  Dec(IntQtdEti);
end;

procedure TfrmAltEfetivacaoPrecos.frxDBImpEtiPrior(Sender: TObject);
begin
  inherited;
  cdsItens.Prior;
end;

function TfrmAltEfetivacaoPrecos.fRetSQLItens(blnCodFor: Boolean): String;
begin
  Result := '';
  Result := Result + 'SELECT         ';
  Result := Result + '  P.*          ';

  If blnCodFor Then
  Begin
    Result := Result + '  , C.ITE_CODFOR, ';

    Result := Result + '  C.ITE_CODITE, ';
    Result := Result + '  C.ITE_DESITE, ';
    Result := Result + '  C.ITE_CODUNI, ';
    Result := Result + '  C.ITE_CODUNI AS ITE_CODUNI_NOV, ';

    Result := Result + '  G.ITE_PRECOM, ';
    Result := Result + '  G.ITE_PRECUS, ';

    Result := Result + '  G.ITE_PREVE1, ';
    Result := Result + '  G.ITE_PREVE2, ';
    Result := Result + '  G.ITE_PREVE3, ';
    Result := Result + '  G.ITE_PREVE4, ';
    Result := Result + '  G.ITE_PREVE5, ';
    Result := Result + '  G.ITE_PREVE6, ';
    Result := Result + '  G.ITE_PREVE7, ';

    Result := Result + '  G.ITE_MARBR1, ';
    Result := Result + '  G.ITE_MARBR2, ';
    Result := Result + '  G.ITE_MARBR3, ';
    Result := Result + '  G.ITE_MARBR4, ';
    Result := Result + '  G.ITE_MARBR5, ';
    Result := Result + '  G.ITE_MARBR6, ';
    Result := Result + '  G.ITE_MARBR7  ';
  End;

  Result := Result + 'FROM           ';
  Result := Result + '  PREITE P     ';

  If blnCodFor Then
  Begin
    Result := Result + ' LEFT JOIN CADITE C ON C.ITE_CODITE = P.PRE_CODITE ';

    Result := Result + ' INNER JOIN ITEGER G ON G.ITE_CODITE = P.PRE_CODITE AND G.ITE_CODEMP = :CODEMP ';
  End;

  Result := Result + 'WHERE      ';
  Result := Result + '  PRE_DTAPRE = :DATA AND ';
  Result := Result + '  PRE_CODEMP = :CODEMP   ';
end;

procedure TfrmAltEfetivacaoPrecos.btnAltDatClick(Sender: TObject);
begin
  inherited;

  If lsvDtaDis.SelCount > 0 Then
    pAlteraDataEfetivacao(StrToDate(lsvDtaDis.ItemFocused.Caption))
  Else
    fMensagem('Informação','Nenhuma data foi selecionada',['&OK']);
end;

procedure TfrmAltEfetivacaoPrecos.pAlteraDataEfetivacao(dtaDtaPre: TDateTime);
Begin
  pCriarFormularios(TfrmAltDataEfetivacao, frmAltDataEfetivacao);
  frmAltDataEfetivacao.dtaDtaPre := dtaDtaPre;
  frmAltDataEfetivacao.ShowModal;
  pFreeAndNil(frmAltDataEfetivacao);

  pAbreConsulta;
End;

procedure TfrmAltEfetivacaoPrecos.btnCancelClick(Sender: TObject);
  var
    lsiItem: TListItem;
    objAltEfe: TAltEfetivacaoManut;
begin
  inherited;

  If lsvDtaDis.SelCount > 0 Then
  Begin
    lsiItem := lsvDtaDis.ItemFocused;

    objAltEfe := TAltEfetivacaoManut.Create(Self);
    objAltEfe.pMostraItens(StrToDate(lsiItem.Caption));
    FreeAndNil(objAltEfe);
    pAbreConsulta;

    (*
    If fMensagem('ATENÇÃO!','Confirma o cancelamento da efetivação do dia '+lsiItem.Caption+'?',['&Sim', '&Não'], 2) = 1 Then
    begin
      If fApagaPreIte(StrToDate(lsiItem.Caption), VS_strCodEmp) Then
      Begin
        fMensagem('Informação', 'Cancelamento realizado com sucesso',['&OK']);
        Self.Close;
      End;
    End;
   *)

  End
  Else
    fMensagem('Informação','Nenhuma data foi selecionada',['&OK']);
end;

procedure TfrmAltEfetivacaoPrecos.btnConfirmaClick(Sender: TObject);
var
  lsiItem: TListItem;
  blnResult: Boolean;
begin
  inherited;
  If lsvDtaDis.SelCount > 0 Then
  Begin
    lsiItem := lsvDtaDis.ItemFocused;
    If fMensagem('Confirmação','Confirma efetivação do dia '+lsiItem.Caption+'?',['&Sim', '&Não'], 2) = 1 Then
    begin
      blnResult := fConfirmaEfetivacaoPreco(strToDate(lsiItem.Caption));

      If blnResult Then
      Begin
        fMensagem('Informação', 'Preços atualizados com sucesso',['&OK']);
        Self.Close;
        ModalResult := mrOk;
      End;
    End;
  End
  Else
    fMensagem('Informação','Nenhuma data foi selecionada',['&OK']);
end;

procedure TfrmAltEfetivacaoPrecos.lsvDtaDisDblClick(Sender: TObject);
begin
  inherited;
  btnConfirmaClick(Sender);
end;

procedure TfrmAltEfetivacaoPrecos.lsvDtaDisKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_RETURN) Then
    btnConfirmaClick(Sender);
end;

procedure TfrmAltEfetivacaoPrecos.pSetaParametrosItens(Var qryGenIte: TUniQuery; dtaData: TDate; strCodEmp: String);
begin
  With qryGenIte Do
  Begin
    ParamByName('DATA').AsDateTime := dtaData;
    ParamByName('CODEMP').AsString := strCodEmp;
  End
end;

procedure TfrmAltEfetivacaoPrecos.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_F5    : btnCancel.Click;
    VK_F6    : btnAltDat.Click;
    VK_ESCAPE: btnSair.Click;
  End;
end;

procedure TfrmAltEfetivacaoPrecos.FormCreate(Sender: TObject);
begin
  inherited;
  blnInfMat := fCfgSis('INFMAT', varBoolean);


  intInfFed := fCfgSis('INFFED', varInteger);
  intInfOpe := fCfgSis('INFOPE', varInteger);
  intInfSai := fCfgSis('INFSAI', varInteger);
   qryPreAlt := fCriarQuery('SELECT * FROM PREALT WHERE FALSE', Self);
   qryComand := fCriaQuery;
  fAbrirTabela(qryPreAlt);
end;

procedure TfrmAltEfetivacaoPrecos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  fFecharTabela(qryPreAlt);
  FreeAndNil(qryComand);
End;

end.


