unit untCadRctAgro;

interface

uses Classes, Uni, untFuncFatTypes, Variants;

Type TCadGro = Class(TComponent)
  Private
    FOperac: String;

    FCodIte: String;
    FCultur: String;
    FArtigo: String;
    FDesIte: String;

    FAutInc: String;
    FCodEmp: String;

    FDiagno: String;
    FNomCom: String;
    FGruQui: String;
    FClaTox: String;
    FAreRec: String;
    FPerCar: String;
    FManPra: String;
    FConcen: String;
    FFormul: String;

    FTotAdq: Double;

    FDosApl: String;
    FDosEsp: String;
    FDesUni: String;
    FIntApl: String;

    FNumApl: Integer;

    FModApl: String;
    FEpoApl: String;
    FPriAti: String;
    FAlarme: String;
    FAntido: String;
    FObserv: String;

    function getTotAdq: String;
    function getNumApl: String;

    procedure setTotAdq(const Value: String);
    procedure setNumApl(const Value: String);

  Public

    qryCadGro: TUniQuery;

    property strOperac: String Read FOperac Write FOperac;

    property strCodIte: String Read FCodIte Write FCodIte;
    property strCultur: String Read FCultur Write FCultur;
    property strArtigo: String Read FArtigo Write FArtigo;
    property strDesIte: String Read FDesIte Write FDesIte;

    property strAutInc: String Read FAutInc Write FAutInc;
    property strCodEmp: String Read FCodEmp Write FCodEmp;

    property strDiagno: String Read FDiagno Write FDiagno;
    property strNomCom: String Read FNomCom Write FNomCom;
    property strGruQui: String Read FGruQui Write FGruQui;
    property strClaTox: String Read FClaTox Write FClaTox;
    property strAreRec: String Read FAreRec Write FAreRec;
    property strPerCar: String Read FPerCar Write FPerCar;
    property strManPra: String Read FManPra Write FManPra;
    property strConcen: String Read FConcen Write FConcen;
    property strFormul: String Read FFormul Write FFormul;

    property strTotAdq: String Read getTotAdq Write setTotAdq;

    property strDosApl: String Read FDosApl Write FDosApl;
    property strDosEsp: String Read FDosEsp Write FDosEsp;
    property strDesUni: String Read FDesUni Write FDesUni;
    property strIntApl: String Read FIntApl Write FIntApl;

    property strNumApl: String Read getNumApl Write setNumApl;

    property strModApl: String Read FModApl Write FModApl;
    property strEpoApl: String Read FEpoApl Write FEpoApl;
    property strPriAti: String Read FPriAti Write FPriAti;
    property strAlarme: String Read FAlarme Write FAlarme;
    property strAntido: String Read FAntido Write FAntido;
    property strObserv: String Read FObserv Write FObserv;

    Constructor Create(Owner: TComponent); Reintroduce;
    Destructor Destroy; override;

    procedure pCarregaTela; // dados dos na tela

    function fVerificaCadGroExiste(strNumero, strCultur, strArtigo: String; blnCarrega: Boolean = True): Boolean;
    function fVerificaLimiteARTAtual(strArt: String): Boolean;
    function fProximoNroReceita(strArt: String): Integer;
    function fGravaCadGro: Boolean;

    function fGravaMovGro(var strSeqMov: String;
                          strNotFis,
                          strDtaFis,
                          strNroRec,
                          strCodCli,
                          strCodRes,
                          strInfAdd,
                          strDtaEmi: String;
                          objFazenda: TDadosFazendaBase = nil): Boolean;

  End;

implementation

{ TCadGro }

uses SysUtils, Forms, untFuncoesSimples, Data.DB;

constructor TCadGro.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  qryCadGro := fCriaQuery(Self);
end;

function TCadGro.getTotAdq: String;
begin
  Result := FloatToStrF(FTotAdq,ffNumber,12,3);
end;

procedure TCadGro.setTotAdq(const Value: String);
begin
  If Not fEmptyStr(Value) Then
    FTotAdq := fStrToFloat(Value)
  Else
    FTotAdq := 0;
end;

function TCadGro.getNumApl;
begin
  Result := IntToStr(FNumApl);
end;

procedure TCadGro.setNumApl(const Value: string);
begin
  If Not fEmptyStr(Value) Then
    FNumApl := StrToInt(Value)
  Else
    FNumApl := 0;
end;

function TCadGro.fGravaCadGro: Boolean;
Var
  strSQL: String;
  qryGen: TUniQuery;
Begin

  Try
    If FOperac = 'I' Then
    Begin

      strSQL := '';
      strSQL := strSQL + ' INSERT INTO CADGRO( ';
      strSQL := strSQL + '   AGR_CODITE, ';
      strSQL := strSQL + '   AGR_CULTUR, ';
      strSQL := strSQL + '   AGR_ARTIGO, ';
      strSQL := strSQL + '   AGR_DESITE, ';
      strSQL := strSQL + '   AUTOINCREM, ';
      strSQL := strSQL + '   AGR_CODEMP, ';
      strSQL := strSQL + '   AGR_DIAGNO, ';
      strSQL := strSQL + '   AGR_NOMCOM, ';
      strSQL := strSQL + '   AGR_GRUQUI, ';
      strSQL := strSQL + '   AGR_CLATOX, ';
      strSQL := strSQL + '   AGR_AREREC, ';
      strSQL := strSQL + '   AGR_PERCAR, ';
      strSQL := strSQL + '   AGR_MANPRA, ';
      strSQL := strSQL + '   AGR_CONCEN, ';
      strSQL := strSQL + '   AGR_FORMUL, ';
      strSQL := strSQL + '   AGR_TOTADQ, ';
      strSQL := strSQL + '   AGR_DOSAPL, ';
      strSQL := strSQL + '   AGR_DOSESP, ';
      strSQL := strSQL + '   AGR_DESUNI, ';
      strSQL := strSQL + '   AGR_INTAPL, ';
      strSQL := strSQL + '   AGR_NUMAPL, ';
      strSQL := strSQL + '   AGR_MODAPL, ';
      strSQL := strSQL + '   AGR_PRIATI, ';
      strSQL := strSQL + '   AGR_ALARME, ';
      strSQL := strSQL + '   AGR_ANTIDO, ';
      strSQL := strSQL + '   AGR_OBSERV, ';
      strSQL := strSQL + '   AGR_EPOAPL )';
      strSQL := strSQL + '   VALUES ( ';
      strSQL := strSQL + '   :CODITE, ';
      strSQL := strSQL + '   :CULTUR, ';
      strSQL := strSQL + '   :ARTIGO, ';
      strSQL := strSQL + '   :DESITE, ';
      strSQL := strSQL + '   :AUTINC, ';
      strSQL := strSQL + '   :CODEMP, ';
      strSQL := strSQL + '   :DIAGNO, ';
      strSQL := strSQL + '   :NOMCOM, ';
      strSQL := strSQL + '   :GRUQUI, ';
      strSQL := strSQL + '   :CLATOX, ';
      strSQL := strSQL + '   :AREREC, ';
      strSQL := strSQL + '   :PERCAR, ';
      strSQL := strSQL + '   :MANPRA, ';
      strSQL := strSQL + '   :CONCEN, ';
      strSQL := strSQL + '   :FORMUL, ';
      strSQL := strSQL + '   :TOTADQ, ';
      strSQL := strSQL + '   :DOSAPL, ';
      strSQL := strSQL + '   :DOSESP, ';
      strSQL := strSQL + '   :DESUNI, ';
      strSQL := strSQL + '   :INTAPL, ';
      strSQL := strSQL + '   :NUMAPL, ';
      strSQL := strSQL + '   :MODAPL, ';
      strSQL := strSQL + '   :PRIATI, ';
      strSQL := strSQL + '   :ALARME, ';
      strSQL := strSQL + '   :ANTIDO, ';
      strSQL := strSQL + '   :OBSERV, ';
      strSQL := strSQL + '   :EPOAPL )';

      FAutInc := fRetAutoIncrem('CADGRO', VS_strCodEmp);

    End
    Else
    Begin

      strSQL := '';
      strSQL := strSQL + ' UPDATE CADGRO SET ';
      strSQL := strSQL + '   AGR_ARTIGO = :ARTIGO, ';
      strSQL := strSQL + '   AGR_DESITE = :DESITE, ';
      strSQL := strSQL + '   AGR_DIAGNO = :DIAGNO, ';
      strSQL := strSQL + '   AGR_NOMCOM = :NOMCOM, ';
      strSQL := strSQL + '   AGR_GRUQUI = :GRUQUI, ';
      strSQL := strSQL + '   AGR_CLATOX = :CLATOX, ';
      strSQL := strSQL + '   AGR_AREREC = :AREREC, ';
      strSQL := strSQL + '   AGR_PERCAR = :PERCAR, ';
      strSQL := strSQL + '   AGR_MANPRA = :MANPRA, ';
      strSQL := strSQL + '   AGR_CONCEN = :CONCEN, ';
      strSQL := strSQL + '   AGR_FORMUL = :FORMUL, ';
      strSQL := strSQL + '   AGR_TOTADQ = :TOTADQ, ';
      strSQL := strSQL + '   AGR_DOSAPL = :DOSAPL, ';
      strSQL := strSQL + '   AGR_DOSESP = :DOSESP, ';
      strSQL := strSQL + '   AGR_DESUNI = :DESUNI, ';
      strSQL := strSQL + '   AGR_INTAPL = :INTAPL, ';
      strSQL := strSQL + '   AGR_NUMAPL = :NUMAPL, ';
      strSQL := strSQL + '   AGR_MODAPL = :MODAPL, ';
      strSQL := strSQL + '   AGR_PRIATI = :PRIATI, ';
      strSQL := strSQL + '   AGR_ALARME = :ALARME, ';
      strSQL := strSQL + '   AGR_ANTIDO = :ANTIDO, ';
      strSQL := strSQL + '   AGR_OBSERV = :OBSERV, ';
      strSQL := strSQL + '   AGR_EPOAPL = :EPOAPL  ';
      strSQL := strSQL + ' WHERE ';
      strSQL := strSQL + '   AGR_CODITE = :CODITE AND ';
      strSQL := strSQL + '   AGR_CODEMP = :CODEMP AND ';
      strSQL := strSQL + '   AGR_CULTUR = :CULTUR AND ';
      strSQL := strSQL + '   AGR_ARTIGO = :ARTIGO ';

    End;

    qryGen := fCriaQuery;

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      If FOperac = 'I' Then
        ParamByName('AUTINC').AsString  := FAutInc;

      ParamByName('CODITE').AsString  := FCodIte;
      ParamByName('CODEMP').AsString  := FCodEmp;
      ParamByName('CULTUR').AsString  := FCultur;

      ParamByName('ARTIGO').AsString  := FArtigo;
      ParamByName('DESITE').AsString  := FDesIte;
      ParamByName('DIAGNO').AsString  := FDiagno;
      ParamByName('NOMCOM').AsString  := FNomCom;
      ParamByName('GRUQUI').AsString  := FGruQui;
      ParamByName('CLATOX').AsString  := FClaTox;
      ParamByName('AREREC').AsString  := FAreRec;
      ParamByName('PERCAR').AsString  := FPerCar;
      ParamByName('MANPRA').AsString  := FManPra;
      ParamByName('CONCEN').AsString  := FConcen;
      ParamByName('FORMUL').AsString  := FFormul;
      ParamByName('TOTADQ').AsFloat   := FTotAdq;
      ParamByName('DOSAPL').AsString  := FDosApl;
      ParamByName('DOSESP').AsString  := FDosEsp;
      ParamByName('DESUNI').AsString  := FDesUni;
      ParamByName('INTAPL').AsString  := FIntApl;
      ParamByName('NUMAPL').AsInteger := FNumApl;
      ParamByName('MODAPL').AsString  := FModApl;
      ParamByName('PRIATI').AsString  := FPriAti;
      ParamByName('ALARME').AsString  := FAlarme;
      ParamByName('ANTIDO').AsString  := FAntido;
      ParamByName('OBSERV').AsString  := FObserv;
      ParamByName('EPOAPL').AsString  := FEpoApl;

      ExecSQL;
    End;

    Result := True;
  Finally
    FreeAndNil(qryGen);
  End;

End;

destructor TCadGro.Destroy;
begin
  Application.ProcessMessages;
  FreeAndNil(qryCadGro);

  inherited Destroy;
end;

procedure TCadGro.pCarregaTela;
Begin

  With qryCadGro Do
  Begin
    FCodIte := FieldByName('AGR_CODITE').AsString;
    FCultur := FieldByName('AGR_CULTUR').AsString;
    FArtigo := FieldByName('AGR_ARTIGO').AsString;
    FDesIte := FieldByName('AGR_DESITE').AsString;

    FAutInc := FieldByName('AUTOINCREM').AsString;
    FCodEmp := FieldByName('AGR_CODEMP').AsString;

    FDiagno := FieldByName('AGR_DIAGNO').AsString;
    FNomCom := FieldByName('AGR_NOMCOM').AsString;
    FGruQui := FieldByName('AGR_GRUQUI').AsString;
    FClaTox := FieldByName('AGR_CLATOX').AsString;
    FAreRec := FieldByName('AGR_AREREC').AsString;
    FPerCar := FieldByName('AGR_PERCAR').AsString;
    FManPra := FieldByName('AGR_MANPRA').AsString;
    FConcen := FieldByName('AGR_CONCEN').AsString;
    FFormul := FieldByName('AGR_FORMUL').AsString;

    FTotAdq := FieldByName('AGR_TOTADQ').AsFloat;

    FDosApl := FieldByName('AGR_DOSAPL').AsString;
    FDosEsp := FieldByName('AGR_DOSESP').AsString;
    FDesUni := FieldByName('AGR_DESUNI').AsString;
    FIntApl := FieldByName('AGR_INTAPL').AsString;

    FNumApl := FieldByName('AGR_NUMAPL').AsInteger;

    FModApl := FieldByName('AGR_MODAPL').AsString;
    FEpoApl := FieldByName('AGR_EPOAPL').AsString;
    FPriAti := FieldByName('AGR_PRIATI').AsString;
    FAlarme := FieldByName('AGR_ALARME').AsString;
    FAntido := FieldByName('AGR_ANTIDO').AsString;
    FObserv := FieldByName('AGR_OBSERV').AsString;
  End;

End;

function TCadGro.fVerificaCadGroExiste(strNumero, strCultur, strArtigo: String; blnCarrega: Boolean = True): Boolean;
Var
  strSQL : String;
Begin

  strSQL := '';
  strSQL := strSQL + ' SELECT   ';
  strSQL := strSQL + '   *      ';
  strSQL := strSQL + ' FROM     ';
  strSQL := strSQL + '   CADGRO ';
  strSQL := strSQL + ' WHERE    ';
  strSQL := strSQL + '   AGR_CODITE = :CODITE AND ';
  strSQL := strSQL + '   AGR_CULTUR = :CULTUR AND ';
  strSQL := strSQL + '   AGR_ARTIGO = :ARTIGO     ';

  With qryCadGro Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODITE').AsString := strNumero;
    ParamByName('CULTUR').AsString := strCultur;
    ParamByName('ARTIGO').AsString := strArtigo;
    Open;

    If Not IsEmpty Then
    Begin
      Result  := True;
      If blnCarrega Then
      Begin
        FCodIte := strNumero;
        FCultur := strCultur;
        pCarregaTela;
      End;
    End
    Else
      Result := False;
  End;

End;

function TCadGro.fVerificaLimiteARTAtual(strArt: String): Boolean;
Var
  strSQL : String;
  qryGen : TUniQuery;
begin

  qryGen := fCriaQuery;
  strSQL := '';
  strSQL := strSQL + ' SELECT   ';
  strSQL := strSQL + '   COUNT(*) AS QTDE ';
  strSQL := strSQL + ' FROM     ';
  strSQL := strSQL + '   MOVGRO ';
  strSQL := strSQL + ' WHERE    ';
  strSQL := strSQL + '   MGR_ARTIGO = :ARTIGO ';

  With qryGen Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('ARTIGO').AsString := strArt;
    Open;
    Result := FieldByName('QTDE').AsInteger < fCfgSis('QTDREC', varInteger);
  End;

  FreeAndNil(qryGen);

end;

function TCadGro.fProximoNroReceita(strArt: String): Integer;
Var
  strSQL : String;
  qryGen : TUniQuery;
begin

  qryGen := fCriaQuery;
  strSQL := '';
  strSQL := strSQL + ' SELECT   ';
  strSQL := strSQL + '   IFNULL( MAX( MGR_NROREC ), 0 ) AS NROREC ';
  strSQL := strSQL + ' FROM     ';
  strSQL := strSQL + '   MOVGRO ';
  strSQL := strSQL + ' WHERE    ';
  strSQL := strSQL + '   MGR_ARTIGO = :ARTIGO ';

  With qryGen Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('ARTIGO').AsString := strArt;
    Open;
    Result := FieldByName('NROREC').AsInteger + 1;
  End;

  FreeAndNil(qryGen);

end;

function TCadGro.fGravaMovGro(var strSeqMov: String;
                              strNotFis,
                              strDtaFis,
                              strNroRec,
                              strCodCli,
                              strCodRes,
                              strInfAdd,
                              strDtaEmi: String;
                              objFazenda: TDadosFazendaBase = nil): Boolean;
  Var qryMovGro: TUniQuery;
      qryCadCli: TUniQuery;
      qryCadDiv: TUniQuery;
      strIncMov: String;
      strSQL: String;
begin

  Try
    Result := True;

    qryMovGro := fCriarQuery('SELECT * FROM MOVGRO WHERE FALSE');

    qryCadCli := fCriaQuery;
    strSQL    := 'SELECT * FROM CADCLI WHERE CLI_CODCLI = :CODIGO';
    qryCadCli.Close;
    qryCadCli.SQL.Clear;
    qryCadCli.SQL.Add(strSQL);
    qryCadCli.ParamByName('CODIGO').AsString := strCodCli;
    qryCadCli.Open;

    qryCadDiv := fCriaQuery;
    strSQL    := 'SELECT * FROM CADDIV WHERE DIV_CODDIV = :CODIGO';
    qryCadDiv.Close;
    qryCadDiv.SQL.Clear;
    qryCadDiv.SQL.Add(strSQL);
    qryCadDiv.ParamByName('CODIGO').AsString := strCodRes;
    qryCadDiv.Open;

    Try
      strIncMov := fRetAutoIncrem('MOVGRO', strCodEmp);
      strSeqMov := fRetSequencial('PROGRO');

      With qryMovGro Do
      Begin
        If Not Active Then
          Open;

        Insert;

        FieldByName('MGR_NUMREC').AsString   := strSeqMov;
        FieldByName('MGR_CODITE').AsString   := strCodIte;
        FieldByName('MGR_CULTUR').AsString   := strCultur;
        FieldByName('MGR_ARTIGO').AsString   := strArtigo;
        FieldByName('AUTOINCREM').AsString   := strIncMov;
        FieldByName('MGR_CODEMP').AsString   := strCodEmp;
        FieldByName('MGR_DIAGNO').AsString   := strDiagno;
        FieldByName('MGR_NOMCOM').AsString   := strNomCom;
        FieldByName('MGR_GRUQUI').AsString   := strGruQui;
        FieldByName('MGR_CLATOX').AsString   := strClaTox;
        FieldByName('MGR_AREREC').AsString   := strAreRec;
        FieldByName('MGR_PERCAR').AsString   := strPerCar;
        FieldByName('MGR_MANPRA').AsString   := strManPra;
        FieldByName('MGR_CONCEN').AsString   := strConcen;
        FieldByName('MGR_FORMUL').AsString   := strFormul;
        FieldByName('MGR_TOTADQ').AsFloat    := fStrToFloat(strTotAdq);

        FieldByName('MGR_DOSAPL').AsString   := strDosApl;
        FieldByName('MGR_DOSESP').AsString   := strDosEsp;
        FieldByName('MGR_INTAPL').AsString   := strIntApl;
        FieldByName('MGR_NUMAPL').AsInteger  := StrToInt(strNumApl);
        FieldByName('MGR_MODAPL').AsString   := strModApl;
        FieldByName('MGR_EPOAPL').AsString   := strEpoApl;
        FieldByName('MGR_PRIATI').AsString   := strPriAti;
        FieldByName('MGR_ALARME').AsString   := strAlarme;
        FieldByName('MGR_ANTIDO').AsString   := strAntido;
        FieldByName('MGR_OBSERV').AsString   := strObserv;

        {* DADOS DA RECEITA AGRONOMICA *}
        FieldByName('MGR_NOTFIS').AsString   := strNotFis;
        FieldByName('MGR_DTANOT').AsDateTime := StrToDate(strDtaFis);
        FieldByName('MGR_NROREC').AsString   := strNroRec;
        FieldByName('MGR_INFADD').AsString   := strInfAdd;
        FieldByName('MGR_DTAEMI').AsDateTime := StrToDate(strDtaEmi);

        {* DADOS DO CLIENTE *}
        FieldByName('MGR_CODCLI').AsString   := strCodCli;
        FieldByName('MGR_NOMCLI').AsString   := qryCadCli.FieldByName('CLI_NOMCLI').AsString;
        FieldByName('MGR_IESCLI').AsString   := qryCadCli.FieldByName('CLI_I_E_S_').AsString;

        If Assigned(objFazenda) And Not fEmptyStr(objFazenda.strCodFaz) Then
        Begin
          FieldByName('MGR_CODFAZ').AsString   := objFazenda.strCodFaz;

          FieldByName('MGR_ENDCLI').AsString   := objFazenda.strNomFaz;
          FieldByName('MGR_BAICLI').AsString   := 'FAZENDA';
          FieldByName('MGR_INSCLI').AsString   := objFazenda.strNumIes;
          FieldByName('MGR_IESCLI').AsString   := objFazenda.strNumIes;
          FieldByName('MGR_CORGEO').AsString   := objFazenda.strEndCom;

          If objFazenda.intCgcCpf = 2 Then
            FieldByName('MGR_CPFCLI').AsString := objFazenda.strNuCnpj;

          FieldByName('MGR_CIDCLI').AsString   := objFazenda.strNomCid;
          FieldByName('MGR_ESTCLI').AsString   := objFazenda.strEstado;
          FieldByName('MGR_TELCLI').AsString   := objFazenda.strTelCon;
        End
        Else
        Begin
          FieldByName('MGR_CODFAZ').Value      := Null;

          FieldByName('MGR_INSCLI').AsString   := qryCadCli.FieldByName('CLI_I_M_P_').AsString;
          FieldByName('MGR_IESCLI').AsString   := qryCadCli.FieldByName('CLI_I_E_S_').AsString;
          FieldByName('MGR_CPFCLI').AsString := qryCadCli.FieldByName('CLI_C_G_C_').AsString;
          FieldByName('MGR_CIDCLI').AsString   := fRetNomCidade(qryCadCli.FieldByName('CLI_CODCID').AsString, 0);
          FieldByName('MGR_ESTCLI').AsString   := fRetNomCidade(qryCadCli.FieldByName('CLI_CODCID').AsString, 1);
          FieldByName('MGR_ENDCLI').AsString   := qryCadCli.FieldByName('CLI_ENDERE').AsString;
          FieldByName('MGR_BAICLI').AsString   := qryCadCli.FieldByName('CLI_BAIRRO').AsString;
          FieldByName('MGR_TELCLI').AsString   := qryCadCli.FieldByName('CLI_FONE01').AsString;
          FieldByName('MGR_CORGEO').AsString   := qryCadCli.FieldByName('CLI_ENDCOM').AsString;

          If fEmptyStr(FieldByName('MGR_TELCLI').AsString) Then
            FieldByName('MGR_TELCLI').AsString   := qryCadCli.FieldByName('CLI_FONE02').AsString;

          If fEmptyStr(FieldByName('MGR_TELCLI').AsString) Then
            FieldByName('MGR_TELCLI').AsString   := qryCadCli.FieldByName('CLI_CELULA').AsString;
        End;

        {* DADOS DO RESPONSÁVEL *}
        FieldByName('MGR_CODRES').AsString   := strCodRes;
        FieldByName('MGR_NOMRES').AsString   := qryCadDiv.FieldByName('DIV_NOMDIV').AsString;
        FieldByName('MGR_ENDRES').AsString   := qryCadDiv.FieldByName('DIV_ENDERE').AsString;

        If qryCadDiv.FieldByName('DIV_CGCCPF').AsString = '2' Then
          FieldByName('MGR_CPFRES').AsString := qryCadDiv.FieldByName('DIV_C_G_C_').AsString;

        FieldByName('MGR_CIDRES').AsString   := fRetNomCidade(qryCadDiv.FieldByName('DIV_CODCID').AsString, 0);
        FieldByName('MGR_ESTRES').AsString   := fRetNomCidade(qryCadDiv.FieldByName('DIV_CODCID').AsString, 1);
        FieldByName('MGR_TELRES').AsString   := qryCadDiv.FieldByName('DIV_FONE01').AsString;
        FieldByName('MGR_NUMCRE').AsString   := qryCadDiv.FieldByName('DIV_NUMCRE').AsString;

        Post;

      End;

    Except
      On E: Exception Do
      Begin
        Result := False;
        qryMovGro.Cancel;
        pMensagensErro(E.Message, '[fGravaMovGro]');
      End;
    End;

  Finally
    FreeAndNil(qryCadDiv);
    FreeAndNil(qryCadCli);
    FreeAndNil(qryMovGro);
  End;

end;

end.

