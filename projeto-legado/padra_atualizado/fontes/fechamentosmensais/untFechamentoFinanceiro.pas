unit untFechamentoFinanceiro;

interface

Uses
  Uni, DB, Classes,
  CxProgressBar,
  UniClientDataSet,
  UniDataSetProvider,
  StdCtrls,
  untTFecFinRepository,
  untTypesSistema;

Type
  TTipoTravaFinanceiro = (trfFechamento, trfMovimentacao);

  TFechamentoFinanceiro = Class
  Private
    FNomeFormulario : String;
    FTravou: Boolean;
    FblnContabilidade: Boolean;

    FQryUltimoFechamento: TUniQuery;
    FQryUltimo24Fechamento: TUniQuery;

    Procedure IncluirFechamento(ACodigoEmpresa: String; ADataReferenciaFechamento: TDate);
    Procedure ExcluirFechamento(ACodigoEmpresa: String; ADataReferenciaFechamento: TDate);
    class procedure InfoStatusGravacao(strInformacao: String; pgbProgresso: TcxProgressBar);
  Public
    AUltEmpFechada   : String;

    constructor Create(Owner: TComponent; ANomeFormulario : String); Reintroduce;
    Destructor  Destroy; Override;

    function  CarregaUltimoFechamentoTodasEmpresas(Var AcdsUltimoFec: TUniClientDataSet; Var AdspUltimoFec: TUniDataSetProvider; pgbProgresso: TCxProgressBar): Boolean;
    function  CarregaUltimos24Fechamentos(Var AcdsUltimo24Fechamento: TUniClientDataSet; Var AdspUltimo24Fec: TUniDataSetProvider; pgbProgresso: TCxProgressBar): Boolean;
    Procedure GetUltimoFechamento(ACodigoEmpresa: String; Var ADataReferenciaFechamento: TDate);
    Function  IncluiFechamento(ACodigoEmpresa: String; ADataReferenciaFechamento: TDate): Boolean; Overload;
    Function  IncluiFechamento(ACodigoEmpresa: Array Of TConsultas; ADataReferenciaFechamento: TDate): Boolean; Overload;
    Function  ExcluiFechamento(ACodigoEmpresa: String; ADataReferenciaFechamento: TDate): Boolean;
    Class Function DataFechamento(ACodigoEmpresa: String = ''): TDateTime;
    Class Function DataFiscalPermitida(ADataEnt: TDate; ANomeData: String = 'de entrada'; AMsgAviso: Boolean = True; ACodigoEmpresa: String = ''): Boolean;
    Function  VeSeTravaFechamentoFinanceiro(traTipoFechamento: TTipoTravaFinanceiro; ADataEnt: TDateTime; ACodigoEmpresa: String = ''): Boolean;
    Procedure DestravaFechamentoFinanceiro(traTipoFechamento: TTipoTravaFinanceiro; ACodigoEmpresa: String = '');
    function  FechamentoFinanceiroJaRealizado(ACodigoEmpresa: String; ADataReferenciaFechamento: TDate; AExibirMensagem: Boolean = True): Boolean;
    function  EncontraMaiorFechamento(ACodigoEmpresa: String): TDateTime;

    Class Function TipoFechamentoToString(traTipoFechamento: TTipoTravaFinanceiro): String;
    property Contabilidade: Boolean read FblnContabilidade write FblnContabilidade ;
  End;

Const
  STR_MOVIMENTACAO_FINANCEIRA = 'MOVIMENTACAO_FINANCEIRA_';

  SQLUltimos24Registros = ' SELECT F.*, OPE_NOMOPE AS NOMOPE, CAST("N" AS CHAR(1)) AS FECCNT  '+
                          '   FROM FECFIN F '+
                          '  INNER JOIN CADOPE ON OPE_CODOPE = FEC_CODOPE '+
                          '  WHERE FEC_CODEMP = :CODEMP '+
                          ' ORDER BY FEC_DTAREF DESC LIMIT 24 ';

  SQLUtimoFechamentoEmpresas =  ' SELECT F.*, EMP_NOMEMP AS NOMEMP '+
                                 '  FROM FECFIN F '+
                                 '  INNER JOIN CADEMP ON EMP_CODEMP = FEC_CODEMP '+
                                 '  INNER JOIN (  '+
                                 '    SELECT FEC_CODEMP, MAX(FEC_DTAREF) AS FEC_DTAREF  '+
                                 '    FROM FECFIN  '+
                                 '    GROUP BY FEC_CODEMP ) AS M ON M.FEC_CODEMP = F.FEC_CODEMP AND M.FEC_DTAREF = F.FEC_DTAREF ';

implementation

Uses
  SysUtils,
  StrUtils,
  DateUtils,
  Forms,
  untFuncoesSimples,
  untGravando,
  untTFecFin ;

constructor TFechamentoFinanceiro.Create(Owner: TComponent; ANomeFormulario : String);
Begin
  Inherited Create;
  FTravou          := False;
  FblnContabilidade := False;
  AUltEmpFechada   := '';
  FNomeFormulario  := ANomeFormulario;
  FQryUltimoFechamento   := fCriaQuery;
  FQryUltimo24Fechamento := fCriaQuery;
End;

Destructor TFechamentoFinanceiro.Destroy;
Begin
  FreeAndNilDatasets(FQryUltimoFechamento);
  FreeAndNilDatasets(FQryUltimo24Fechamento);

  inherited Destroy;
End;

function TFechamentoFinanceiro.CarregaUltimoFechamentoTodasEmpresas(Var AcdsUltimoFec: TUniClientDataSet; Var AdspUltimoFec: TUniDataSetProvider; pgbProgresso: TCxProgressBar): Boolean;
Begin
  Try
    if (pgbProgresso <> nil) then
      InfoStatusGravacao('Aguarde...Carregando último fechamento de cada empresa. ', pgbProgresso);

    FQryUltimoFechamento.Close;
    FQryUltimoFechamento.SQL.Clear;
    FQryUltimoFechamento.SQL.Text := SQLUtimoFechamentoEmpresas;
    FQryUltimoFechamento.Open;
    pSetaClient(FQryUltimoFechamento);

    AdspUltimoFec.DataSet := FQryUltimoFechamento;
    AcdsUltimoFec.SetProvider(AdspUltimoFec);

    AcdsUltimoFec.Close;
    AdspUltimoFec.DataSet := FQryUltimoFechamento;
    AcdsUltimoFec.SetProvider(AdspUltimoFec);
    AcdsUltimoFec.Open;
    pSetaClient(AcdsUltimoFec);
    Result := True;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, 'TFechamentoFinanceiro.CarregaUltimoFechamentoTodasEmpresas');
    End;
  End;
End;

function TFechamentoFinanceiro.CarregaUltimos24Fechamentos(Var AcdsUltimo24Fechamento: TUniClientDataSet; Var AdspUltimo24Fec: TUniDataSetProvider; pgbProgresso: TCxProgressBar): Boolean;
  Var
    qryCadEmp,
    qryCadFec: TUniQuery;
    intContador: Integer;
Begin
  qryCadFec := fCriaQuery;
  qryCadFec.SQL.Text := SQLUltimos24Registros;

  Try
    if (pgbProgresso <> nil) then
      InfoStatusGravacao('Aguarde...Carregando últimos 24 fechamentos. ', pgbProgresso);

    FQryUltimo24Fechamento.Close;
    FQryUltimo24Fechamento.SQL.Clear;
    FQryUltimo24Fechamento.SQL.Text := SQLUltimos24Registros;
    FQryUltimo24Fechamento.Open;
    pSetaClient(FQryUltimo24Fechamento);

    AdspUltimo24Fec.DataSet := FQryUltimo24Fechamento;
    AcdsUltimo24Fechamento.SetProvider(AdspUltimo24Fec);

    AcdsUltimo24Fechamento.Close;
    AdspUltimo24Fec.DataSet := FQryUltimo24Fechamento;
    AcdsUltimo24Fechamento.SetProvider(AdspUltimo24Fec);
    AcdsUltimo24Fechamento.Open;
    pSetaClient(AcdsUltimo24Fechamento);

    qryCadEmp := fCriaQuery;
    qryCadEmp.SQL.Text := 'SELECT EMP_CODEMP FROM CADEMP';
    qryCadEmp.Open;

    if (pgbProgresso <> nil) then
      pgbProgresso.Properties.Max := qryCadEmp.RecordCount;

    While Not qryCadEmp.Eof Do
    Begin
      qryCadFec.Close;
      qryCadFec.ParamByName('CODEMP').AsString := qryCadEmp.FieldByName('EMP_CODEMP').AsString;
      qryCadFec.Open;

      While Not qryCadFec.Eof Do
      Begin
        AcdsUltimo24Fechamento.Append;

        For intContador := 0 To qryCadFec.FieldCount - 1 Do
          AcdsUltimo24Fechamento.Fields[intContador].Value := qryCadFec.Fields[intContador].Value;

        if Assigned(VS_objTemFecMes) then
          AcdsUltimo24Fechamento.FieldByName('FECCNT').AsString := IfThen(VS_objTemFecMes(AcdsUltimo24Fechamento.FieldByName('FEC_CODEMP').AsString, AcdsUltimo24Fechamento.FieldByName('FEC_DTAREF').AsDateTime), 'S', 'N')
        else
          AcdsUltimo24Fechamento.FieldByName('FECCNT').AsString := 'N' ;
        AcdsUltimo24Fechamento.Post;

        qryCadFec.Next;
      End;

      if (pgbProgresso <> nil) then
      begin
        pgbProgresso.Position := pgbProgresso.Position + 1;
        Application.ProcessMessages;
      end ;

      qryCadEmp.Next;
    End;
    FreeAndNil(qryCadFec);
    Result := True;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, 'TFechamentoFinanceiro.CarregaUltimos24Fechamentos');
    End;
  End;
End;

Procedure TFechamentoFinanceiro.GetUltimoFechamento(ACodigoEmpresa: String; Var ADataReferenciaFechamento: TDate);
  Var
    qryCadFec: TUniQuery;
begin
  ADataReferenciaFechamento := 0;

  qryCadFec := fCriaQuery;
  qryCadFec.SQL.Text := 'SELECT MAX(FEC_DTAREF) AS DTAREF FROM FECFIN WHERE FEC_CODEMP = :CODEMP';
  qryCadFec.ParamByName('CODEMP').AsString := ACodigoEmpresa;
  qryCadFec.Open;

  If Not qryCadFec.IsEmpty Then
    ADataReferenciaFechamento := qryCadFec.FieldByName('DTAREF').AsDateTime;

  FreeAndNil(qryCadFec);
End;

//INCLUSÃO PARA MULTI EMPRESA
function TFechamentoFinanceiro.IncluiFechamento(ACodigoEmpresa: Array Of TConsultas; ADataReferenciaFechamento: TDate): Boolean;
Var
  dtaUltFecha: TDate;
  AIndice: Integer;
Begin
  Try
    Result := False;

    For AIndice := Low(ACodigoEmpresa) To High(ACodigoEmpresa) Do
    begin
      If VeSeTravaFechamentoFinanceiro(trfFechamento, 0, ACodigoEmpresa[AIndice].strCodigo) Then
      Begin
        Try
          if not FblnContabilidade then
          begin
            GetUltimoFechamento(ACodigoEmpresa[AIndice].strCodigo, dtaUltFecha);

            If dtaUltFecha >= ADataReferenciaFechamento Then
            begin
              pMensagemOk('O fechamento sugerido deve ser maior que o último fechamento realizado (' + FormatDateTime('DD/MM/YYYY', dtaUltFecha) + ')!');
              Exit;
            End;

          end ;

          fStartTransaction;
          IncluirFechamento(ACodigoEmpresa[AIndice].strCodigo, ADataReferenciaFechamento);
          fCommit;

          Result := True;
          AUltEmpFechada := ACodigoEmpresa[AIndice].strCodigo;
        Except
          On E: Exception Do
          Begin
            Result := False;
            fRollBack;
            pMensagensErro(E.Message, 'TFechamentoFinanceiro.IncluiFechamento');
          End;
        End;
        DestravaFechamentoFinanceiro(trfFechamento, ACodigoEmpresa[AIndice].strCodigo);
      End;
    end;
  Finally
    //DestravaFechamentoFinanceiro(trfFechamento, ACodigoEmpresa[AIndice].strCodigo);
  End;
end;

Procedure TFechamentoFinanceiro.IncluirFechamento(ACodigoEmpresa: String; ADataReferenciaFechamento: TDate);
Var
  SFechamentoFinanceiro : TFecFin;
  FFechamentoFinanceiroRepository : TFecFinRepository;
Begin
  try
    SFechamentoFinanceiro := TFecFin.Create;
    FFechamentoFinanceiroRepository := TFecFinRepository.Create;

    SFechamentoFinanceiro.AutoIncremento   := fRetAutoIncrem('FECFIN', VS_strCodEmp);
    SFechamentoFinanceiro.CodigoEmpresa    := ACodigoEmpresa;
    SFechamentoFinanceiro.CodigoOperador   := strLoginUsuarioLogado;
    SFechamentoFinanceiro.Data             := VS_Date;
    SFechamentoFinanceiro.DataReferenciada := ADataReferenciaFechamento;
    SFechamentoFinanceiro.Hora             := fTime();

    if Assigned(SFechamentoFinanceiro) then
      FFechamentoFinanceiroRepository.pInserir(SFechamentoFinanceiro, FNomeFormulario);
  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;
End;

class procedure TFechamentoFinanceiro.InfoStatusGravacao(strInformacao: String;
  pgbProgresso: TcxProgressBar);
begin
  If Assigned(pgbProgresso) And (GetParentForm(pgbProgresso).FindComponent('lblGravando') <> Nil) Then
  Begin
    TLabel(GetParentForm(pgbProgresso).FindComponent('lblGravando')).Caption := strInformacao;
    Application.ProcessMessages;
  End;
end;

Class Function TFechamentoFinanceiro.TipoFechamentoToString(traTipoFechamento: TTipoTravaFinanceiro): String;
Begin
  Case traTipoFechamento Of
    trfFechamento: Result := 'FECHAMENTO';
    else           Result := 'MOVIMENTACAO';
  End;
End;

Function TFechamentoFinanceiro.VeSeTravaFechamentoFinanceiro(traTipoFechamento: TTipoTravaFinanceiro; ADataEnt: TDateTime; ACodigoEmpresa: String = ''): Boolean;
Begin
  FTravou := False;
  Result  := True;

  If (traTipoFechamento = trfFechamento) Or (ADataEnt = 0) Or (ADataEnt < VS_Date) Then
  Begin

    If ACodigoEmpresa.IsEmpty Then
      ACodigoEmpresa := VS_strCodEmp;

    Result := fLock_Unlock(STR_MOVIMENTACAO_FINANCEIRA + ACodigoEmpresa,
                           True,
                           False,
                           False, {blnHourGlass: Boolean = FALSE;}
                           '',    {strCon_Id: String = '';}
                           True,  {blnMostraMsgTravamento: Boolean = True;}
                           TipoFechamentoToString(traTipoFechamento));

    If Result Then
    Begin
      FTravou := True;

      If (traTipoFechamento = trfMovimentacao) And (ADataEnt <> 0) And (Not DataFiscalPermitida(ADataEnt)) Then
      Begin
        Result := False;
        DestravaFechamentoFinanceiro(traTipoFechamento, ACodigoEmpresa);
      End;

    End
    Else
      pMensagemOk('O fechamento fiscal dessa empresa ou uma movimentação fiscal já está sendo feito em outra estação: ' + fGetHostLock(STR_MOVIMENTACAO_FINANCEIRA + ACodigoEmpresa));
  End;
End;

Procedure TFechamentoFinanceiro.DestravaFechamentoFinanceiro(traTipoFechamento: TTipoTravaFinanceiro; ACodigoEmpresa: String = '');
Begin
  If FTravou Then
  Begin

    If ACodigoEmpresa.IsEmpty Then
      ACodigoEmpresa := VS_strCodEmp;

    If fLock_Unlock(STR_MOVIMENTACAO_FINANCEIRA + ACodigoEmpresa,
                 False,
                 False,
                 False, {blnHourGlass: Boolean = FALSE;}
                 '',    {strCon_Id: String = '';}
                 True,  {blnMostraMsgTravamento: Boolean = True;}
                 TipoFechamentoToString(traTipoFechamento)) Then
     FTravou := False;

  End;
End;

//INCLUSÃO PARA SOMENTE UMA EMPRESA
Function TFechamentoFinanceiro.IncluiFechamento(ACodigoEmpresa: String; ADataReferenciaFechamento: TDate): Boolean;
  Var
    dtaUltFecha: TDate;
Begin
  Try
    Result := False;

    If VeSeTravaFechamentoFinanceiro(trfFechamento, 0, ACodigoEmpresa) Then
    Begin
      Try
        if not FblnContabilidade then
        begin
          GetUltimoFechamento(ACodigoEmpresa, dtaUltFecha);

          If dtaUltFecha >= ADataReferenciaFechamento Then
          begin
            pMensagemOk('O fechamento sugerido deve ser maior que o último fechamento realizado (' + FormatDateTime('DD/MM/YYYY', dtaUltFecha) + ')!');
            Exit;
          End;

        End ;

        fStartTransaction;
        IncluirFechamento(ACodigoEmpresa, ADataReferenciaFechamento);
        fCommit;

        Result := True;
        AUltEmpFechada := ACodigoEmpresa;
      Except
        On E: Exception Do
        Begin
          Result := False;
          fRollBack;
          pMensagensErro(E.Message, 'TFechamentoFinanceiro.IncluiFechamento');
        End;
      End;
    End;
  Finally
    DestravaFechamentoFinanceiro(trfFechamento, ACodigoEmpresa);
  End;
End;

Procedure TFechamentoFinanceiro.ExcluirFechamento(ACodigoEmpresa: String; ADataReferenciaFechamento: TDate);
Var
  ObjFechamentoFinanceiro : TFecFin;
  ObjFechamentoFinanceiroRep: TFecFinRepository;
Begin
  Try
    ObjFechamentoFinanceiroRep := TFecFinRepository.Create;
    ObjFechamentoFinanceiro    := ObjFechamentoFinanceiroRep.fRetornaFechamento(ACodigoEmpresa, ADataReferenciaFechamento);

    If Assigned(ObjFechamentoFinanceiro) Then
      ObjFechamentoFinanceiroRep.pDeletar(ObjFechamentoFinanceiro, FNomeFormulario);
  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;

  If Assigned(ObjFechamentoFinanceiroRep) Then
    FreeandNil(ObjFechamentoFinanceiroRep);
End;

function TFechamentoFinanceiro.EncontraMaiorFechamento(ACodigoEmpresa: String): TDateTime;
Var
  qryBuscaMaiorFec: TUniQuery;
begin
  qryBuscaMaiorFec := Nil;
  Try
    qryBuscaMaiorFec := fCriaQuery;
    qryBuscaMaiorFec.SQL.Add('SELECT MAX(FEC_DTAREF) AS MAIOR_FECHAMENTO ');
    qryBuscaMaiorFec.SQL.Add('FROM FECFIN ');
    qryBuscaMaiorFec.SQL.Add('WHERE FEC_CODEMP = :CODEMP ');
    qryBuscaMaiorFec.ParamByName('CODEMP').AsString := ACodigoEmpresa;
    qryBuscaMaiorFec.Open;

    if not qryBuscaMaiorFec.IsEmpty Then
      Result := qryBuscaMaiorFec.FieldByName('MAIOR_FECHAMENTO').AsDateTime
    else
      Result := 0;
  Finally
    FreeAndNilDatasets(qryBuscaMaiorFec);
  end;
end;

Function TFechamentoFinanceiro.ExcluiFechamento(ACodigoEmpresa: String; ADataReferenciaFechamento: TDate): Boolean;
Begin
  Try
    Result := False;

    If VeSeTravaFechamentoFinanceiro(trfFechamento, 0, ACodigoEmpresa) Then
    Begin
      Try
        fStartTransaction;
        ExcluirFechamento(ACodigoEmpresa, ADataReferenciaFechamento);
        fCommit;

        Result := True;
        AUltEmpFechada := ACodigoEmpresa;
      Except
        On E: Exception Do
        Begin
          Result := False;
          fRollBack;
          pMensagensErro(E.Message, 'TFechamentoFinanceiro.ExcluiFechamento');
        End;
      End;
    End;
  Finally
    DestravaFechamentoFinanceiro(trfFechamento, ACodigoEmpresa);
  End;
End;

Class Function TFechamentoFinanceiro.DataFiscalPermitida(ADataEnt: TDate; ANomeData: String = 'de entrada'; AMsgAviso: Boolean = True; ACodigoEmpresa: String = ''): Boolean;
Var
  ADataReferenciaFechamento: TDate;
Begin
  Try
    ADataReferenciaFechamento := DataFechamento(ACodigoEmpresa);
    Result := ADataEnt > ADataReferenciaFechamento;

    If (Not Result) And AMsgAviso Then
       pMensagemOk('A data ' + ANomeData + ' deve ser maior que a do último fechamento de fiscal (' + FormatDateTime('DD/MM/YYYY', ADataReferenciaFechamento) + ')!');
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TFechamentoFinanceiro.DataFiscalPermitida]');
    End;
  End;
End;

function TFechamentoFinanceiro.FechamentoFinanceiroJaRealizado(ACodigoEmpresa: String; ADataReferenciaFechamento: TDate; AExibirMensagem: Boolean = True): Boolean;
var
  qryBuscaFechamento: TUniQuery;
  AMaiorFechamento: TDateTime;
begin
  qryBuscaFechamento := Nil;
  Try
    qryBuscaFechamento := fCriaQuery;
    AMaiorFechamento := EncontraMaiorFechamento(ACodigoEmpresa);

    if (AMaiorFechamento <> 0) and (ADataReferenciaFechamento <> 0) Then
    begin
      if (ADataReferenciaFechamento <= AMaiorFechamento)  then
      begin

        qryBuscaFechamento.Close;
        qryBuscaFechamento.SQL.Clear;
        qryBuscaFechamento.SQL.Add(' SELECT COUNT(AUTOINCREM) AS QUANTIDADE ');
        qryBuscaFechamento.SQL.Add(' FROM ( ');
        qryBuscaFechamento.SQL.Add(' SELECT AUTOINCREM, ');
        qryBuscaFechamento.SQL.Add('        FEC_CODEMP, ');
        qryBuscaFechamento.SQL.Add('        FEC_CODOPE, ');
        qryBuscaFechamento.SQL.Add('        FEC_DTAFEC, ');
        qryBuscaFechamento.SQL.Add('        FEC_DTAREF, ');
        qryBuscaFechamento.SQL.Add('        FEC_HORFEC  ');
        qryBuscaFechamento.SQL.Add(' FROM FECFIN        ');
        qryBuscaFechamento.SQL.Add(' WHERE FEC_CODEMP = :CODEMP AND ');
        qryBuscaFechamento.SQL.Add('       FEC_DTAREF = :DATAFECHAMENTO ');
        qryBuscaFechamento.SQL.Add(' ) AS TABELA ');
        qryBuscaFechamento.ParamByName('CODEMP').AsString := ACodigoEmpresa;
        qryBuscaFechamento.ParamByName('DATAFECHAMENTO').AsDateTime := AMaiorFechamento;
        qryBuscaFechamento.Open;

        If qryBuscaFechamento.FieldByName('QUANTIDADE').AsInteger > 0 then
        begin
          if AExibirMensagem then
            fMensagem('ATENÇÃO!','Não será possível fazer movimentação financeira, pois existe fechamento financeiro para a empresa.' +#13+#10+
                                 'Empresa: ' + ACodigoEmpresa +  ' - ' + 'Último Fechamento: ' + FormatDateTime('DD/MM/YYYY', AMaiorFechamento), ['&Ok']);
          Result := True;
        end
        else
          Result := False;
      end
      Else
        Result := False;
    end
    else
      Result := False;
  Finally
    FreeAndNilDatasets(qryBuscaFechamento);
  end;
end;

Class Function TFechamentoFinanceiro.DataFechamento(ACodigoEmpresa: String = ''): TDateTime;
  Var
    qryCadFec: TUniQuery;
Begin
  Try
    If ACodigoEmpresa.IsEmpty Then
      ACodigoEmpresa := VS_strCodEmp;

    qryCadFec := fCriaQuery;
    qryCadFec.SQL.Text := 'SELECT MAX(FEC_DTAREF) AS DTAREF FROM FECFIN WHERE FEC_CODEMP = :CODEMP';
    qryCadFec.ParamByName('CODEMP').AsString := ACodigoEmpresa;
    qryCadFec.Open;

    If qryCadFec.IsEmpty Or qryCadFec.FieldByName('DTAREF').IsNull Then
    Begin
      Result := 0
    End Else
    Begin

      Result := qryCadFec.FieldByName('DTAREF').AsDateTime

    End;

    FreeAndNil(qryCadFec);

  Except
    On E: Exception Do
    Begin
      Result := VS_Date;
      pMensagensErro(E.Message, '[TFechamentoFinanceiro.DataFechamento]');
    End;
  End;
End;


end.
