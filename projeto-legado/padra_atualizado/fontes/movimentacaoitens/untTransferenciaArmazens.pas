unit untTransferenciaArmazens;

interface

uses
  StrUtils, SysUtils, Classes, Forms, DB, untTypesSistema, Variants,
  Uni, Controls, EditFocus, UniClientDataSet, Math, ComCtrls, untCadLote,
  untAuditoriaGravacaoSaldo, untEnderecamentoProduto,

  Fulfillment.RegrasMovimentacaoEstoque,
  Fulfillment.Classes.Parametros,
  Fulfillment.Classes.MercadoLivre;

Type
  TopcEdits = (opcLimpar, opcEditar, opcGravar);

  TOnBeforeCommit = procedure of object;

  TTransferenciaArmazens = Class(TComponent)
  Private
    FblnEndLocal: Boolean;
    blnCadLoc    : Boolean;
    FCadLot      : TCadLot;
    FCodCli      : String;
    strAutInc    : String;
    dtaDtaEnt    : TDateTime;
    strClaFis    : String;
    strAutIncDet : String;
    strArqMovGer : String;
    strArqMovDet : String;
    FSeqOri      : String;
    qryInsert: TUniQuery;

    FTransf,
    FInsert,
    FCopDad: TUniClientDataSet;
    FdtsTra: TDataSource;

    FCodOpe,
    FEspDoc,
    FNumDoc,
    FMsg001,
    FMsg002: String;

    FProgre: TProgressBar;

    FQtdCur: Double; // QUANTIDA ORIGINAL DO REGISTRO CORRENTE

    FLimparFiltros: Boolean;
    FSomarQuantidade: Boolean;
    FOnBeforeCommit: TOnBeforeCommit;

    FDocFat: String;
    FEspFat: String;
    FEmpFat: String;
    FCliFat: String;

    objAuditoriaSaldo     : IAuditoriaGravacaoSaldo;
    FMostraErrosAuditoria : Boolean;
    FMSGErrosAuditoria    : String;
    FArmOri: String;
    FIteAca: String;
    FArmazens: TUniQuery;

    FFulfillment : TFulfillment;

    Function fGravaMovGerTransf: Boolean;
    Function fGravaMovDetTransf(Var strMensagem: String;  var strSequencial: String): Boolean;
    Function fTotalGeral: Double;
    Function fSQLItem: String;

    Function fSomaTotalTransferido(strCampo, strCodIte, strArmaze: String;
           fltQtdIte: Double; blnInclusao: Boolean): Double;

    Function fCarregaDadosEntrada(strNumDoc,
                                  strEspDoc,
                                  strCodEmp,
                                  strSerie_,
                                  strCodFor,
                                  strCodIte: String;
                                  Var fltPreUlt, fltImpUlt: Double;
                                  Var dtaDtaEnt: TDateTime): Boolean;

    Procedure pCancela(csdClient: TUniClientDataSet);
    Procedure pCopiaRegistro;
    Procedure pInsertTransf;
    Procedure pFormataCampos(cdsClient: TUniClientDataSet);
    Procedure pSomaQuantidadeProduto;
    Function fSomarQuantidadeProduto: Boolean;

    function fEhSaida   : Boolean;
    function fLote(blnInvertido: boolean = False): String;

  Public
    BloqueiaLoteOrigem: Boolean;
    endDocumento: TEndDocumento;
    blnFilkar: Boolean;
    strObservacao: string;
    objEnderecamentoProduto : TEnderecamentoProduto;
    function fGeraTransferenciaProdutoAcabado(blnUsaLote, blnControlaTransacao,
      blnGerarReserva: Boolean): TTransferenciaArmazens;
    function fValidarArmazemDestino: TTransferenciaArmazens;

    Procedure pEditaItem;
    procedure pBloqueiaArmazemOrigem(AAmzOri: String; ACodIte: String; ABloqueio: Boolean);
    Procedure pSalvaItem;
    procedure pCarregarArmazens(strCodIte, strCodArm: String);
    Procedure pCancelaEdicaoItem(opcEdits: TopcEdits = opcLimpar);
    procedure pDeleteRegistroCopia(strCodIte,  strArmzOri, strArmzDes: String);

    procedure pSetaArmazenDestino(const strArmDes: String);

    Procedure pImprimeTranferencia;

    Function fCarregaArmazem(blnOrigem: Boolean; strLocFis: String): Boolean;
    procedure pCarregarArmazemProdutoAcabado;

    Function fGeraTransferencia(blnUsaLote : Boolean; blnControlaTransacao : Boolean; blnGerarReserva: Boolean = False): Boolean;
    procedure pInsererelacionamentoEntradaComSaida(SeqGer, SeqSai, SeqEnt: String);

    Function fSomaTotalTransferidoOrigem(strCodIte, strArmaze: String;
                       fltQtdIte: Double; blnInclusao: Boolean): Double;

    Function fSomaTotalTransferidoDestino(strCodIte, strArmaze: String;
                       fltQtdIte: Double; blnInclusao: Boolean): Double;

    Constructor Create(Owner: TComponent;
                       cdsTransf: TUniClientDataSet;
                       dtsTransf: TDataSource;
                       prbProgre: TProgressBar); Reintroduce;

    Destructor  Destroy; Override;

    Property strCodOpe: String Read FCodOpe Write FCodOpe;
    Property strEspDoc: String Read FEspDoc;
    Property strNumDoc: String Read FNumDoc;
    Property strCodCli: String Read FCodCli;
    Property strSeqOri: String Read FSeqOri Write FSeqOri;
    property strAutIncRetorno : String Read strAutInc;
    property strMsg001: String Read FMsg001 Write FMsg001;
    property strMsg002: String Read FMsg002 Write FMsg002;
    property blnLimparFiltros: Boolean Read FLimparFiltros Write FLimparFiltros;
    property blnSomarQuantidade: Boolean Read FSomarQuantidade Write FSomarQuantidade;

    property strDocFat: String Read FDocFat Write FDocFat;
    property strEspFat: String Read FEspFat Write FEspFat;
    property strEmpFat: String Read FEmpFat Write FEmpFat;
    property strCliFat: String Read FCliFat Write FCliFat;

    property MostraErrosAuditoria : Boolean Read FMostraErrosAuditoria Write FMostraErrosAuditoria;
    property MSGErrosAuditoria    : String  Read FMSGErrosAuditoria;
    property strArmOri: String Read FArmOri Write FArmOri;
    property strIteAca: String Read FIteAca Write FIteAca;
    property qryArmazens: TUniQuery read FArmazens;

    property Fulfillment : TFulfillment Read FFulfillment Write FFulfillment;
    property OnBeforeCommit: TOnBeforeCommit write FOnBeforeCommit;

  end;

  procedure pCriaDataSetItensTL(var ACds: TUniClientDataSet);

implementation

Uses
  untMovGer, untFuncoesSimples, untReimpressao, untPcmger, untConstantes,
  untTFatReservaSaldo, untCadIte,

  Fulfillment.Funcoes,
  Fulfillment.Types;

Const
  STR_CLAENT = '1999';
  STR_CLASAI = '5999';

constructor TTransferenciaArmazens.Create(Owner: TComponent;
          cdsTransf: TUniClientDataSet; dtsTransf: TDataSource;
          prbProgre: TProgressBar);
begin
  inherited Create(Owner);
  BloqueiaLoteOrigem := False;
  FArmazens := fCriaQuery(Owner);
  qryInsert := fCriaQuery(Owner);
  FillChar(endDocumento, Sizeof(endDocumento), #0);
  blnFilKar         := False;

  FLimparFiltros    := True;
  FSomarQuantidade  := False;

  FTransf           := cdsTransf;
  FdtsTra           := dtsTransf;
  FInsert           := TUniClientDataSet.Create(Self);
  FInsert.Data      := FTransf.Data;

  If Assigned(dtsTransf) Then
  Begin
    dtsTransf.DataSet := FInsert;
    pFormataCampos(FTransf);
    pFormataCampos(FInsert);
  End;

  FProgre := prbProgre;
  FCadLot := TCadLot.Create(Self);
  FCodCli := fCfgSis('CLI_TA');
  FQtdCur := 0;

  blnCadLoc := fCfgSis('CADLOC', varBoolean);

  FCopDad := TUniClientDataSet.Create(Self);
  FCopDad.Data := FTransf.Data;

  objAuditoriaSaldo     := TAuditoriaGravacaoSaldo.New;
  FMostraErrosAuditoria := True;
  FMSGErrosAuditoria    := '';

  FFulfillment := TFulfillment.New;

end;

Procedure TTransferenciaArmazens.pCopiaRegistro;
  Var
    intContador: Integer;
Begin
  With FInsert Do
  Begin
    If IsEmpty Then
      Exit;

    If fEmptyStr(FieldByName('CODITE').AsString) Then
      Exit;

    FTransf.Append;

    For intContador := 0 To Fields.Count - 1 Do
      FTransf.Fields[intContador].Value := Fields[intContador].Value;

    FTransf.Post;
    If BloqueiaLoteOrigem then
      pBloqueiaArmazemOrigem(FTransf.FieldByName('ARMORI').AsString,
                             FTransf.FieldByName('CODITE').AsString,
                             True);

    FCopDad.Data := FTransf.Data;

    If Not FLimparFiltros Then
      Exit;

    EmptyDataSet;
  End;

End;

procedure TTransferenciaArmazens.pDeleteRegistroCopia(strCodIte,  strArmzOri, strArmzDes: string);
begin
  If FCopDad.Locate('CODITE;ARMORI;ARMDES', VarArrayOf([strCodIte, strArmzOri, strArmzDes]), []) Then
    FCopDad.Delete;
  If BloqueiaLoteOrigem then
  Begin   
    FCopDad.First;
    If Not FCopDad.Locate('CODITE;ARMORI', VarArrayOf([strCodIte, strArmzOri]), []) Then
      pBloqueiaArmazemOrigem(strArmzOri, strCodIte, False)
  End;
end;

procedure TTransferenciaArmazens.pInsererelacionamentoEntradaComSaida(SeqGer,
  SeqSai,SeqEnt : String);
begin
  qryInsert.SQL.Clear;
  qryInsert.SQL.Add('INSERT INTO TRAREL (TRA_SEQSAI, TRA_SEQENT,  TRA_SEQGER) VALUES (:SEQSAI, :SEQENT, :SEQGER)');
  qryInsert.ParamByName('SEQSAI').AsString := SeqSai;
  qryInsert.ParamByName('SEQENT').AsString := SeqEnt;
  qryInsert.ParamByName('SEQGER').AsString := SeqGer;
  qryInsert.ExecSQL;
end;

Procedure TTransferenciaArmazens.pInsertTransf;
Begin
  pCancela(FTransf);
  If FLimparFiltros Then
    pCancela(FInsert);

  With FInsert Do
  Begin
    If FLimparFiltros Then
    Begin
      Insert;
      FieldByName('QTDITE').AsFloat  := 0;
    End;
  End;

  FdtsTra.DataSet := FInsert;
End;

Procedure TTransferenciaArmazens.pSalvaItem;
Begin
  If FTransf.State = dsEdit Then
  Begin
    pSomaQuantidadeProduto;
    FTransf.Post;
    FCopDad.Data := FTransf.Data;
  End Else
  Begin
    pCopiaRegistro;
  End;

  pInsertTransf;
End;

procedure TTransferenciaArmazens.pSetaArmazenDestino(const strArmDes: String);
begin
  If FLimparFiltros Then
    Exit;

  If Not fEmptyStr(FInsert.FieldByName('ARMDES').AsString) Then
    Exit;

  FInsert.FieldByName('ARMDES').AsString := strArmDes;
end;

procedure TTransferenciaArmazens.pSomaQuantidadeProduto;
begin
  If Not fSomarQuantidadeProduto Then
    Exit;

  FTransf.FieldByName('QTDITE').AsFloat := FTransf.FieldByName('QTDITE').AsFloat + FQtdCur;
end;

procedure TTransferenciaArmazens.pBloqueiaArmazemOrigem(AAmzOri,
  ACodIte: String; ABloqueio: Boolean);
var qryComand: TUniQuery;
begin
  If Not BloqueiaLoteOrigem then
    Exit;
  qryComand := fCriaQuery;
  Try
    qryComand.SQL.Add('UPDATE CADLOT SET LOT_STATUS = "' + IIF(ABloqueio, 'B', 'S') + '",');
    If ABloqueio then
      qryComand.SQL.Add('       LOT_MOTBLO = "Transferência de Lote. Operador: '+strLoginUsuarioLogado+ ' ' + FormatDateTime('DD/MM/YYYY hh:mm:ss', fNow) + '"')
    Else
      qryComand.SQL.Add('       LOT_MOTBLO = ""');
    qryComand.SQL.Add(' WHERE LOT_NUMLOT = "'+AAmzOri+'"');
    qryComand.SQL.Add('   AND LOT_CODITE = "'+ACodIte+'"');
    qryComand.SQL.Add('   AND LOT_CODEMP = "'+VS_StrCodEmp+'"');
    qryComand.ExecSQL;
  Finally
    FreeAndNil(qryComand);
  End;

end;

Procedure TTransferenciaArmazens.pCancela(csdClient: TUniClientDataSet);
Begin
  If csdClient.State In [dsEdit, dsInsert] Then
    csdClient.Cancel;
End;

Procedure TTransferenciaArmazens.pCancelaEdicaoItem(opcEdits: TopcEdits = opcLimpar);
Begin
  pCancela(FTransf);
  If FLimparFiltros Then
    pCancela(FInsert);

  Case opcEdits Of
    opcEditar: FdtsTra.DataSet := FTransf;
    opcLimpar: pInsertTransf;
  End;
End;

Procedure TTransferenciaArmazens.pEditaItem;
Begin
  FQtdCur := 0;

  If FdtsTra.DataSet = FInsert Then
  Begin
    pInsertTransf;
  End Else
  Begin
    If Not FTransf.IsEmpty Then
      FQtdCur := FTransf.FieldByName('QTDITE').AsFloat;

    FTransf.Edit;
  End;

End;

destructor TTransferenciaArmazens.Destroy;
begin

  If Assigned(FFulfillment) Then
    FreeAndNil(FFulfillment);

  inherited Destroy;
end;

Function TTransferenciaArmazens.fCarregaArmazem(blnOrigem: Boolean; strLocFis: String): Boolean;
  Var
    cdsClient: TUniClientDataSet;
    qryDadIte: TUniQuery;
    blnUsaWms: Boolean;
Begin
  blnUsaWms := fUsaRotinaWMS;

  If FdtsTra.DataSet = FTransf Then
    cdsClient := FTransf
  Else
    cdsClient := FInsert;

  qryDadIte := fCriaQuery(Self);
  With qryDadIte, SQL Do
  Begin
    Clear;
    Add(' SELECT L.*,                                      ');
    Add('        G.ITE_PRECUS,                             ');
    Add('        I.ITE_CODMAR,                             ');
    Add('          MAR_DESMAR,                             ');
    Add('          IFNULL(LOC_CRITIC,"N") AS LOC_CRITIC,   ');
    Add('          UNI_SIGUNI,                             ');
    Add('          CONCAT(IFNULL(CADAMZ.AMZ_DESCRI,""),"/",IFNULL(CADLOC.LOC_DESCRI,"")) AS DESAMZLOC, ');
    Add('          CADAMZ.AMZ_DESCRI, ');
    Add('          CADLOC.LOC_DESCRI  ');
    Add(' FROM CADLOT L                                    ');
    Add(' INNER JOIN CADITE I ON I.ITE_CODITE = LOT_CODITE ');
    Add(' INNER JOIN ITEGER G ON G.ITE_CODITE = LOT_CODITE ');
    Add('                    AND G.ITE_CODEMP = LOT_CODEMP ');
    Add(' LEFT  JOIN CADMAR   ON   MAR_CODMAR = ITE_CODMAR ');
    Add(' LEFT  JOIN CADUNI   ON   UNI_CODUNI = ITE_CODUNI ');
    Add(' LEFT  JOIN CADLOC   ON   LOC_CODLOC = LOT_LOCFIS ');
    Add('                    AND   LOT_CODEMP = LOC_CODEMP ');
    Add(' LEFT  JOIN CADAMZ   ON   AMZ_CODAMZ = LOT_NUMLOT ');
    Add('                    AND   AMZ_CODEMP = LOT_CODEMP ');
    Add(' WHERE LOT_CODITE = :CODITE                       ');
    Add('   AND LOT_CODEMP = :CODEMP                       ');
    Add('   AND LOT_NUMLOT = :NUMLOT                       ');

    ParamByName('CODITE').AsString := cdsClient.FieldByName('CODITE').AsString;
    ParamByName('NUMLOT').AsString := strLocFis;

    ParamByName('CODEMP').AsString := VS_strCodEmp;

    Open;

    Result := Not IsEmpty;

    If cdsClient.State In [dsInsert, dsEdit] Then
    Begin
      If Result Then
      Begin
        cdsClient.FieldByName('PRECUS').AsFloat  := FieldByName('ITE_PRECUS').AsFloat;
        cdsClient.FieldByName('CODMAR').AsString := FieldByName('ITE_CODMAR').AsString ;
        cdsClient.FieldByName('DESMAR').AsString := FieldByName('MAR_DESMAR').AsString ;
        cdsClient.FieldByName('SIGUNI').AsString := FieldByName('UNI_SIGUNI').AsString ;
      End;

      If blnOrigem Then
      Begin

        If Result Then
        Begin
          cdsClient.FieldByName('SALORI').AsFloat := FieldByName('LOT_SALDOS').AsFloat;

          If blnUsaWms Then
          Begin
            If FieldByName('LOC_CRITIC').AsString = 'S' Then
              cdsClient.FieldByName('SALORIRES').AsFloat := 0
            Else
              cdsClient.FieldByName('SALORIRES').AsFloat := fGetSaldoResLotDor(cdsClient.FieldByName('CODITE').AsString, strLocFis, VS_strCodEmp);

            cdsClient.FieldByName('SALORIDIS').AsFloat := cdsClient.FieldByName('SALORI').AsFloat - cdsClient.FieldByName('SALORIRES').AsFloat;
          End
          Else
          Begin

            cdsClient.FieldByName('SALORIRES').AsFloat := TSaldoReservado.New(
                                                         TReservaParametros.New()
                                                           .EmpresaItem(VS_strCodEmp)
                                                           .CodigoItem(FieldByName('LOT_CODITE').AsString)
                                                           .CodEmpresa(VS_strCodEmp)
                                                           .NumeroLote(FieldByName('LOT_NUMLOT').AsString)
                                                         ).fGetQuantidade();;
            cdsClient.FieldByName('SALORIDIS').AsFloat := cdsClient.FieldByName('SALORI').AsFloat -
                                                          cdsClient.FieldByName('SALORIRES').AsFloat;
          End;

          cdsClient.FieldByName('MAXORI').AsFloat := FieldByName('LOT_CAPACI').AsFloat;
          cdsClient.FieldByName('REPORI').AsFloat := FieldByName('LOT_PONREP').AsFloat;
          cdsClient.FieldByName('LOCORI').AsString:= FieldByName('LOT_LOCFIS').AsString;

          If fUsaRotinaWMS And (FieldByName('LOC_CRITIC').AsString <> 'S') Then
          Begin
            cdsClient.FieldByName('SALORI').AsFloat := FieldByName('LOT_SALDOS').AsFloat -
                                                       TSaldoReservado.New(
                                                         TReservaParametros.New()
                                                           .EmpresaItem(VS_strCodEmp)
                                                           .CodigoItem(FieldByName('LOT_CODITE').AsString)
                                                           .CodEmpresa(VS_strCodEmp)
                                                           .NumeroLote(FieldByName('LOT_NUMLOT').AsString)
                                                         ).fGetQuantidade();
          End;

          If cdsClient.FindField('DESLFO') <> Nil Then
            cdsClient.FieldByName('DESLFO').AsString := fRetNomLocFisica(FieldByName('LOT_LOCFIS').AsString);

          cdsClient.FieldByName('DESAMZLOCORI').AsString := FieldByName('DESAMZLOC').AsString;
          cdsClient.FieldByName('DESAMZORI').AsString := FieldByName('AMZ_DESCRI').AsString;
          cdsClient.FieldByName('DESLOCORI').AsString := FieldByName('LOC_DESCRI').AsString;
        End
        Else
        Begin
          cdsClient.FieldByName('SALORI').AsFloat := 0;
          cdsClient.FieldByName('SALORIRES').AsFloat := 0;
          cdsClient.FieldByName('SALORIDIS').AsFloat := 0;
          cdsClient.FieldByName('MAXORI').AsFloat := 0;
          cdsClient.FieldByName('REPORI').AsFloat := 0;
          cdsClient.FieldByName('LOCORI').AsString:= '';

          If cdsClient.FindField('DESLFO') <> Nil Then
            cdsClient.FieldByName('DESLFO').AsString := '';

          cdsClient.FieldByName('DESAMZLOCORI').AsString := '';
          cdsClient.FieldByName('DESAMZORI').AsString := '';
          cdsClient.FieldByName('DESLOCORI').AsString := '';
        End;

      End Else
      Begin

        If Result Then
        Begin
          cdsClient.FieldByName('SALDES').AsFloat := FieldByName('LOT_SALDOS').AsFloat;

          If blnUsaWms Then
          Begin
            cdsClient.FieldByName('SALDESRES').AsFloat := fGetSaldoResLotDor(cdsClient.FieldByName('CODITE').AsString, strLocFis, VS_strCodEmp);
            cdsClient.FieldByName('SALDESDIS').AsFloat := cdsClient.FieldByName('SALDES').AsFloat - cdsClient.FieldByName('SALDESRES').AsFloat;
          End
          Else
          Begin
            cdsClient.FieldByName('SALDESRES').AsFloat := TSaldoReservado.New(
                                                         TReservaParametros.New()
                                                           .EmpresaItem(VS_strCodEmp)
                                                           .CodigoItem(FieldByName('LOT_CODITE').AsString)
                                                           .CodEmpresa(VS_strCodEmp)
                                                           .NumeroLote(FieldByName('LOT_NUMLOT').AsString)
                                                         ).fGetQuantidade();

            cdsClient.FieldByName('SALDESDIS').AsFloat := cdsClient.FieldByName('SALDES').AsFloat -
                                                          cdsClient.FieldByName('SALDESRES').AsFloat
          End;

          cdsClient.FieldByName('MAXDES').AsFloat := FieldByName('LOT_CAPACI').AsFloat;
          cdsClient.FieldByName('REPDES').AsFloat := FieldByName('LOT_PONREP').AsFloat;
          cdsClient.FieldByName('LOCDES').AsString:= FieldByName('LOT_LOCFIS').AsString;

          If fUsaRotinaWMS Then
          Begin
            cdsClient.FieldByName('SALDES').AsFloat := FieldByName('LOT_SALDOS').AsFloat -
                                                       TSaldoReservado.New(
                                                         TReservaParametros.New()
                                                           .EmpresaItem(VS_strCodEmp)
                                                           .CodigoItem(FieldByName('LOT_CODITE').AsString)
                                                           .CodEmpresa(VS_strCodEmp)
                                                           .NumeroLote(FieldByName('LOT_NUMLOT').AsString)
                                                         ).fGetQuantidade();
          End;

          If cdsClient.FindField('DESLFD') <> Nil Then
            cdsClient.FieldByName('DESLFD').AsString := fRetNomLocFisica(FieldByName('LOT_LOCFIS').AsString);

          cdsClient.FieldByName('DESAMZLOCDES').AsString := FieldByName('DESAMZLOC').AsString;
          cdsClient.FieldByName('DESAMZDES').AsString := FieldByName('AMZ_DESCRI').AsString;
          cdsClient.FieldByName('DESLOCDES').AsString := FieldByName('LOC_DESCRI').AsString;
        End Else
        Begin
          cdsClient.FieldByName('SALDES').AsFloat := 0;
          cdsClient.FieldByName('SALDESRES').AsFloat := 0;
          cdsClient.FieldByName('SALDESDIS').AsFloat := 0;
          cdsClient.FieldByName('MAXDES').AsFloat := 0;
          cdsClient.FieldByName('REPDES').AsFloat := 0;
          cdsClient.FieldByName('LOCDES').AsString:= '';

          If cdsClient.FindField('DESLFD') <> Nil Then
            cdsClient.FieldByName('DESLFD').AsString := '';

          cdsClient.FieldByName('DESAMZLOCDES').AsString := '';
          cdsClient.FieldByName('DESAMZDES').AsString := '';
          cdsClient.FieldByName('DESLOCDES').AsString := '';
        End;

      End;

    End;

    If Not Result Then
      pMensagemOk('Armazém não encontrado!')

    Else If blnCadLoc And fEmptyStr(FieldByName('LOT_LOCFIS').AsString) And
                                   (FieldByName('LOT_NUMLOT').AsString <> 'A DEFINIR') Then
    Begin
      Result := False;
      pMensagemOk('Armazém sem localização Física definida!')
    End;

  End;
  FreeAndNil(qryDadIte);
End;

Function TTransferenciaArmazens.fGravaMovGerTransf: Boolean;
  Var
    recServicos: TDadosServicos;
    arrDuplic  : TarrDuplicata;
Begin
  {***************************************************************}
  {* Limpa os dados de servicoes como codigo, descricao e valor  *}
  {************************************************************JC*}
  FillChar(recServicos, SizeOf(recServicos), #0);
  FillChar(arrDuplic, Sizeof(arrDuplic) , #0);

  {****************************************}
  {* GRAVA MOVGER                         *}
  {*************************************LA*}
  Result := fGravaMovGer(strAutInc,                                                     // Auto Incremento (Retorno)
                         FNumDoc,                                                       // Numero Documento
                         FEspDoc,                                                       // Espécie
                         VS_strCodEmp,                                                  // Empresa
                         '',                                                            // Transportadora
                         FCodOpe,                                                       // Vendedor
                         '',                                                            // Fornecedor
                         FCodCli,                                                       // Cliente
                         'C',                                                           // Tipo ((C)liente / (F)ornecedor)
                         dtaDtaEnt,                                                     // Data da Entrada
                         fTime(),                                                       // Hora da Entrada
                         VS_Date,                                                       // Data do Documento
                         '01000',                                                       // Condição de Pagamento
                         '',                                                            // Estado do Cliente / Fornecedor
                         '',                                                            // Nome do Consumidor
                         '',                                                            // Endereço do Consumidor
                         '',                                                            // Bairro do Consumidor
                         '',                                                            // Cep do Consumidor
                         '',                                                            // Cidade do Consumidor
                         '',                                                            // Estado do Consumidor
                         '',                                                            // Telefone do Consumidor
                         0,
                         '',                                                            // CNPJ / CGC
                         '',                                                            // CNPJ / CGC do consumidor
                         '',                                                            // Inscrição estadual do Consumidor
                         '',                                                            // RG do consumidor
                         0.0,                                                           // Base Simples Paulista
                         0.0,                                                           // Base de IPI
                         0.0,                                                           // Aliquota de IPI
                         0.0,                                                           // Total de IPI
                         0.0,                                                           // Base de ICMS
                         0.0,                                                           // Aliquota de ICMS
                         0.0,                                                           // Total de ICMS
                         0.0,                                                           // Valor de Substituição
                         0.0,                                                           // Aliquota de Substituição
                         0.0,                                                           // Base de Substituição
                         0.0,                                                           // Base de Substituição Simulada
                         0.0,                                                           // Desconto Especial
                         fTotalGeral,                                                   // Valor Contábil
                         fTotalGeral,                                                   // Total dos Itens
                         0.0,                                                           // Total de Custo
                         0.0,                                                           // Total Médio
                         '',                                                            // Tipo de Frete
                         0.0,                                                           // Valor do Frete
                         0.0,                                                           // Peso Bruto
                         0.0,                                                           // Peso Liquido
                         0.0,                                                           // Volume
                         '',                                                            // Especie
                         '',                                                            // Marca
                         IIf(Not fEmptyStr(strObservacao), strObservacao, FMsg001),     // Mensagem 1
                         IIf(Not fEmptyStr(strObservacao), FMsg001, FMsg002),           // Mensagem 2
                         IIf(Not fEmptyStr(strObservacao), '', FMsg002),                // Mensagem 2
                         '',                                                            // Mensagem 4
                         '',                                                            // Mensagem 5
                         IIF(FDocFat.IsEmpty, False, True),                             // Indica se Faturado ou nao
                         IIF(FDocFat.IsEmpty, FEspDoc, FEspFat),                        // Tipo de Faturamento
                         IIF(FDocFat.IsEmpty, EmptyStr, FDocFat),                       // Numero de Faturamento
                         IIF(FDocFat.IsEmpty, EmptyStr, FEmpFat),                       // Empresa dd Faturamento
                         IIF(FDocFat.IsEmpty, 0, VS_Date),                              // Data de Faturamento
                         '',                                                            // Vendedor do Faturamento
                         '',                                                            // Condição de Pagamento do Faturamento
                         False,                                                         // Devolução Especial
                         0.0,                                                           // Valor do Faturamento
                         0.0,                                                           // Valor Parcela 01
                         0.0,                                                           // Valor Parcela 02
                         0.0,                                                           // Valor Parcela 03
                         0.0,                                                           // Valor Parcela 04
                         0.0,                                                           // Valor Parcela 05
                         0.0,                                                           // Valor Parcela 06
                         0.0,                                                           // Valor Parcela 07
                         0.0,                                                           // Valor Parcela 08
                         0.0,                                                           // Valor Parcela 09
                         0.0,                                                           // Valor Parcela 10
                         0.0,                                                           // Valor Parcela 11
                         0.0,                                                           // Valor Parcela 12
                         arrDuplic,                                                     // arrDuplic
                         '',                                                            // Série
                         'N',                                                           // Nota Especial
                         '99999',                                                       // Classificação Fiscal 1
                         '',                                                            // Classificação Fiscal 2
                         '',                                                            // Classificação Fiscal 3
                         '',                                                            // Natureza da Operação
                         0.0,                                                           // Percentual de Desconto
                         FCodOpe,                                                       // Codigo do Digitador
                         '',                                                            // Codigo da Condição
                         '',                                                            // Forma de Pagamento
                         0.0,                                                           // Fator para meia nota
                         recServicos,
                         0.0,                                                           // Despesa acessoria
                         '',                                                            // Origem do Documento (V)enda (D)evolução
                         'N',                                                           // Usa controle de entrega
                         '',                                                            // Representante
                         0.0,                                                           // Aliquota do IRPF (SERVIÇO)
                         0.0,                                                           // Valor do IRPF (SERVIÇO + PRODUTO)
                         0.0,                                                           // Aliquota do Pis (SERVIÇO)
                         0.0,                                                           // Valor do Pis (SERVIÇO + PRODUTO)
                         0.0,                                                           // Aliquota do Cofins (SERVIÇO)
                         0.0,                                                           // Valor do Cofins (SERVIÇO + PRODUTO)
                         0.0,                                                           // Aliquota do CSLL (SERVIÇO)
                         0.0,                                                           // Valor do CSLL (SERVIÇO + PRODUTO)
                         0.0,                                                           // Valor de IRPF que foi retido
                         0.0,                                                           // Valor de PIS que foi retido
                         0.0,                                                           // Valor de COFINS que foi retido
                         0.0,                                                           // Valor de CSLL que foi retido
                         '',                                                            // Notas de Documentos Acumulados
                         0.0,                                                           // Aliquota do IRPF (PRODUTOS)
                         0.0,                                                           // Aliquota do PIS (PRODUTOS)
                         0.0,                                                           // Aliquota do COFINS (PRODUTOS)
                         0.0,                                                           // Aliquota do CSLL (PRODUTOS)
                         0.0,                                                           // Valor de SERVIÇO que foi retido
                         '',                                                            // Notas de documentos acumulados (SERVIÇO)
                         0.0,                                                           // Percentual da Seguridade Social
                         0.0,                                                           // Valor da Seguridade Social
                         0.0,                                                           // Valor do IRPF Retido (Produto)
                         0.0,                                                           // Valor do IRPF Devido (Produto)
                         0.0,                                                           // Valor do IRPF Retido (Serviço)
                         0.0,                                                           // Valor do IRPF Devido (Serviço)
                         0.0,                                                           // Valor do PIS Retido (Produto)
                         0.0,                                                           // Valor do PIS Devido (Produto)
                         0.0,                                                           // Valor do PIS Retido (Serviço)
                         0.0,                                                           // Valor do PIS Devido (Serviço)
                         0.0,                                                           // Valor do COFINS Retido (Produto)
                         0.0,                                                           // Valor do COFINS Devido (Produto)
                         0.0,                                                           // Valor do COFINS Retido (Serviço)
                         0.0,                                                           // Valor do COFINS Devido (Serviço)
                         0.0,                                                           // Valor do CSLL Retido (Produto)
                         0.0,                                                           // Valor do CSLL Devido (Produto)
                         0.0,                                                           // Valor do CSLL Retido (Serviço)
                         0.0,                                                           // Valor do CSLL Devido (Serviço)
                         '',                                                            // Ordem de Produção
                         0.0,                                                           // Base Orgão Público
                         0.0,                                                           // ICMS Orgão Público
                         0,                                                             // Número do Conhecimento de Frete
                         '',                                                            // Consumidor final
                         'N',                                                           // Entrega no Faturamento
                         IIF(FDocFat.IsEmpty, EmptyStr, FCliFat),                       // Cliente de Faturamento
                         '',                                                            // Operador da Expedição
                         '',                                                            // Separador da Expedição
                         '',                                                            // Tabela de Preços utilizada
                         '',
                         'N',                                                           // Entrega Futura
                         FALSE,                                                         // Baixa de Entrega Futura
                         0,                                                             // Margem de Lucro
                         0.0,                                                           // Base do retido (caso tivesse) com ipi e frete de entrada
                         0.0,                                                           // Valor do retido considerando a base acima.
                         'N',                                                           // Gerar produção fora da loja
                         '',                                                            // Numero do Registro - Correios ou Transportadora
                         VS_Date,                                                       // Data de Entrega no Romaneio
                         '',                                                            // Classificação fiscal 4
                         'N',                                                           // AUTO-SERVIÇO
                         '',                                                            // Evento
                         '',                                                            // AUTINC ENDEREÇO DE ENTREGA
                         '',                                                            // Conteúdo do CNFNFE
                         '',                                                            // Motivo da Devolução
                         '',
                         False,                                                         // Imprime Duplicatas na NF-e
                         0,
                         0,
                         '',
                         0,
                         0,
                         Nil,
                        '',           // Conhecimento de Frete
                        '',
                        '',
                        'N',          // Permuta para isenção de pagamento de comissão
                        '',
                        '',
                        0,
                        '',
                        0,            //BASE DE ICMS ANTECIPADO
                         0,            //VALOR DE ICMS ANTECIPADO
                        '',
                        '',
                        '',
                        '',
                        '',
                        '',
                        0,
                        0,
                        0,
                        '',
                        '',
                        '',
                        '',
                        '',
                        '',
                        '',
                        '',
                        '',
                        '',
                        0,
                        0,
                        0,
                        False,
                        False,
                        '',
                        '',
                        False,
                        '',
                        '',
                        '',
                        '',
                        0,
                        nil,
                        0,
                        0,
                        0,
                        0,
                        '',
                        'N',
                        FSeqOri);

  If Result Then
    objAuditoriaSaldo.Adicionar(strAutInc, 'MOVGER');

  If Assigned(FProgre) Then
    FProgre.StepBy(1);
  Application.ProcessMessages;
End;

function TTransferenciaArmazens.fLote(blnInvertido: boolean = False): String;
begin
  If blnInvertido Then
    Result := IIF(strClaFis = STR_CLASAI, FTransf.FieldByName('ARMDES').AsString, FTransf.FieldByName('ARMORI').AsString)
  Else
    Result := IIF(Self.strClaFis = STR_CLASAI, FTransf.FieldByName('ARMORI').AsString, FTransf.FieldByName('ARMDES').AsString);
end;

Function TTransferenciaArmazens.fSQLItem: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT                   ';
  strSQL := strSQL + '   ITE_DESITE,            ';
  strSQL := strSQL + '   ITE_CODMAR,            ';
  strSQL := strSQL + '   ITE_CODUNI,            ';
  strSQL := strSQL + '   ITE_CODFOR,            ';
  strSQL := strSQL + '   ITE_REFERE,            ';
  strSQL := strSQL + '   ITE_INCPIS,            ';
  strSQL := strSQL + '   ITE_PRECUS             ';
  strSQL := strSQL + ' FROM                     ';
  strSQL := strSQL + '   CADITE C               ';
  strSQL := strSQL + ' INNER JOIN ITEGER G ON G.ITE_CODITE = C.ITE_CODITE AND ';
  strSQL := strSQL + '                        G.ITE_CODEMP = :CODEMP          ';
  strSQL := strSQL + ' WHERE                    ';
  strSQL := strSQL + '   C.ITE_CODITE = :CODITE ';

  Result := strSQL;
End;

Function TTransferenciaArmazens.fCarregaDadosEntrada(strNumDoc,
                                                     strEspDoc,
                                                     strCodEmp,
                                                     strSerie_,
                                                     strCodFor,
                                                     strCodIte: String;
                                                     Var fltPreUlt, fltImpUlt: Double;
                                                     Var dtaDtaEnt: TDateTime): Boolean;
  Var
    qryMovDet: TUniQuery;
Begin
  qryMovDet := fCriaQuery;
  With qryMovDet, SQL Do
  Begin
    Add('SELECT');

    Add(' D.DET_DTAENT AS DTAENT,');
    Add(' ROUND(T.DET_TOTULT / D.DET_QTDITE, 2) AS PREULT, ');
    Add(' ROUND(T.DET_IMPULT / D.DET_QTDITE, 2) AS IMPULT  ');

    Add('FROM');
    Add('  MOVDET D');

    Add('INNER JOIN MOVTRI T ON T.DET_SEQGER = D.AUTOINCREM');

    Add('WHERE ');

    Add('  D.DET_NUMDOC = :NUMDOC AND ');
    Add('  D.DET_ESPDOC = :ESPDOC AND ');
    Add('  D.DET_CODEMP = :CODEMP AND ');
    Add('  D.DET_SERIE_ = :SERIE_ AND ');
    Add('  D.DET_CODITE = :CODITE AND ');
    Add('  D.DET_CODFOR = :CODFOR     ');

    Add('ORDER BY');
    Add('  D.AUTOINCREM DESC LIMIT 1');

    ParamByName('NUMDOC').AsString := strNumDoc;
    ParamByName('ESPDOC').AsString := strEspDoc;
    ParamByName('CODEMP').AsString := strCodEmp;
    ParamByName('SERIE_').AsString := strSerie_;
    ParamByName('CODFOR').AsString := strCodFor;
    ParamByName('CODITE').AsString := strCodIte;

    Open;

    Result := Not IsEmpty;

    If Result Then
    Begin
      fltPreUlt := FieldByName('PREULT').AsFloat;
      fltImpUlt := FieldByName('IMPULT').AsFloat;
      dtaDtaEnt := FieldByName('DTAENT').AsDateTime;
    End Else
    Begin
      fltPreUlt := 0;
      fltImpUlt := 0;
      dtaDtaEnt := 0;
    End;

  End;
  FreeAndNil(qryMovDet);
End;

procedure TTransferenciaArmazens.pCarregarArmazemProdutoAcabado;
Var
  qryCadIte: TUniQuery;
  objDataSet: TDataSet;
begin
  qryCadIte := fCriaQuery(Self);
  Try
    qryCadIte.SQL.Add('SELECT DISTINCT ');
    qryCadIte.SQL.Add('  G.ITE_CODEMP,  ');
    qryCadIte.SQL.Add('  I.ITE_CODITE,');
    qryCadIte.SQL.Add('  I.ITE_DESITE,');
    qryCadIte.SQL.Add('  L.AUTOINCREM,');
    qryCadIte.SQL.Add('  L.LOT_NUMLOT,');
    qryCadIte.SQL.Add('  L.LOT_SALDOS,');
    qryCadIte.SQL.Add('  I.ITE_CODMAR,');
    qryCadIte.SQL.Add('  I.ITE_CODBAR,');
    qryCadIte.SQL.Add('  M.MAR_DESMAR,');
    qryCadIte.SQL.Add('  U.UNI_SIGUNI');
    qryCadIte.SQL.Add('FROM');
    qryCadIte.SQL.Add('  CADITE I');
    qryCadIte.SQL.Add('  JOIN CADMAR M');
    qryCadIte.SQL.Add('    ON M.MAR_CODMAR = I.ITE_CODMAR');
    qryCadIte.SQL.Add('  JOIN CADUNI U');
    qryCadIte.SQL.Add('    ON U.UNI_CODUNI = I.ITE_CODUNI');
    qryCadIte.SQL.Add('  JOIN ITEGER G');
    qryCadIte.SQL.Add('    ON G.ITE_CODITE = I.ITE_CODITE');
    qryCadIte.SQL.Add('  JOIN CADLOT L');
    qryCadIte.SQL.Add('    ON L.LOT_CODEMP = G.ITE_CODEMP');
    qryCadIte.SQL.Add('    AND L.LOT_CODITE = G.ITE_CODITE');
    qryCadIte.SQL.Add('    AND L.LOT_SALDOS > 0');
    qryCadIte.SQL.Add('  JOIN CADDEP ON');
    qryCadIte.SQL.Add('	   DEP_CODIGO = ITE_CODDEP AND');
    qryCadIte.SQL.Add('	   DEP_PROACA = "S" AND');
    qryCadIte.SQL.Add('	   DEP_PROMAP = "N"');
    qryCadIte.SQL.Add('WHERE G.ITE_CODEMP = ' + VS_strCodEmp.QuotedString);

    qryCadIte.SQL.Add('AND L.LOT_NUMLOT = ' + FArmOri.QuotedString);
    If Not fEmptyStr(FIteAca) Then
      qryCadIte.SQL.Add('AND G.ITE_CODITE = ' + FIteAca.QuotedString);
    qryCadIte.Open;

    While Not qryCadIte.Eof Do
    Begin
      pInsertTransf;
      objDataSet := FdtsTra.DataSet;
      objDataSet.FieldByName('CODITE').AsString := qryCadIte.FieldByName('ITE_CODITE').AsString;
      objDataSet.FieldByName('DESITE').AsString := qryCadIte.FieldByName('ITE_DESITE').AsString;
      objDataSet.FieldByName('ARMORI').AsString := qryCadIte.FieldByName('LOT_NUMLOT').AsString;
      objDataSet.FieldByName('CODMAR').AsString := qryCadIte.FieldByName('ITE_CODMAR').AsString;
      objDataSet.FieldByName('DESMAR').AsString := qryCadIte.FieldByName('MAR_DESMAR').AsString;
      objDataSet.FieldByName('SIGUNI').AsString := qryCadIte.FieldByName('UNI_SIGUNI').AsString;
      fCarregaArmazem(True, objDataSet.FieldByName('ARMORI').AsString);
      pSalvaItem;
      qryCadIte.Next;
    End;
  Finally
    FreeAndNil(qryCadIte);
  End;
end;

function TTransferenciaArmazens.fEhSaida: Boolean;
begin
  Result := Self.strClaFis.Equals(STR_CLASAI);
end;

Function TTransferenciaArmazens.fGravaMovDetTransf(Var strMensagem: String;  var strSequencial: String): Boolean;
  Var
    qryCadIte : TUniQuery;
    fltPreUlt,
    fltImpUlt : Double;
    dtaDtaUlt : TDateTime;
    endItem   : TEndItem;
    strAutEnt : String;

    LFulfillment : TFulfillment;
    LRegras      : FulfillmentRegrasMovimentacaoEstoque;

    LMovimentaSaldoLotes_,
    LMovimentaSaldoFisico,
    LMovimentaSaldoExterno : Boolean;

    LClaFat : String;

    function MovimentaSaldoLotes_ : Boolean;
    begin

      If FFulfillment.EhOperacaoFulfillment Then
        Exit(True);

      Result := (Not blnFilkar);

    end;

    function MovimentaSaldoFisico : Boolean;
    begin

      Result := False;

      If Not FFulfillment.EhOperacaoFulfillment Then
        Exit;

      If Not LRegras.EntradaSaida.Equals(IIF(fEhSaida, 'S', 'E')) Then
        Exit(False);

      Result := LRegras.MovimentaEstoqueFisico;

    end;

    function MovimentaSaldoExterno : Boolean;
    begin

      Result := False;

      If Not FFulfillment.EhOperacaoFulfillment Then
        Exit;

      If Not LRegras.EntradaSaidaExterno.Equals(IIF(fEhSaida, 'S', 'E')) Then
        Exit(False);

      Result := LRegras.MovimentaEstoqueExterno;

    end;

Begin

  Result := False;

  LFulfillment := Nil;
  strMensagem  := '';

  Try
    LRegras := FulfillmentMovimentacaoEstoque(FFulfillment.ClassificacaoFiscal,
                                              FFulfillment.ChaveDeAcesso,
                                              FFulfillment.SiglaHubMarketPlace);
  Finally
    LMovimentaSaldoLotes_  := MovimentaSaldoLotes_;
    LMovimentaSaldoFisico  := MovimentaSaldoFisico;
    LMovimentaSaldoExterno := MovimentaSaldoExterno;
  End;

  If Not Assigned(LFulfillment) Then
    LFulfillment := TFulfillment.New;

  LClaFat := FFulfillment.ClassificacaoFiscal;
  LFulfillment.CopyFrom(FFulfillment);

  If Not LoteEhFulfillment(fLote, VS_strCodEmp, FTransf.FieldByName('CODITE').AsString) Then
    LFulfillment.Limpar;

  qryCadIte := fCriaQuery(Self);

  qryCadIte.SQL.Text := fSQLItem;

  qryCadIte.Close;
  qryCadIte.ParamByName('CODITE').AsString := FTransf.FieldByName('CODITE').AsString;
  qryCadIte.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryCadIte.Open;

  If (fUsaRotinaWMS) Then
  Begin
    If (fEmptyStr(FTransf.FieldByName('ARMORI').AsString)) Then
    Begin
      strMensagem := 'O Armazém de Origem não pode ser vazio. Favor comunicar a Citel' + #13#10 +
                     'Produto: ' + FTransf.FieldByName('CODITE').AsString + '-' + fRetNomProduto(FTransf.FieldByName('CODITE').AsString);
    End
    Else If (fEmptyStr(FTransf.FieldByName('ARMDES').AsString)) Then
    Begin
      strMensagem := 'O Armazém de Destino não pode ser vazio. Favor comunicar a Citel' + #13#10 +
                     'Produto: ' + FTransf.FieldByName('CODITE').AsString + '-' + fRetNomProduto(FTransf.FieldByName('CODITE').AsString);
    End;
  End
  Else If fEmptyStr(fLote) Then
  Begin
    if strClaFis = STR_CLASAI then
      strMensagem := 'O Lote de Origem não pode ser vazio. Favor comunicar a Citel' + #13#10 +
                     'Produto: ' + FTransf.FieldByName('CODITE').AsString + '-' + fRetNomProduto(FTransf.FieldByName('CODITE').AsString)
    Else
      strMensagem := 'O Lote de Destino não pode ser vazio. Favor comunicar a Citel' + #13#10 +
                     'Produto: ' + FTransf.FieldByName('CODITE').AsString + '-' + fRetNomProduto(FTransf.FieldByName('CODITE').AsString);
  End;

  If (Not fEmptyStr(strMensagem)) Then
    Exit;

  If (FTransf.FieldByName('QTDITE').AsFloat = 0.0) Then
  Begin
     Result := False;
     Exit;
  End;

  strAutIncDet := '';
  strAutEnt := '';
  If Assigned(FTransf.FindField('AUTENT')) Then
    strAutEnt := FTransf.FieldByName('AUTENT').AsString;

  Result := fGravaMovDet(strAutIncDet,                                                // Retorna Auto-Incremento por Referencia
                         strAutInc,                                                   // Sequencial do Arquivo Geral
                         FNumDoc,                                                     // Numero Documento
                         FEspDoc,                                                     // Espécie
                         VS_strCodEmp,                                                // Empresa
                         FTransf.FieldByName('CODITE').AsString,                              // Cód. Item
                         FCodOpe,                                                     // Vendedor
                         '',                                                          // Código Diversos
                         qryCadIte.FieldByName('ITE_CODMAR').AsString,                          // Código da Marca
                         '',                                                          // Fornecedor
                         FCodCli,                                                     // Cliente
                         dtaDtaEnt,                                                   // Data da Entrada
                         fTime(),                                                     // Hora da Entrada
                         VS_Date,                                                     // Data do Documento
                         '01000',                                                     // Condição de Pagamento
                         'C',                                                         // Tipo: (C)liente / (F) Fornecedor
                         '',                                                          // Estado do Fornecedor
                         qryCadIte.FieldByName('ITE_DESITE').AsString,                // Descrição do Item
                         qryCadIte.FieldByName('ITE_REFERE').AsString,                // Referência do Item
                         qryCadIte.FieldByName('ITE_CODUNI').AsString,                // Cód. Unidade
                         qryCadIte.FieldByName('ITE_CODFOR').AsString,                // Fornecedor Item
                         FTransf.FieldByName('QTDITE').AsFloat,                               // Quantidade do Item
                         qryCadIte.FieldByName('ITE_PRECUS').AsFloat,                               // Valor Unitario
                         qryCadIte.FieldByName('ITE_PRECUS').AsFloat,                               // Valor Unitário Original
                         qryCadIte.FieldByName('ITE_PRECUS').AsFloat,                               // Valor Unitário Original sem juros
                         RoundTo(FTransf.FieldByName('QTDITE').AsFloat * qryCadIte.FieldByName('ITE_PRECUS').AsFloat, -2),  // Total do Item
                         RoundTo(FTransf.FieldByName('QTDITE').AsFloat * qryCadIte.FieldByName('ITE_PRECUS').AsFloat, -2),  // Valor Contábil do Item
                         0.0,                                                         // Valor Total de Custo
                         0.0,                                                         // Valor Total Medio
                         0.0,                                                         // % Desconto do Item
                         0.0,                                                         // Valor do Frete
                         0.0,                                                         // Valor do Desconto Especial
                         '',                                                          // Código do Representante
                         '',                                                          // Código do Vendedor 2
                         0.0,                                                         // Percentual de Comissão do Vendedor
                         0.0,                                                         // Total de Comissão do Vendedor
                         0.0,                                                         // Total de Comissão do Vendedor 2
                         strClaFis,                                                   // Classificação Fiscal
                         '',                                                          // Código Fiscal
                         0.0,                                                         // Valor IPI
                         0.0,                                                         // Aliquota IPI
                         0.0,                                                         // Base IPI
                         0.0,                                                         // Valor de ICMS
                         0.0,                                                         // Aliquota de ICMS
                         0.0,                                                         // Base de ICMS
                         0.0,                                                         // Valor de Substituição
                         0.0,                                                         // Aliquota de Substituição
                         0.0,                                                         // Base de Substituição
                         0.0,                                                         // Total de Peso
                         0.0,                                                         // Percentual de Base de ICMS
                         0.0,                                                         // Percentual de Redução de Base
                         IIF(FDocFat.IsEmpty, False, True),                           // Indica se Faturado ou nao
                         IIF(FDocFat.IsEmpty, FEspDoc, FEspFat),                      // Tipo de Faturamento
                         IIF(FDocFat.IsEmpty, EmptyStr, FDocFat),                     // Numero de Faturamento
                         IIF(FDocFat.IsEmpty, EmptyStr, FEmpFat),                     // Empresa dd Faturamento
                         IIF(Fulfillment.EhOperacaoFulfillment, Fulfillment.DataDeEntrada, IIF(FDocFat.IsEmpty, 0, VS_Date)), // Data de Faturamento
                         '',                                                          // Vendedor do Faturamento
                         '',                                                          // Condição de Pagamento do Faturamento
                         0.0,                                                         // Valor do Faturamento
                         'NOR',                                                       // Identificação Produto ( Normal / Outros )
                         qryCadIte.FieldByName('ITE_INCPIS').AsString,                // Indice se incide Pis
                         '',                                                          // Série
                         0.0,                                                         // Valor de Despesa Acessória
                         'N',                                                         // Nota Especial
                         '',                                                          // Documento da Devolução
                         '',                                                          // Espécie da Devolução
                         '',                                                          // Empresa da Devolução
                         '',                                                          // Item de Chamada (TINTA DE MAQUINA)
                         '',                                                          // Item da Tinta (TINTA DE MAQUINA)
                         '',                                                          // Descrição da Cor (TINTA DE MAQUINA)
                         '',                                                          // Tipo de Embalagem (TINTA DE MAQUINA)
                         0.0,                                                         // Quantidade de Embalagem (TINTA DE MAQUINA)
                         0.0,                                                         // Preço da Embalagem (TINTA DE MAQUINA)
                         '',                                                          // Tipo de Preço (TINTA DE MAQUINA)
                         0.0,                                                         // Preço de Venda da Tinta (TINTA DE MAQUINA)
                         0.0,                                                         // Preço de Compra da Tinta (TINTA DE MAQUINA)
                         0.0,                                                         // Fator da Tinta (TINTA DE MAQUINA)
                         '',                                                          // Produto Embalagem (TINTA DE MAQUINA)
                         FCodOpe,                                                     // Código do Digitador
                         '',                                                          // Codigo da Condição
                         '',                                                          // Forma de Pagamento
                         '',                                                          // Item da Embalagem
                         '',                                                          // Grupo do Item da Embalagem
                         0,                                                           // Quarto da Lazzumiz
                         'N',                                                         // É item em promoção?
                         '',                                                          // Tipo de Tinta
                         0.0,                                                         // Quantidade de Pulsos
                         '',                                                          // Número do pedido de compras
                         '',                                                          // Origem do documento
                         '',                                                          // Pedido de Venda - Número
                         '',                                                          // Pedido de Venda - Espécie
                         '',                                                          // Pedido de Venda - Empresa
                         0,                                                           // Pedido de Venda - Sequencial
                         '',                                                          // Ordem de Produção
                         '',                                                          // Descrição para Nota Fiscal Especial
                         IIF(FDocFat.IsEmpty, EmptyStr, FCliFat),                     // Cliente de Faturamento
                         0,
                         0,
                         0.0,                                                         // Volume a produzir (Tinta de Máquina Venda Dinâmica)
                         '',
                         '',
                         False,
                         LMovimentaSaldoLotes_.ToFilKar, //Filkar
                         '',                                                          //  Especie da Entrega Fututa
                         '',                                                          //  Documento da Entrega Fututa
                         '',
                         '',                                                          //  Empresa da Entrega Fututa
                         '',
                         '',
                         '',
                         '',
                         0.0,
                         '',
                         0.0,
                         0.0,
                         0,
                         'N',
                         '',
                         0,
                         0,
                         0,
                         0,
                         '',
                         fLote,
                         'N',
                         0,
                         0,
                         0,
                         0,
                         0,
                         0,
                         0,
                         0,
                         0,
                         0,
                         0,
                         0,
                         0,
                         '',
                         0,
                         0,
                         0,
                         '',
                         '',
                         '',
                         0,
                         0,
                         0,
                         0,
                         0,
                         fLote(True),
                         0,
                         0,
                         0,
                         0,
                         0,
                         0,
                       'P',
                         0,
                         0,
                         0,
                        '',
                        '',
                        '',
                        '',
                         0,
                         0,
                         0,
                         0,
                         0,
                        '',
                         0,
                         0,
                        '',
                       'N',
                       'N',
                         0,
                         0,
                         0,
                        '',
                       'N',
                         0,
                        '',
                         0,
                       'N',
                        '',
                     'NOR',
                         0,
                         0,
                         0,
                         0,
                         0,
                         0,
                        '',
                         0,
                         0,
                         0,
                        '',
                         0,
                         0,
                         0,
                        '',
                       'N',
                        '',
                        '',
                         0,
                        '',
                        '',
                         0,
                         0,
                         0,
                         0,
                        '',
                       'N',
                        '',
                       'N',
                         0,
                         0,
                        '',
                         0,
                         0,
                         0,
                     False,
                         0,
                        '',
                         0,
                         0,
                         0,
                        '',
                        '',
                        '',
                         0,
                         0,
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
                         0,
                         0,
                         0,
                         0,
                         IIF(LFulfillment.EhOperacaoFulfillment, 'S', 'N'),                                 //strExtFul: String = '';
                         IIF(LFulfillment.EhOperacaoFulfillment, LFulfillment.CodigoDoEstoqueExterno, ''),  //strCodExt: String = '';
                         0,                                                                                 //fltFreMkp: Double = 0;
                         0,                                                                                 //fltComMkp: Double = 0;
                        '',                                                                                 //strAIdKitPromocao : String = '';
                        '',                                                                                 //strChaveAcesso: String = '';
                         0,                                                                                 //fltQtdCom: Double = 0;
                         0,                                                                                 //fltFreCot: Double = 0;
                        '',                                                                                 //AstrComplemento : String = '';
                        '',                                                                                 //strEmpCar: String = '';
                        '',                                                                                 //strAutoinDevCar: String = '';
                         0,                                                                                 //AfltBaseOperacaoPropriaICMSEntrada : Double = 0;
                         0,                                                                                 //AfltAliquotaOperacaoPropriaICMSEntrada : Double = 0;
                         0,                                                                                 //AfltValorOperacaoPropriaIMCSEntrada : Double = 0;
                         0,                                                                                 //fltFreRat: Double = 0;
                         0,                                                                                 //fltValIpiEntFut: Double = 0;
                         0,                                                                                 //fltValRetEntFut: Double = 0;
                         0,                                                                                 //fltValFcpSTEntFut: Double = 0;
                         0,                                                                                 //fltDesPis: Double = 0;
                     False,                                                                                 //blnClaRet: Boolean = False;
                        '',                                                                                 //strOpSeEx: String = '';
                        '',                                                                                 //strConExp: String = '';
                        '',                                                                                 //strEmbExp: String = '';
                        '',                                                                                 //strObsExp: String = '';
                      False,                                                                                //blnAtoDeclaratorioDF: Boolean = False;
                         '',                                                                                //strMovTriLocFis: String = '';
                          0,                                                                                //fltVDesST: Double = 0;
                          '',    //strMDesST: String = '';
                          '',    //strNumDrw: String = '';
                          '',    //strTipBus: String = '';
                          '',    //strNumPla: String = '';
                          '',    //strParNum: String = '';
                          '',    //strReqCom: String = '';
                          '',    //strNatOpe: String = '';
                          0,     //fltRpaFre: Double = 0;
                          0,     //fltPerRic: Double = 0;
                          False, //blnAltEst: Boolean = False;
                          0,     //intSeqPer: Integer = 0;
                          0,     //intDetItem: Integer = 0;
                          0,     //fltICMCFR: Double = 0;
                          0,     //fltFreteCalc: Double = 0;
                          0,     //fltFreConCalc: Double = 0;
                          'N',   //strPegou_ : String = 'N';
                          0,     //fltVFCPOP: Double = 0;
                          0,     //fltVFCPDF: Double = 0;
                          0,     //fltCubage: Double = 0;
                          0,     //fltCfbIpi: Double = 0;
                          0,     //fltCfaIpi: Double = 0;
                          0,     //fltCfvIpi: Double = 0;
                          'N',   //strCipiOK: String = 'N';
                          '',    //strDocIpi: String = '';
                          '',    //strEspIpi: String = '';
                          '',    //strEmpIpi: String = '';
                          0,     //intRemFil: Integer = 0;
                          0,     //fltQtdRemFil: Double = 0;
                          LFulfillment.EhOperacaoFulfillment,                    //blnFulfillmentModoRobo: Boolean = False;
                          IIF(LFulfillment.EhOperacaoFulfillment, LMovimentaSaldoExterno.ToFilFul, True),  //blnFilFul: Boolean = True;
                          False,                                                 //blnBaiDev: Boolean = False;
                          strAutEnt,                                             //strAutEnt: String = '';
                          0,                                                     //dtaDtaCmp: TDateTime = 0;
                          LFulfillment.SiglaHubMarketPlace,                      //strFullHubMkp: String = '';
                          0,      //fltOutValPD: Double = 0;
                          IIF(LFulfillment.EhOperacaoFulfillment, IIF(fEhSaida, 'S', 'E'), ''), //strFilFul_EntSai: String = '';
                          '',     //strIncOri: String = '';
                          '',     //strTckQbt: String = '';
                          'N',    //strEntTri: String = 'N';
                          '',     //strFulDif: String = '';
                          LClaFat //strClaFat: String = '';
                          );

  If Not Result Then
    Exit;

  strSequencial := strAutIncDet;

  If (strClaFis <> STR_CLASAI) And
     (endDocumento.strTip_FC = 'F') And
     (FTransf.FieldByName('ARMDES').AsString <> STR_A_DEFINIR) And

     fCarregaDadosEntrada(endDocumento.strNumDoc,
                          endDocumento.strEspDoc,
                          endDocumento.strCodEmp,
                          endDocumento.strSerie_,
                          endDocumento.strCliFor,
                          FTransf.FieldByName('CODITE').AsString,
                          fltPreUlt, fltImpUlt, dtaDtaUlt) Then

    pAtualizaUltimaCompraCadLot(FTransf.FieldByName('CODITE').AsString,
                                FTransf.FieldByName('ARMDES').AsString,
                                endDocumento.strCliFor,
                                fCodificaChaveNota(endDocumento.strNumDoc,
                                                   endDocumento.strEspDoc,
                                                   endDocumento.strCodEmp,
                                                   endDocumento.strSerie_,
                                                   endDocumento.strCliFor),
                                endDocumento.strCodEmp,
                                fltPreUlt,
                                fltImpUlt,
                                dtaDtaUlt);

  If (LMovimentaSaldoFisico) Then
  Begin

    Result := fAtualizaEstoqueCadIte(FTransf.FieldByName('CODITE').AsString,
                                     IIF(fEhSaida, 'S', 'E'),
                                     FTransf.FieldByName('QTDITE').AsFloat,
                                     0.0,
                                     fLote);

  End

  Else If (LMovimentaSaldoLotes_) Then
  Begin
    Result := FCadLot.fAtualizaEstoqueLote(FTransf.FieldByName('CODITE').AsString,
                                           IIF(fEhSaida, 'S', 'E'),
                                           fLote,
                                           FTransf.FieldByName('QTDITE').AsFloat);
  End;

  If FblnEndLocal And (strClaFis = STR_CLASAI) And (Not fIsItemEspecial(FTransf.FieldByName('CODITE').AsString)) Then
  Begin
    endItem.strCodIte := FTransf.FieldByName('CODITE').AsString;
    endItem.strCodMar := qryCadIte.FieldByName('ITE_CODMAR').AsString;
    endItem.strDesIte := qryCadIte.FieldByName('ITE_DESITE').AsString;
    endItem.strRefere := qryCadIte.FieldByName('ITE_REFERE').AsString;
    endItem.strCodUni := qryCadIte.FieldByName('ITE_CODUNI').AsString;
    endItem.strCodFor := qryCadIte.FieldByName('ITE_CODFOR').AsString;
    endItem.fltQtdIte := RoundTo(FTransf.FieldByName('QTDITE').AsFloat, -4);
    endItem.strCodAmz := FTransf.FieldByName('ARMORI').AsString;
    endItem.strAutDet := strAutIncDet;
    objEnderecamentoProduto.pAddItem(endItem);
  End;

  If Not Result Then
    Exit;

  If Assigned(FProgre) Then
    FProgre.StepBy(1);

  Application.ProcessMessages;

  FreeAndNil(qryCadIte);

  If Assigned(LFulfillment) Then
    FreeAndNil(LFulfillment);

End;

Function TTransferenciaArmazens.fGeraTransferencia(blnUsaLote : Boolean; blnControlaTransacao : Boolean; blnGerarReserva: Boolean = False): Boolean;
Var
  strMensagem, strCodite: String;
  intQtdRegEnt, intQtdRegSai: integer;
  fltQtdEnderada, fltQtdAEnderecar: Double;
  qryValQtdReg, qryQtdEnderecada, qryPedidoEnderecamento: TUniQuery;
  strSeqSai: String;
  strSeqEnt: String;
  strCodErrosAuditoria: String;
  FendDocumento: TEndDocumento;

  procedure pValQuantidade;
  begin
    qryValQtdReg := fCriaQuery;
    Try
      qryValQtdReg.SQL.Add('SELECT SUM(IF(DET_CLAFIS <  "5000", DET_QTDITE, 0)) QTD_REGENT,');
      qryValQtdReg.SQL.Add('       SUM(IF(DET_CLAFIS >= "5000", DET_QTDITE, 0)) QTD_REGSAI  FROM MOVDET');
      qryValQtdReg.SQL.Add('WHERE DET_SEQGER = :SEQGER');
      qryValQtdReg.ParamByName('SEQGER').AsString := strAutInc;
      qryValQtdReg.Open;

      intQtdRegEnt := qryValQtdReg.FieldByName('QTD_REGENT').AsInteger;
      intQtdRegSai := qryValQtdReg.FieldByName('QTD_REGSAI').AsInteger;

      If ( RoundTo(intQtdRegEnt,-4) = RoundTo(intQtdRegSai,-4)) Then
      Begin
        qryValQtdReg.Close;
        qryValQtdReg.SQL.Clear;
        qryValQtdReg.SQL.Add(' SELECT DET_CODITE, ');
        qryValQtdReg.SQL.Add('        SUM(IF(DET_CLAFIS <  "5000", DET_QTDITE, 0)) QTD_REGENT,');
        qryValQtdReg.SQL.Add('        SUM(IF(DET_CLAFIS >= "5000", DET_QTDITE, 0)) QTD_REGSAI  FROM MOVDET');
        qryValQtdReg.SQL.Add(' WHERE DET_SEQGER = :SEQGER ');
        qryValQtdReg.SQL.Add(' GROUP BY DET_CODITE ');
        qryValQtdReg.SQL.Add(' HAVING QTD_REGENT <> QTD_REGSAI');

        qryValQtdReg.ParamByName('SEQGER').AsString := strAutInc;
        qryValQtdReg.Open;

        If Not qryValQtdReg.IsEmpty Then
        Begin
          intQtdRegEnt := qryValQtdReg.FieldByName('QTD_REGENT').AsInteger;
          intQtdRegSai := qryValQtdReg.FieldByName('QTD_REGSAI').AsInteger;
          strCodite := qryValQtdReg.FieldByName('DET_CODITE').AsString;
        end;
      End;
    Finally
      FreeAndNil(qryValQtdReg)
    End;
  end;
  procedure pValQtdEnderecada;
  Begin

    Try
      qryQtdEnderecada := fCriaQuery;
      qryPedidoEnderecamento := fCriaQuery;

      qryQtdEnderecada.SQL.Clear;
      qryQtdEnderecada.SQL.Add(' SELECT TAB.DET_CODITE, SUM(TAB.QTDITE) AS QTDITE ');
      qryQtdEnderecada.SQL.Add(' FROM ( ');
      qryQtdEnderecada.SQL.Add(' SELECT ');
      qryQtdEnderecada.SQL.Add(' DET_CODITE, SUM(DET_QTDITE) AS QTDITE ');
      qryQtdEnderecada.SQL.Add(' FROM MOVDET ');
      qryQtdEnderecada.SQL.Add(' WHERE DET_SEQGER = :SEQGER AND DET_CLAFIS > "5000"   ');
      qryQtdEnderecada.SQL.Add(' GROUP BY DET_CODITE ');
      qryQtdEnderecada.SQL.Add('UNION ALL ');
      qryQtdEnderecada.SQL.Add('  SELECT ');
      qryQtdEnderecada.SQL.Add('   DET.DET_CODITE, SUM(DET.DET_QTDITE) AS QTDITE ');
      qryQtdEnderecada.SQL.Add('  FROM ');
      qryQtdEnderecada.SQL.Add('   MOVGER ENT ');
      qryQtdEnderecada.SQL.Add('   INNER JOIN AUXMOV     ON AUX_SEQDOR = ENT.AUTOINCREM ');
      qryQtdEnderecada.SQL.Add('   INNER JOIN MOVGER TA  ON TA.AUTOINCREM = AUX_SEQGER ');
      qryQtdEnderecada.SQL.Add('   INNER JOIN MOVDET DET ON TA.AUTOINCREM = DET.DET_SEQGER ');
      qryQtdEnderecada.SQL.Add('  WHERE ENT.GER_NUMDOC = :NUMDOC ');
      qryQtdEnderecada.SQL.Add('   AND ENT.GER_ESPDOC = :ESPDOC ');
      qryQtdEnderecada.SQL.Add('   AND ENT.GER_CODEMP = :CODEMP ');
      If Sametext(endDocumento.strTip_FC, 'F') Then
        qryQtdEnderecada.SQL.Add('   AND ENT.GER_CODFOR = :CODFOR ')
      Else
        qryQtdEnderecada.SQL.Add('   AND ENT.GER_CODCLI = :CODFOR ');
      qryQtdEnderecada.SQL.Add('   AND ENT.GER_TIP_FC = :TIPFC_ ');
      qryQtdEnderecada.SQL.Add('   AND IFNULL(ENT.GER_SERIE_, "") = :SERIE_ ');
      qryQtdEnderecada.SQL.Add('   AND DET.DET_CLAFIS > "5000" ');
      qryQtdEnderecada.SQL.Add('   AND DET.DET_SEQGER <> :SEQGER ');
      qryQtdEnderecada.SQL.Add('   AND DET.DET_PROACA <> "S" ');
      qryQtdEnderecada.SQL.Add('   GROUP BY DET.DET_CODITE ');
      qryQtdEnderecada.SQL.Add('   ) AS TAB ');
      qryQtdEnderecada.SQL.Add('   GROUP BY TAB.DET_CODITE ');

      qryQtdEnderecada.ParamByName('SEQGER').AsString := strAutInc;
      qryQtdEnderecada.ParamByName('NUMDOC').AsString := endDocumento.strNumdoc;
      qryQtdEnderecada.ParamByName('ESPDOC').AsString := endDocumento.strEspdoc;
      qryQtdEnderecada.ParamByName('SERIE_').AsString := endDocumento.strSerie_;
      qryQtdEnderecada.ParamByName('CODEMP').AsString := endDocumento.strCodemp;
      qryQtdEnderecada.ParamByName('CODFOR').AsString := endDocumento.strCliFor;
      qryQtdEnderecada.ParamByName('TIPFC_').AsString := endDocumento.strTip_FC;

      qryQtdEnderecada.Close;
      qryQtdEnderecada.Open;

      If Not (qryQtdEnderecada.IsEmpty) Then
      Begin
        qryPedidoEnderecamento.SQL.Clear;

        qryPedidoEnderecamento.SQL.Add(' SELECT ');
        qryPedidoEnderecamento.SQL.Add('  FDO_CODITE AS CODITEPEDIDO,             ');
        qryPedidoEnderecamento.SQL.Add('  SUM(IFNULL(FDO_QTDITE, 0)) AS QTDAENDERECAR, ');
        qryPedidoEnderecamento.SQL.Add('  SUBSTRING(FGO_DOCEND, 1, 12) AS NUMDOC, ');
        qryPedidoEnderecamento.SQL.Add('  SUBSTRING(FGO_DOCEND, 13, 2) AS ESPDOC, ');
        qryPedidoEnderecamento.SQL.Add('  SUBSTRING(FGO_DOCEND, 15, 3) AS SERDOC, ');
        qryPedidoEnderecamento.SQL.Add('  SUBSTRING(FGO_DOCEND, 18, 3) AS EMPDOC, ');
        qryPedidoEnderecamento.SQL.Add('  SUBSTRING(FGO_DOCEND, 21, 8) AS FORDOC, ');
        qryPedidoEnderecamento.SQL.Add('  SUBSTRING(FGO_DOCEND, 29, 1) AS TIPDOC  ');
        qryPedidoEnderecamento.SQL.Add(' FROM ');
        qryPedidoEnderecamento.SQL.Add('  DEL_EXTGOR ');
        qryPedidoEnderecamento.SQL.Add(' INNER JOIN DEL_FATDOR ');
        qryPedidoEnderecamento.SQL.Add('  ON DEL_EXTGOR.FGO_SEQFGO = DEL_FATDOR.FDO_SEQGER ');
        qryPedidoEnderecamento.SQL.Add(' LEFT JOIN DEL_EXTDOR ');
        qryPedidoEnderecamento.SQL.Add('  ON DEL_EXTDOR.FDO_SEQFDO = DEL_FATDOR.AUTOINCREM ');
        qryPedidoEnderecamento.SQL.Add(' WHERE IFNULL(FGO_DOCEND, "") <> ""           ');
        qryPedidoEnderecamento.SQL.Add('   AND FDO_ESPDOC = "PD"                      ');
        qryPedidoEnderecamento.SQL.Add('   AND SUBSTRING(FGO_DOCEND, 1, 12) = :DOCEND ');
        qryPedidoEnderecamento.SQL.Add('   AND SUBSTRING(FGO_DOCEND, 13, 2) = :ESPEND ');
        qryPedidoEnderecamento.SQL.Add('   AND SUBSTRING(FGO_DOCEND, 15, 3) = :SEREND ');
        qryPedidoEnderecamento.SQL.Add('   AND SUBSTRING(FGO_DOCEND, 18, 3) = :EMPEND ');
        qryPedidoEnderecamento.SQL.Add('   AND SUBSTRING(FGO_DOCEND, 21, 8) = :FOREND ');
        qryPedidoEnderecamento.SQL.Add('   AND SUBSTRING(FGO_DOCEND, 29, 1) = :TIPEND ');
        qryPedidoEnderecamento.SQL.Add('   AND IFNULL(FDO_ALTAMZ,"S") = "S" ');
        qryPedidoEnderecamento.SQL.Add(' GROUP BY FDO_CODITE                          ');

        qryPedidoEnderecamento.ParamByName('DOCEND').AsString := endDocumento.strNumdoc;
        qryPedidoEnderecamento.ParamByName('ESPEND').AsString := endDocumento.strEspdoc;
        qryPedidoEnderecamento.ParamByName('SEREND').AsString := endDocumento.strSerie_;
        qryPedidoEnderecamento.ParamByName('EMPEND').AsString := endDocumento.strCodemp;
        qryPedidoEnderecamento.ParamByName('FOREND').AsString := endDocumento.strCliFor;
        qryPedidoEnderecamento.ParamByName('TIPEND').AsString := endDocumento.strTip_FC;
        qryPedidoEnderecamento.Open;

        If Not (qryPedidoEnderecamento.IsEmpty) Then
        Begin
          qryQtdEnderecada.First;
          While Not qryQtdEnderecada.eof Do
          Begin

              If (qryPedidoEnderecamento.Locate('CODITEPEDIDO',qryQtdEnderecada.FieldByName('DET_CODITE').AsString,[])) then
              begin
                If (RoundTo(qryQtdEnderecada.FieldByName('QTDITE').AsFloat,-4) <> RoundTo(qryPedidoEnderecamento.FieldByName('QTDAENDERECAR').AsFloat,-4)) Then
                Begin
                  fltQtdAEnderecar := RoundTo(qryPedidoEnderecamento.FieldByName('QTDAENDERECAR').AsFloat,-4);
                  fltQtdEnderada := RoundTo(qryQtdEnderecada.FieldByName('QTDITE').AsFloat,-4);
                  strCodite:= qryQtdEnderecada.FieldByName('DET_CODITE').AsString;
                  Exit;
                End;
              End;


              qryQtdEnderecada.Next;

          End;  //end Laço qryQtdEnderecada

        End;
      End;
    Finally
      FreeAndNil(qryQtdEnderecada);
      FreeAndNil(qryPedidoEnderecamento);
    End;
  End;
begin
  Try
    With FTransf Do
    Try
      intQtdRegEnt := 0;
      intQtdRegSai := 0;
      fltQtdEnderada := 0.0;
      fltQtdAEnderecar := 0.0;
      strCodite := '';
      strArqMovGer := 'MOVGER';
      strArqMovDet := 'MOVDET';
      dtaDtaEnt    := VS_Date;

      If Assigned(FProgre) Then
      Begin
        FProgre.Position := 0;
        FProgre.Visible  := True;
        FProgre.Max      := 2*RecordCount + 1;
      End;

      DisableControls;

      FblnEndLocal := False;
      If Not Assigned(objEnderecamentoProduto) And blnGerarReserva Then
      Begin
        objEnderecamentoProduto := TEnderecamentoProduto.Create(False);
        FblnEndLocal:= True;
      End;

      objAuditoriaSaldo.Limpar;

      If blnControlaTransacao Then
        fStartTransaction;

      if Not blnUsaLote Then
      Begin
        FEspDoc := 'TA';
        FNumDoc := fRetSequencial_TA;
      End
      Else
      Begin
        FEspDoc := 'TL';
        FNumDoc := fRetSequencial_TL;
      End;

      Result := fGravaMovGerTransf;

      If FblnEndLocal Then
      Begin
        objEnderecamentoProduto.pLimpar;

        FendDocumento.strNumDoc := FNumDoc;
        FendDocumento.strEspDoc := FEspDoc;
        FendDocumento.strSerie_ := '';
        FendDocumento.strCodEmp := VS_strCodEmp;
        FendDocumento.strCliFor := FCodCli;
        FendDocumento.strTip_FC := 'C';

        objEnderecamentoProduto.endDocumento := FendDocumento;
      End;

      If Assigned(objEnderecamentoProduto) Then
          objEnderecamentoProduto.blnGerouTA := False;

      With FTransf Do
      begin
        First;
        While (Not Eof) And Result Do
        Begin
          strSeqSai := '';
          strSeqEnt := '';
          If Assigned(objEnderecamentoProduto) Then
          If objEnderecamentoProduto.fEhProdutoAcabado(FTransf.FieldByName('CODITE').AsString) Then
          Begin
            FTransf.Next;
            Continue;
          End;
          strClaFis := STR_CLASAI;
          Result := Result And fGravaMovDetTransf(strMensagem, strSeqSai);

          strClaFis := STR_CLAENT;
          Result := Result And fGravaMovDetTransf(strMensagem, strSeqEnt);

          If Result Then
            pInsererelacionamentoEntradaComSaida(strAutInc, strSeqSai,  strSeqEnt);

          If Not Result Then
            Raise Exception.Create('Houve inconsistência na gravação da TA. Entre em contato com a Citel.');

          Next;
        End;
      End;

      If (Result) And (Assigned(objEnderecamentoProduto)) Then
        objEnderecamentoProduto.blnGerouTA := True;

      If (Result) Then
      Begin
        If FblnEndLocal Then
          objEnderecamentoProduto.fGerarPedidoParaReservarEstoque;

        pValQuantidade;

        // Sem strSeqOri o documento de origem foi cancelado (não existe mais em MOVGER), pula a validação
        If Not FblnEndLocal And Not fEmptyStr(strSeqOri) Then
          pValQtdEnderecada;


        If (intQtdRegEnt <> intQtdRegSai)  OR ( RoundTo(fltQtdEnderada,-4) <> RoundTo(fltQtdAEnderecar,-4)) Then
          Raise Exception.Create('Houve inconsistência na gravação da TA. Entre em contato com a Citel. ' + #$A#$D +
                                 'Quantidade Registros Saída   = ' + IntToStr(intQtdRegSai) + #$A#$D +
                                 'Quantidade Registros Entrada = ' + IntToStr(IntQtdRegEnt) + #$A#$D +
                                 'Quantidade Registros Endereçados:   = ' + FloatToStrF(fltQtdEnderada, ffFixed, 12, 4) + #$A#$D +
                                 'Quantidade Registros A Endereçar:   = ' + FloatToStrF(fltQtdAEnderecar, ffFixed, 12, 4) + #$A#$D +
                                 'Código Item:   = ' + strCodite + #$A#$D
                               );
      End;

      If Result And (Not objAuditoriaSaldo.fValidouTodas(strCodErrosAuditoria)) Then
      Begin

        Result := False;

        If blnControlaTransacao or FMostraErrosAuditoria Then
          fRollBack;

        FMSGErrosAuditoria := fRetMSGAuditoria(strCodErrosAuditoria);

        If FMostraErrosAuditoria Then
          pMostraErrosAuditoria(strCodErrosAuditoria);

      End;
      If Assigned(FOnBeforeCommit) then
        FOnBeforeCommit;
      If blnControlaTransacao Then
      Begin

        If Result Then
          fCommit
        Else
          fRollBack;

      End;

      If Not Result Then
        If (Not fEmptyStr(strMensagem)) Then
          pMensagemOk(strMensagem);

      EnableControls;
    Except
      On E: Exception Do
      Begin
        fRollBack;
        Result := False;
        pMensagensErro(E.Message, '[fGeraTransferencia]');
      End;
    End;

    If Assigned(FProgre) Then
    Begin
      FProgre.Position := 0;
      FProgre.Visible  := False;
    End;
  Finally
    If FblnEndLocal And Assigned(objEnderecamentoProduto) Then
      FreeAndNil(objEnderecamentoProduto);
  End;
End;

Function TTransferenciaArmazens.fTotalGeral: Double;
Begin
  Result := 0;
End;

Procedure TTransferenciaArmazens.pFormataCampos(cdsClient: TUniClientDataSet);
  Var
    intDecUni: Integer;
begin
  intDecUni := fCfgSis('DECUNI');

  With cdsClient Do
  Begin
    TFloatField(FieldByName('QTDITE')).DisplayFormat := fMskDigitos(intDecUni);
    TFloatField(FieldByName('SALDOS')).DisplayFormat := fMskDigitos(intDecUni);
    TFloatField(FieldByName('SALORI')).DisplayFormat := fMskDigitos(intDecUni);
    TFloatField(FieldByName('MAXORI')).DisplayFormat := fMskDigitos(intDecUni);
    TFloatField(FieldByName('REPORI')).DisplayFormat := fMskDigitos(intDecUni);
    TFloatField(FieldByName('SALDES')).DisplayFormat := fMskDigitos(intDecUni);
    TFloatField(FieldByName('MAXDES')).DisplayFormat := fMskDigitos(intDecUni);
    TFloatField(FieldByName('REPDES')).DisplayFormat := fMskDigitos(intDecUni);

    TFloatField(FieldByName('SALORIRES')).DisplayFormat := fMskDigitos(intDecUni);
    TFloatField(FieldByName('SALORIDIS')).DisplayFormat := fMskDigitos(intDecUni);
    TFloatField(FieldByName('SALDESRES')).DisplayFormat := fMskDigitos(intDecUni);
    TFloatField(FieldByName('SALDESDIS')).DisplayFormat := fMskDigitos(intDecUni);
  End;
end;

function TTransferenciaArmazens.fSomarQuantidadeProduto: Boolean;
begin
  Result := False;

  If Not FSomarQuantidade Then
    Exit;

  If FLimparFiltros Then
    Exit;

  Result := True;
end;

Function TTransferenciaArmazens.fSomaTotalTransferido(strCampo, strCodIte, strArmaze: String;
           fltQtdIte: Double; blnInclusao: Boolean): Double;
Begin
  If blnInclusao Then
    Result := fltQtdIte
  Else
    Result := fltQtdIte - IIF(fSomarQuantidadeProduto, 0, FQtdCur);

  With FCopDad Do
  Begin
    Filter   := strCampo + ' = ' + QuotedStr(strArmaze) + ' AND CODITE = ' + QuotedStr(strCodIte);
    Filtered := True;
    First;
    While Not Eof Do
    Begin
      Result := Result + FieldByName('QTDITE').AsFloat;
      Next;
    End;
  End;

End;

Function TTransferenciaArmazens.fSomaTotalTransferidoOrigem(strCodIte, strArmaze: String;
           fltQtdIte: Double; blnInclusao: Boolean): Double;
Begin
  Result := fSomaTotalTransferido('ARMORI', strCodIte, strArmaze, fltQtdIte, blnInclusao);
End;

Function TTransferenciaArmazens.fSomaTotalTransferidoDestino(strCodIte, strArmaze: String;
           fltQtdIte: Double; blnInclusao: Boolean): Double;
Begin
  Result := fSomaTotalTransferido('ARMDES', strCodIte, strArmaze, fltQtdIte, blnInclusao);
End;

Procedure TTransferenciaArmazens.pImprimeTranferencia;
  Var
    reiReimpressao : TReimpressao;
Begin
  reiReimpressao := TReimpressao.Create(FNumDoc,
                                        FEspDoc,
                                        0,
                                        0,
                                        FCodCli,
                                        VS_strCodEmp,
                                        '',
                                        False,
                                        'C',
                                        False,
                                        True,
                                        False,
                                        '',
                                        '',
                                        False,
                                        0,
                                        False,
                                        '');

  reiReimpressao.pReimprimeDocumento;

  FreeAndNil(reiReimpressao);
End;

procedure TTransferenciaArmazens.pCarregarArmazens(strCodIte, strCodArm: String);
Begin
  FArmazens.Close;
  FArmazens.SQL.Clear;
  FArmazens.SQL.Add('SELECT L.*,');
  FArmazens.SQL.Add(' CADAMZ.AMZ_DESCRI ');
  FArmazens.SQL.Add('FROM CADLOT L');
  FArmazens.SQL.Add('LEFT  JOIN CADAMZ   ON   AMZ_CODAMZ = LOT_NUMLOT ');
  FArmazens.SQL.Add('AND   AMZ_CODEMP = LOT_CODEMP ');
  FArmazens.SQL.Add('WHERE LOT_CODITE = :CODITE');
  FArmazens.SQL.Add('AND LOT_CODEMP = :CODEMP');
  FArmazens.SQL.Add('AND LOT_NUMLOT <> :NUMLOT');
  FArmazens.ParamByName('CODITE').AsString := strCodIte;
  FArmazens.ParamByName('NUMLOT').AsString := strCodArm;
  FArmazens.ParamByName('CODEMP').AsString := VS_strCodEmp;
  FArmazens.Open;
End;

function TTransferenciaArmazens.fValidarArmazemDestino: TTransferenciaArmazens;
Begin
  Result := Self;
  Try
    FTransf.Filter := 'ARMDES <> '''' OR QTDITE > 0';
    FTransf.Filtered := True;
    FTransf.First;
    If FTransf.IsEmpty Then
      raise Exception.Create('Nenhum item foi informado para transferência');
    While Not FTransf.Eof Do
    Begin
      If fEmptyStr(FTransf.FieldByName('ARMDES').AsString) And (FTransf.FieldByName('QTDITE').AsCurrency > 0) Then
        raise Exception.Create('O armazém não foi informado para o produto ' + FTransf.FieldByName('DESITE').AsString);
      If (Not fEmptyStr(FTransf.FieldByName('ARMDES').AsString)) And (FTransf.FieldByName('QTDITE').AsCurrency = 0) Then
        raise Exception.Create('O armazém foi informado para o produto ' + FTransf.FieldByName('DESITE').AsString + ' porém a quantidade informada é zero');
      FTransf.Next;
    End;
  Finally
    FTransf.Filtered := False;
  End;
End;

function TTransferenciaArmazens.fGeraTransferenciaProdutoAcabado(blnUsaLote, blnControlaTransacao,
      blnGerarReserva: Boolean): TTransferenciaArmazens;
Begin
  Result := Self;
  FTransf.DisableControls;
  FTransf.Filter := 'ARMDES <> '''' AND QTDITE > 0';
  FTransf.Filtered := True;
  Try
    fGeraTransferencia(blnUsaLote,blnControlaTransacao, blnGerarReserva);
  Finally
    FTransf.Filtered := False;
    FTransf.EnableControls;
  End;
End;

procedure pCriaDataSetItensTL(var ACds: TUniClientDataSet);
begin
  ACds := TUniClientDataSet.Create(nil);

  ACds.FieldDefs.Add('CODITE', ftString, fTamCodIte);
  ACds.FieldDefs.Add('ARMDES', ftString, 30);
  ACds.FieldDefs.Add('ARMORI', ftString, 30);
  ACds.FieldDefs.Add('QTDITE', ftFloat);
  ACds.CreateDataSet;
  ACds.Open;
end;

end.
