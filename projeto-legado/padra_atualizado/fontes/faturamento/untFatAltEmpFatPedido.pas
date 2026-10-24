unit untFatAltEmpFatPedido;

interface

uses System.Classes, System.SysUtils, untFuncFat, System.StrUtils, Uni, untFuncFatTypes;

type
  IFatDevolucaoRegimeEspecial = interface
    ['{EBF16692-59CA-45B2-9996-63360665B994}']
    function fDevolucaoRegimeEspecial(): Boolean;
  end;

  IFatTransfEstoqueParaEmpresaFaturamentoPedido = interface
    ['{AB4390B0-717A-4E24-9917-D5BF21A9AD44}']
    function fTransferirEstoqueParaEmpresaFaturamento(): Boolean;
  end;

  IFatAlterarEmpresaFaturamentoPedido = interface
    ['{D16A40DE-FAB3-4E0C-8553-1B3ABFAD4D2F}']
    function fAlterarEmpresaFaturamentoPedido(intSepImp: Integer = -1): Boolean;
  end;

  IFatReverterEmpresaFaturamentoPedido = interface
    ['{ECE72E9D-56FA-4947-A330-036E80889FCE}']
    function fReverterEmpresaFaturamentoPedido(): Boolean;
  end;

  IFatAltEmpFatPedidoFuncoes = interface
    ['{159AB593-54ED-48B7-A9D5-4FEA437BDE4F}']
    function fGravaEntGer(AObjVenda: TFatVenda; AEmpresaOrigem, AEmpresaDestino: String; var strAutIncEnt: String): Boolean;
    function fGravaEntDet(AObjVenda: TFatVenda; AEmpresaDestino, AAutIncEnt: String; const Itens: TMatrizFechamento): Boolean;
    function fRealizaTransferencia(AObjVenda: TFatVenda; AEmpresaOrigem, AAutIncEnt: String; AblnNotaFiscal: Boolean): Boolean;
    function fRealizaEntrada(AObjVenda: TFatVenda; AEmpresaDestino, AAutIncEnt: String; AEspDocOri: String = ''): Boolean;
  end;

  TFatAlterarEmpresaFaturamentoPedido = class(TInterfacedObject, IFatAlterarEmpresaFaturamentoPedido)
  private
    FNumDoc: String;
    FEspDoc: String;
    FCodEmp: String;
    FEmp_CD: String;
    constructor Create(ANumDoc, AEspDoc, ACodEmp: String);
    function fSelecionarEmpresa(): Boolean;
    function fAlterarEmpresaCD(): Boolean;
    function fTransferirEstoque(): Boolean;
    function fReprocessarItens(): Boolean;
    function fValidarLoteItens(intSepImp: Integer): Boolean;
    function fValidarSeparacao(intSepImp: Integer): Boolean;
    function fGeraTransferenciaParaEmpresaFaturamentoPedidoWms: Boolean;
    function fExisteLote(ACodIte, ACodEmp: String): Boolean;
    function fExisteLotePrincipal(ACodIte, ACodEmp: String): Boolean;
  public
    class function New(ANumDoc, AEspDoc, ACodEmp: String): IFatAlterarEmpresaFaturamentoPedido;

    function fAlterarEmpresaFaturamentoPedido(intSepImp: Integer = -1): Boolean;
  end;

  TFatReverterEmpresaFaturamentoPedido = class(TInterfacedObject, IFatReverterEmpresaFaturamentoPedido)
  private
    FNumPed: String;
    FEmp_CD: String;
    FEmpOri: String;
    constructor Create(AEmpOri: String);
    function fSelecionarEmpresa(): Boolean;
    function fSelecionarPedido(): Boolean;
    function fReverterTransferenciaEstoque(): Boolean;
    function fReverterEmpresaCD(): Boolean;
    function fReprocessarItens(): Boolean;
  public
    class function New(AEmpOri: String): IFatReverterEmpresaFaturamentoPedido;
    function fReverterEmpresaFaturamentoPedido(): Boolean;
  end;

  TFatTransfEstoqueParaEmpresaFaturamentoPedido = class(TInterfacedObject, IFatTransfEstoqueParaEmpresaFaturamentoPedido)
  private
    FObjVenda: TFatVenda;
    FCliFil: String;
    FEmpresaOrigem: String;
    FEmpresaDestino: String;
    FAutIncEnt: String;
    FEspDocOri : String;
    FObjFuncoes: IFatAltEmpFatPedidoFuncoes;

    constructor Create(AObjVenda: TFatVenda; AEmpresaOrigem: String; AEmpresaDestino: String; ARegimeEspecial: Boolean; const AEspDocOri : String);
    function fGravaEntGer: Boolean;
    function fGravaEntDet: Boolean;
    function fRealizaTransferencia: Boolean;
    function fRealizaEntrada: Boolean;
    function fGeraEntDetComBaseLotDorSeExistir: Boolean;

    function fGravaEntDetAbastecimentoDeposito: Boolean;
    function fAbastecimentoDepositoAndNotaFiscal: Boolean;
    function fRegimeEspecialAndNotaFiscal: Boolean;
    function fEhTipoDeDocumentoFiscal: Boolean; overload;
    function fEhTipoDeDocumentoFiscal(const strEspDoc : String): Boolean; overload;
  public
    class function New(AObjVenda: TFatVenda; AEmpresaOrigem: String;
      AEmpresaDestino: String; ARegimeEspecial: Boolean; const AEspDocOri : String): IFatTransfEstoqueParaEmpresaFaturamentoPedido;

    function fTransferirEstoqueParaEmpresaFaturamento(): Boolean;
  end;

  TFatDevolucaoRegimeEspecial = class(TInterfacedObject, IFatDevolucaoRegimeEspecial)
  private
    FObjVenda: TFatVenda;
    FEmpresaOrigem: String;
    FEmpresaDestino: String;
    FEmpresaEstFis: String;
    FAutIncEnt: String;
    FstrCodFpgVenda: String;
    FstrRegEsp: String;
    FEspDocOri: String;

    FObjFuncoes: IFatAltEmpFatPedidoFuncoes;

    constructor Create(AObjVenda: TFatVenda; AEmpresaOrigem, AEmpresaDestino, AEmpresaEstFis, ARegEsp, AEspDocOri: String);

    function fGravaEntGer(AEmpresaOrigem, AEmpresaDestino: String): Boolean;
    function fGravaEntDet(AEmpresaDestino: String): Boolean;
    function fRealizaTransferencia(AEmpresaOrigem: String): Boolean;
    function fRealizaEntrada(AEmpresaDestino: String): Boolean;

    function fRegimeEspecialAndNotaFiscal: Boolean;
  public
    class function New(AObjVenda: TFatVenda; AEmpresaOrigem, AEmpresaDestino, AEmpresaEstFis, ARegEsp, AEspDocOri: String): IFatDevolucaoRegimeEspecial;

    function fDevolucaoRegimeEspecial(): Boolean;
  end;

  TFatAltEmpFatPedidoFuncoes = class(TInterfacedObject, IFatAltEmpFatPedidoFuncoes)
  private
    FblnDevRegimeEspecial: Boolean;
    FEntradaComoNotaRegimeEspecial: Boolean;
    function fDeveGerarNotaFiscal(AObjVenda: TFatVenda; const AEspDocOri : String) : Boolean;
    function fEhTipoDeDocumentoFiscal(const strEspDoc : String): Boolean;
  public
    constructor Create(blnDevRegimeEspecial: Boolean; blnEntradaComoNotaRegimeEspecial: Boolean);

    class function New(blnDevRegimeEspecial: Boolean; blnEntradaComoNotaRegimeEspecial: Boolean): IFatAltEmpFatPedidoFuncoes;

    function fGravaEntGer(AObjVenda: TFatVenda; AEmpresaOrigem, AEmpresaDestino: String; var strAutIncEnt: String): Boolean;
    function fGravaEntDet(AObjVenda: TFatVenda; AEmpresaDestino, AAutIncEnt: String; const Itens: TMatrizFechamento): Boolean;
    function fRealizaTransferencia(AObjVenda: TFatVenda; AEmpresaOrigem, AAutIncEnt: String; AblnNotaFiscal: Boolean): Boolean;
    function fRealizaEntrada(AObjVenda: TFatVenda; AEmpresaDestino, AAutIncEnt: String; AEspDocOri: String = ''): Boolean;
  end;

implementation

uses
  untEntGer, untFuncoesDiarias, untFuncoesSimples, untTLock, untCadLote,
  Faturamento.Classes.TAlterarPedido;

{ TFatTransfEstoqueParaEmpresaFaturamentoPedido }

constructor TFatTransfEstoqueParaEmpresaFaturamentoPedido.Create(AObjVenda: TFatVenda;
  AEmpresaOrigem: String; AEmpresaDestino: String; ARegimeEspecial: Boolean; const AEspDocOri : String);
begin
  FObjVenda := AObjVenda;
  FCliFil := fRetornaClienteFilial(AEmpresaDestino);
  FEspDocOri := AEspDocOri;
  FEmpresaOrigem := AEmpresaOrigem;
  FEmpresaDestino := AEmpresaDestino;
  FObjFuncoes := TFatAltEmpFatPedidoFuncoes.New(False, ARegimeEspecial And fRegimeEspecialAndNotaFiscal);
end;

class function TFatTransfEstoqueParaEmpresaFaturamentoPedido.New(AObjVenda: TFatVenda;
  AEmpresaOrigem: String; AEmpresaDestino: String; ARegimeEspecial: Boolean; const AEspDocOri : String): IFatTransfEstoqueParaEmpresaFaturamentoPedido;
begin
  Result := Self.Create(AObjVenda, AEmpresaOrigem, AEmpresaDestino, ARegimeEspecial, AEspDocOri);
end;

function TFatTransfEstoqueParaEmpresaFaturamentoPedido.fTransferirEstoqueParaEmpresaFaturamento: Boolean;
Var
  LEmpresaBackup: String;
  LInTransaction: Boolean;
begin
  Result := False;
  LInTransaction := fInTransaction;
  LEmpresaBackup := VS_strCodEmp;
  Try
    If Not LInTransaction Then
      fStartTransaction();

    Result := fGravaEntGer And
              fGravaEntDet And
              fRealizaTransferencia And
              fRealizaEntrada;
  Finally
    pSetaEmpresaLogada(LEmpresaBackup);

    If (Not LInTransaction) Then
    Begin
      If Result Then
        fCommit()
      Else
        fRollBack();
    End;
  End;
end;

function TFatTransfEstoqueParaEmpresaFaturamentoPedido.fGravaEntDet: Boolean;
begin
  if fGeraEntDetComBaseLotDorSeExistir then
    Result := fGravaEntDetAbastecimentoDeposito
  else
    Result := FObjFuncoes.fGravaEntDet(
      FObjVenda,
      FEmpresaDestino,
      FAutIncEnt,
      FObjVenda.arrMatItens);
end;

function TFatTransfEstoqueParaEmpresaFaturamentoPedido.fGravaEntGer: Boolean;
begin
  Result := FObjFuncoes.fGravaEntGer(
    FObjVenda,
    FEmpresaOrigem,
    FEmpresaDestino,
    FAutIncEnt);
end;

function TFatTransfEstoqueParaEmpresaFaturamentoPedido.fRealizaEntrada: Boolean;
begin
  Result := FObjFuncoes.fRealizaEntrada(
    FObjVenda,
    FEmpresaDestino,
    FAutIncEnt,
    FEspDocOri);
end;

function TFatTransfEstoqueParaEmpresaFaturamentoPedido.fRealizaTransferencia: Boolean;
begin
  Result := FObjFuncoes.fRealizaTransferencia(
    FObjVenda,
    FEmpresaOrigem,
    FAutIncEnt,
    fAbastecimentoDepositoAndNotaFiscal or fRegimeEspecialAndNotaFiscal)
end;

function TFatTransfEstoqueParaEmpresaFaturamentoPedido.fGeraEntDetComBaseLotDorSeExistir: Boolean;
begin
  Result := False;

  If FObjVenda.blnAbastecimentoDeposito Then
    Exit(True);

  If FObjVenda.blnRegimeEspecialPorEmpresaComFaturamentoDuplo Then
    Exit(True);

  If FObjVenda.blnTransferenciaParaEmpresaFaturamentoPedidoWms Then
    Exit(True);
end;

function TFatTransfEstoqueParaEmpresaFaturamentoPedido.fAbastecimentoDepositoAndNotaFiscal: Boolean;
  const
    SEGUIR_FATURAMENTO : String = '1';
    TRANSFERENCIA_ESTOQUE : String = '2';
begin
  Result := True;

  If (FObjVenda.strOpcDoc = 'DV') And
     (FObjVenda.blnEhDevolucaoAbastecimentoDeposito) And
     (FObjVenda.blnDevolucaoEmpresaAbastecimento) Then
  Begin
    If (fCfgSis('ABADEV', varString) = SEGUIR_FATURAMENTO) Then
    Begin
      If (fEhTipoDeDocumentoFiscal(FEspDocOri)) Then
        Exit(True)
      Else
        Exit(False);
    End;
    If (fCfgSis('ABADEV', varString) = TRANSFERENCIA_ESTOQUE) Then
      Exit(False);
  End;

  if (not FObjVenda.blnAbastecimentoDeposito) then
    Exit(False);

  if (not fEhTipoDeDocumentoFiscal) then
    Exit(False);
end;

function TFatTransfEstoqueParaEmpresaFaturamentoPedido.fEhTipoDeDocumentoFiscal(
  const strEspDoc: String): Boolean;
begin
  Result := True;

  If (strEspDoc = 'NF') Then
    Exit;

  If (strEspDoc = 'IF') Then
    Exit;

  Result := False;
end;

function TFatTransfEstoqueParaEmpresaFaturamentoPedido.fEhTipoDeDocumentoFiscal: Boolean;
begin
  Result := True;

  If (FObjVenda.strTipPed = 'A') Then
    Exit;

  If (FObjVenda.strTipPed = 'C') Then
    Exit;

  Result := False;
end;

function TFatTransfEstoqueParaEmpresaFaturamentoPedido.fRegimeEspecialAndNotaFiscal: Boolean;
begin
  Result := True;
  if fEmptyStr(FObjVenda.strEmpOriRegEsp) then
    Exit(False);

  if not (FObjVenda.strTipPed = 'A') then
    Exit(False);
end;

function TFatTransfEstoqueParaEmpresaFaturamentoPedido.fGravaEntDetAbastecimentoDeposito: Boolean;
Var
  itemPedido: TDadosFechamento;
  itensNovos: TMatrizFechamento;
  intIdxItem: Integer;
  qryLotDor : TUniQuery;

  fltTotIteAcu : Double;
  fltTotCusAcu : Double;
  fltTotCu2Acu : Double;
  fltTotMedAcu : Double;
  fltTotUltAcu : Double;
  fltTotImpAcu : Double;

  fltPercentual: Double;

  procedure pAddItemNovo;
  Begin
    SetLength(itensNovos, Length(itensNovos) + 1 );
    itensNovos[High(itensNovos)] := itemPedido;
    itensNovos[High(itensNovos)].intAutInc := High(itensNovos) + 1;
  End;
begin
  qryLotDor := fCriaQuery(Nil);
  Try
    qryLotDor.Close;
    qryLotDor.SQL.Clear;

    qryLotDor.SQL.Add(' SELECT SQL_NO_CACHE        ');
    qryLotDor.SQL.Add('        LDO_NUMLOT,         ');
    qryLotDor.SQL.Add('        LDO_QTDITE          ');
    qryLotDor.SQL.Add(' FROM LOTDOR                ');
    qryLotDor.SQL.Add(' WHERE LDO_SEQFDO = :SEQFDO ');

    FObjVenda.blnExpedicaoTeveQuebraDeItensRastreaveis := False;
    SetLength(itensNovos,0);
    For itemPedido in FObjVenda.arrMatItens Do
    Begin
      If fProdutoRastreavel(itemPedido.strCodIte) Then
        pAddItemNovo
      Else
      Begin
        qryLotDor.Close;
        qryLotDor.ParamByName('SEQFDO').AsString := itemPedido.strSeqDet;
        qryLotDor.Open;

        If qryLotDor.IsEmpty Then
          pAddItemNovo
        Else
        Begin
          fltTotIteAcu := 0.00;
          fltTotCusAcu := 0.00;
          fltTotCu2Acu := 0.00;
          fltTotMedAcu := 0.00;
          fltTotUltAcu := 0.00;
          fltTotImpAcu := 0.00;

          qryLotDor.First;
          While Not qryLotDor.Eof Do
          Begin
            pAddItemNovo;

            intIdxItem := High(itensNovos);
            itensNovos[intIdxItem].strNumLot := qryLotDor.FieldByName('LDO_NUMLOT').AsString;
            itensNovos[intIdxItem].fltQtdIte := qryLotDor.FieldByName('LDO_QTDITE').AsFloat;

            If qryLotDor.RecNo <> qryLotDor.RecordCount Then
            Begin
              FObjVenda.blnExpedicaoTeveQuebraDeItensRastreaveis := True;

              fltPercentual := qryLotDor.FieldByName('LDO_QTDITE').AsFloat / itensNovos[intIdxItem].fltQtdIte * 100;

              itensNovos[intIdxItem].fltTotIte := fFormataFloat( itensNovos[intIdxItem].fltTotIte * fltPercentual / 100, 2);
              itensNovos[intIdxItem].fltTotCus := fFormataFloat( itensNovos[intIdxItem].fltTotCus * fltPercentual / 100, 2);
              itensNovos[intIdxItem].fltTotCu2 := fFormataFloat( itensNovos[intIdxItem].fltTotCu2 * fltPercentual / 100, 2);
              itensNovos[intIdxItem].fltTotMed := fFormataFloat( itensNovos[intIdxItem].fltTotMed * fltPercentual / 100, 2);
              itensNovos[intIdxItem].fltTotUlt := fFormataFloat( itensNovos[intIdxItem].fltTotUlt * fltPercentual / 100, 2);
              itensNovos[intIdxItem].fltTotImp := fFormataFloat( itensNovos[intIdxItem].fltTotImp * fltPercentual / 100, 2);

              fltTotIteAcu := fltTotIteAcu + itensNovos[intIdxItem].fltTotIte;
              fltTotCusAcu := fltTotCusAcu + itensNovos[intIdxItem].fltTotCus;
              fltTotCu2Acu := fltTotCu2Acu + itensNovos[intIdxItem].fltTotCu2;
              fltTotMedAcu := fltTotMedAcu + itensNovos[intIdxItem].fltTotMed;
              fltTotUltAcu := fltTotUltAcu + itensNovos[intIdxItem].fltTotUlt;
              fltTotImpAcu := fltTotImpAcu + itensNovos[intIdxItem].fltTotImp;

            End
            Else
            Begin
              itensNovos[intIdxItem].fltTotIte := fFormataFloat( itensNovos[intIdxItem].fltTotIte - fltTotIteAcu, 2);
              itensNovos[intIdxItem].fltTotCus := fFormataFloat( itensNovos[intIdxItem].fltTotCus - fltTotCusAcu, 2);
              itensNovos[intIdxItem].fltTotCu2 := fFormataFloat( itensNovos[intIdxItem].fltTotCu2 - fltTotCu2Acu, 2);
              itensNovos[intIdxItem].fltTotMed := fFormataFloat( itensNovos[intIdxItem].fltTotMed - fltTotMedAcu, 2);
              itensNovos[intIdxItem].fltTotUlt := fFormataFloat( itensNovos[intIdxItem].fltTotUlt - fltTotUltAcu, 2);
              itensNovos[intIdxItem].fltTotImp := fFormataFloat( itensNovos[intIdxItem].fltTotImp - fltTotImpAcu, 2);
            End;

            qryLotDor.Next;
          End;
        End;
      End;
    End;
  Finally
    FreeAndNil(qryLotDor);
  End;

  Result := FObjFuncoes.fGravaEntDet(FObjVenda, FEmpresaDestino, FAutIncEnt, itensNovos);
end;

{ TFatAlterarEmpresaFaturamentoPedido }

constructor TFatAlterarEmpresaFaturamentoPedido.Create(ANumDoc, AEspDoc,
  ACodEmp: String);
begin
  FNumDoc := ANumDoc;
  FEspDoc := AEspDoc;
  FCodEmp := ACodEmp;
end;

function TFatAlterarEmpresaFaturamentoPedido.fAlterarEmpresaCD: Boolean;
var
  LQuery: TUniQuery;
  objCadLot: TCadLot;
begin
  Result := fExecutaSQL(
              ' UPDATE ' +
              '   FATGOR ' +
              '   INNER JOIN EXTGOR ' +
              '     ON EXTGOR.FGO_SEQFGO = FATGOR.AUTOINCREM ' +
              '   INNER JOIN FATDOR ' +
              '     ON FATDOR.FDO_SEQGER = FATGOR.AUTOINCREM ' +
              '   INNER JOIN EXTDOR ' +
              '     ON EXTDOR.FDO_SEQFDO = FATDOR.AUTOINCREM ' +
              ' SET ' +
              '   FDO_LOTORI = FDO_NUMLOT, ' +
              '   FGO_ENT_CD = "S", ' +
              '   FGO_EMP_CD = "' + FEmp_CD + '", ' +
              '   FDO_EMPITE = "' + FEmp_CD + '", ' +
              '   FGO_EMPEXP = "' + FEmp_CD + '"  ' +
              ' WHERE FGO_NUMDOC = "' + FNumDoc + '" ' +
              '   AND FGO_ESPDOC = "' + FEspDoc + '" ' +
              '   AND FGO_CODEMP = "' + FCodEmp + '" '
            );

  If Result Then
  Begin
    If (Not fUsaRotinaWMS(FEmp_CD)) Then
    Begin
      LQuery := fCriaQuery;
      objCadLot := TCadLot.Create(nil);
      Try
        LQuery.SQL.Text :=
            ' SELECT AUTOINCREM, FDO_CODITE, IFNULL(FDO_NUMLOT, "") AS FDO_NUMLOT FROM FATDOR '+
            '  WHERE FDO_NUMDOC = "' + FNumDoc + '" ' +
            '    AND FDO_ESPDOC = "' + FEspDoc + '" ' +
            '    AND FDO_CODEMP = "' + FCodEmp + '" ';

        LQuery.Open;
        While Not LQuery.Eof Do
        Begin
          If (Not fEmptyStr(LQuery.FieldByName('FDO_NUMLOT').AsString)) Then
          Begin
            If (Not objCadLot.fExisteLote(LQuery.FieldByName('FDO_NUMLOT').AsString, FEmp_CD, LQuery.FieldByName('FDO_NUMLOT').AsString)) Then
            Begin
              Result := Result And fExecutaSQL(
                                     ' UPDATE ' +
                                     '   FATDOR ' +
                                     ' SET ' +
                                     '   FDO_NUMLOT = NULL ' +
                                     ' WHERE AUTOINCREM = "' + LQuery.FieldByName('AUTOINCREM').AsString + '" ');
            End;
          End;

          LQuery.Next;
        End;
      Finally
        FreeAndNil(LQuery);
        FreeAndNil(objCadLot);
      End;
    End;
  End;
end;

function TFatAlterarEmpresaFaturamentoPedido.fAlterarEmpresaFaturamentoPedido(intSepImp: Integer = -1): Boolean;
Var
  LObjLock: TLock;
  LLocked: Boolean;

  function fLock(ATabela: String): Boolean;
  begin
    Result := True;
    LLocked := Not LObjLock.fLock_Unlock(ATabela + FNumDoc + FEspDoc + FCodEmp, True, False);
    If LLocked Then
      If fGetIdConnectionLock(ATabela + FNumDoc + FEspDoc + FCodEmp, True) <> fGetConnectionID Then
      Begin
        fMensagem('', 'Esse Documento está sendo utilizado em Outra Estação por ' +
                      fGetHostLock(ATabela + FNumDoc + FEspDoc + FCodEmp)  + '!', ['&Ok']);
        Result := False;
      End;
  end;

begin
  Result := False;
  LLocked := False;
  LObjLock := TLock.Create;

  Try
    If Not fLock('FATGOR') Then
      Exit;

    If Not fLock('CADREC') Then
      Exit;

    If Not fSelecionarEmpresa Then
      Exit;

    If Not fValidarLoteItens(intSepImp) Then
      Exit;

    Try
      fStartTransaction;

      If Not fAlterarEmpresaCD Then
        Exit;

      If Not fTransferirEstoque Then
        Exit;

      If Not fReprocessarItens Then
        Exit;

      Result := True;
    Finally
      If Result Then
        fCommit
      Else
        fRollback;
    End;

  Finally
    If Not LLocked Then
      LObjLock.pDestravarTodos;
  End;

end;

function TFatAlterarEmpresaFaturamentoPedido.fReprocessarItens: Boolean;
begin
  Result := fExecutaSQL(
              ' UPDATE ' +
              '   FATDOR ' +
              '   INNER JOIN ITEGER ' +
              '     ON ITE_CODITE = FDO_CODITE ' + //Sem filtrar empresa do iteger para reprocessar em todas
              ' SET ' +
              '   ITE_REPAUD = "S" ' +
              ' WHERE FDO_NUMDOC = "' + FNumDoc + '" ' +
              '   AND FDO_ESPDOC = "' + FEspDoc + '" ' +
              '   AND FDO_CODEMP = "' + FCodEmp + '" '
            );
end;

function TFatAlterarEmpresaFaturamentoPedido.fSelecionarEmpresa: Boolean;
const
  SQL_EMPRESAS =
    'GROUP_CONCAT(EMP_CODEMP,"-",EMP_NOMFAN ORDER BY EMP_CODEMP SEPARATOR "-->")';
var
  LEmpresa: String;
  LEmpresas: TArray<String>;
  LEmpresasCD: TArray<String>;
begin
  Result := False;

  SetLength(LEmpresasCD, 0);

  LEmpresas := String(fCampoTabela(SQL_EMPRESAS,'CADEMP',[],[])).Split(['-->']);

  For LEmpresa In LEmpresas Do
  Begin
    If LeftStr(LEmpresa, 3) = FCodEmp Then
      Continue;

    If Not fCfgSis('ENT_CD', varBoolean, LeftStr(LEmpresa, 3)) Then
      Continue;

    If fCfgSis('EMP_CD', VarString, LeftStr(LEmpresa, 3)) <> LeftStr(LEmpresa, 3) Then
      Continue;

    SetLength(LEmpresasCD, Length(LEmpresasCD) + 1);
    LEmpresasCD[High(LEmpresasCD)] := LEmpresa;
  End;

  If Length(LEmpresasCD) = 0 Then
  Begin
    pMensagemOk('Não foram encontradas empresas configuradas '+
      'como C.D. para selecionar!');
    Exit;
  End;

  If Length(LEmpresasCD) = 1 Then
    FEmp_CD := LEmpresasCD[0]
  Else
    FEmp_CD := LeftStr(LEmpresasCD[fGetMenu('Emp. Faturamento', LEmpresasCD, 0) -1],3);

  Result := fPergunta('Confirma selecionar a empresa ' + FEmp_CD +
    ' para faturamento do pedido ' + FNumDoc + '-' + FEspDoc + '-' + FCodEmp + ' ?');
end;

function TFatAlterarEmpresaFaturamentoPedido.fTransferirEstoque: Boolean;
  Var
    objAltPed: TAlterarPedido;
begin
  Result := False;

  If Not fCfgSis('TRARET', VarBoolean, FCodEmp) Then
    Exit(True);

  If Not fCfgSis('TRARET', VarBoolean, FEmp_CD) Then
    Exit(True);

  objAltPed := TAlterarPedido.Create(nil);

  Try
    objAltPed.strNumPed := FNumDoc;
    objAltPed.strEspPed := FEspDoc;
    objAltPed.strEmpPed := FCodEmp;

    If Not objAltPed.fCarregarPedido Then
      Exit;

    If Not objAltPed.fCalculaTotalPedido Then
      Exit;

    If fUsaRotinaWMS Then
      objAltPed.objVenda.blnTransferenciaParaEmpresaFaturamentoPedidoWms := True;

    Result := TFatTransfEstoqueParaEmpresaFaturamentoPedido.New
      (objAltPed.objVenda, FCodEmp, FEmp_CD, False, objAltPed.objVenda.strEspDoc).fTransferirEstoqueParaEmpresaFaturamento;
  Finally
    FreeAndNil(objAltPed);
  End;

end;

function TFatAlterarEmpresaFaturamentoPedido.fExisteLote(ACodIte, ACodEmp: String): Boolean;
begin
  Result := fCampoTabela('COUNT(*)', 'CADLOT', ['LOT_CODITE', 'LOT_CODEMP'], [ACodIte, ACodEmp], False) > 0;
end;

function TFatAlterarEmpresaFaturamentoPedido.fExisteLotePrincipal(ACodIte, ACodEmp: String): Boolean;
begin
  Result := fCampoTabela('COUNT(*)', 'CADLOT', ['LOT_CODITE', 'LOT_CODEMP', 'LOT_ARMPRI'], [ACodIte, ACodEmp, 'S'], False) > 0;
end;

function TFatAlterarEmpresaFaturamentoPedido.fValidarLoteItens(intSepImp: Integer): Boolean;
var
  qryDoc: TUniQuery;
  LErros: String;
begin
  Result := True;

  If fEmptyStr(FEmp_CD) Then
    Exit;

  If Not fCfgSis('TRARET', VarBoolean, FCodEmp) Then
    Exit(True);

  If Not fCfgSis('TRARET', VarBoolean, FEmp_CD) Then
    Exit(True);

  If fGeraTransferenciaParaEmpresaFaturamentoPedidoWms Then
  Begin
    Result := fValidarSeparacao(intSepImp);
    Exit;
  End;

  qryDoc := fCriaQuery;

  Try
    qryDoc.SQL.Clear;
    qryDoc.SQL.Add('SELECT FDO_CODITE FROM FATDOR ');
    qryDoc.SQL.Add('WHERE FDO_NUMDOC = :NUMDOC ');
    qryDoc.SQL.Add('  AND FDO_ESPDOC = :ESPDOC ');
    qryDoc.SQL.Add('  AND FDO_CODEMP = :CODEMP ');
    qryDoc.ParamByName('NUMDOC').AsString := FNumDoc;
    qryDoc.ParamByName('ESPDOC').AsString := FEspDoc;
    qryDoc.ParamByName('CODEMP').AsString := FCodEmp;
    qryDoc.Open;

    While not qryDoc.eof Do
    Begin
      If qryDoc.FieldByName('FDO_CODITE').AsString = fCfgSis('ITESER') Then
        Continue;

      If qryDoc.FieldByName('FDO_CODITE').AsString = fCfgSis('SERTER') Then
        Continue;

      If fExisteLote(qryDoc.FieldByName('FDO_CODITE').AsString, FCodEmp) Then
      Begin
        If not (fExisteLotePrincipal(qryDoc.FieldByName('FDO_CODITE').AsString, FCodEmp) And
                fExisteLotePrincipal(qryDoc.FieldByName('FDO_CODITE').AsString, FEmp_CD)) Then
        Begin
          LErros := LErros + IIF(fEmptyStr(LErros),'',',') + qryDoc.FieldByName('FDO_CODITE').AsString;
        End;
      End;

      qryDoc.next;
    End;

    Result := fEmptyStr(LErros);

    If not Result Then
    Begin
      fMensagem('Atenção!', 'Para poder continuar, o(s) produto(s) relacionado(s) abaixo devem ter lote principal para venda '+
                            'na empresa original do pedido e na empresa escolhida para faturamento:' + #13 +
                            '[ ' + LErros + ' ]', ['&Ok']);
    End;

  Finally
    FreeAndNil(qryDoc);
  End;
end;

function TFatAlterarEmpresaFaturamentoPedido.fValidarSeparacao(intSepImp: Integer): Boolean;
begin
  Result := False;

  If (intSepImp > 0) Then
    Exit(True);

  If (intSepImp = 0) Then
  Begin
    fMensagem('Atenção!', 'Sistema está configurado para gerar transferência nessa operação e a separação do pedido selecionado ainda não foi impressa. '+
                          'Antes de trocar a empresa de faturamento, realize a impressão da separação para definir de onde o saldo vai sair na transferência!', ['&Ok']);
    Exit(False);
  End;
end;

function TFatAlterarEmpresaFaturamentoPedido.fGeraTransferenciaParaEmpresaFaturamentoPedidoWms: Boolean;
begin
  Result := False;
  If Not fEmptyStr(FEmp_CD) Then
     If fCfgSis('TRARET', VarBoolean, FCodEmp) Then
       If fCfgSis('TRARET', VarBoolean, FEmp_CD) Then
         If fUsaRotinaWMS Then
           Exit(True);
end;

class function TFatAlterarEmpresaFaturamentoPedido.New(ANumDoc, AEspDoc,
  ACodEmp: String): IFatAlterarEmpresaFaturamentoPedido;
begin
  Result := Self.Create(ANumDoc, AEspDoc, ACodEmp);
end;

{ TFatReverterEmpresaFaturamentoPedido }

constructor TFatReverterEmpresaFaturamentoPedido.Create(AEmpOri: String);
begin
  FEmpOri := AEmpOri;
end;

function TFatReverterEmpresaFaturamentoPedido.fReprocessarItens: Boolean;
begin
  Result := fExecutaSQL(
              ' UPDATE ' +
              '   FATDOR ' +
              '   INNER JOIN ITEGER ' +
              '     ON ITE_CODITE = FDO_CODITE ' + //Sem filtrar empresa do iteger para reprocessar em todas
              ' SET ' +
              '   ITE_REPAUD = "S" ' +
              ' WHERE FDO_NUMDOC = "' + FNumPed + '" ' +
              '   AND FDO_ESPDOC = "PD" ' +
              '   AND FDO_CODEMP = "' + FEmpOri + '" '
            );
end;

function TFatReverterEmpresaFaturamentoPedido.fReverterEmpresaCD: Boolean;
begin
  Result := fExecutaSQL(
              ' UPDATE ' +
              '   FATGOR ' +
              '   INNER JOIN EXTGOR ' +
              '     ON EXTGOR.FGO_SEQFGO = FATGOR.AUTOINCREM ' +
              '   INNER JOIN FATDOR ' +
              '     ON FATDOR.FDO_SEQGER = FATGOR.AUTOINCREM ' +
              '   INNER JOIN EXTDOR ' +
              '     ON EXTDOR.FDO_SEQFDO = FATDOR.AUTOINCREM ' +
              ' SET ' +
              '   FDO_NUMLOT = FDO_LOTORI, ' +
              '   FGO_ENT_CD = "N", ' +
              '   FGO_EMP_CD = NULL, ' +
              '   FDO_EMPITE = "' + FEmpOri + '", ' +
              '   FGO_EMPEXP = "' + FEmpOri + '"  ' +
              ' WHERE FGO_NUMDOC = "' + FNumPed + '" ' +
              '   AND FGO_ESPDOC = "PD" ' +
              '   AND FGO_CODEMP = "' + FEmpOri + '" '
            );

  Result := Result And fExecutaSQL(
              ' UPDATE ' +
              '   FATDOR ' +
              '   INNER JOIN EXTDOR ' +
              '     ON EXTDOR.FDO_SEQFDO = FATDOR.AUTOINCREM ' +
              ' SET ' +
              '   FDO_LOTORI = NULL ' +
              ' WHERE FDO_NUMDOC = "' + FNumPed + '" ' +
              '   AND FDO_ESPDOC = "PD" ' +
              '   AND FDO_CODEMP = "' + FEmpOri + '" '
            );
end;

function TFatReverterEmpresaFaturamentoPedido.fReverterEmpresaFaturamentoPedido: Boolean;
Var
  LObjLock: TLock;
  LLocked: Boolean;

  function fLock(ATabela: String): Boolean;
  begin
    Result := True;
    LLocked := Not LObjLock.fLock_Unlock(ATabela + FNumPed + 'PD' + FEmpOri, True, False);
    If LLocked Then
      If fGetIdConnectionLock(ATabela + FNumPed + 'PD' + FEmpOri, True) <> fGetConnectionID Then
      Begin
        fMensagem('', 'Esse Documento está sendo utilizado em Outra Estação por ' +
                      fGetHostLock(ATabela + FNumPed + 'PD' + FEmpOri)  + '!', ['&Ok']);
        Result := False;
      End;
  end;

begin
  Result := False;

  If Not fSelecionarEmpresa() Then
    Exit;

  If Not fSelecionarPedido() Then
    Exit;

  LLocked := False;
  LObjLock := TLock.Create;

  Try
    If Not fLock('FATGOR') Then
      Exit;

    If Not fLock('CADREC') Then
      Exit;

    Try
      fStartTransaction;

      If Not fReverterEmpresaCD Then
        Exit;

      If Not fReverterTransferenciaEstoque Then
        Exit;

      If Not fReprocessarItens Then
        Exit;

      Result := True;
    Finally
      If Result Then
        fCommit
      Else
        fRollback;
    End;

  Finally
    If Not LLocked Then
      LObjLock.pDestravarTodos;
  End;
end;

function TFatReverterEmpresaFaturamentoPedido.fSelecionarEmpresa: Boolean;
const
  SQL_EMPRESAS =
    'GROUP_CONCAT(EMP_CODEMP,"-",EMP_NOMFAN ORDER BY EMP_CODEMP SEPARATOR "-->")';
var
  LEmpresa: String;
  LEmpresas: TArray<String>;
  LEmpresasCD: TArray<String>;
begin
  Result := False;

  SetLength(LEmpresasCD, 0);

  LEmpresas := String(fCampoTabela(SQL_EMPRESAS,'CADEMP',[],[])).Split(['-->']);

  For LEmpresa In LEmpresas Do
  Begin
    If LeftStr(LEmpresa, 3) = FEmpOri Then
      Continue;

    If Not fCfgSis('ENT_CD', varBoolean, LeftStr(LEmpresa, 3)) Then
      Continue;

    If fCfgSis('EMP_CD', VarString, LeftStr(LEmpresa, 3)) <> LeftStr(LEmpresa, 3) Then
      Continue;

    SetLength(LEmpresasCD, Length(LEmpresasCD) + 1);
    LEmpresasCD[High(LEmpresasCD)] := LEmpresa;
  End;

  If Length(LEmpresasCD) = 0 Then
  Begin
    pMensagemOk('Não foram encontradas empresas configuradas '+
      'como C.D. para selecionar!');
    Exit;
  End;

  If Length(LEmpresasCD) = 1 Then
    FEmp_CD := LEmpresasCD[0]
  Else
    FEmp_CD := LeftStr(LEmpresasCD[fGetMenu('Emp. Faturamento', LEmpresasCD, 0) -1],3);

  Result := True;
end;

function TFatReverterEmpresaFaturamentoPedido.fSelecionarPedido: Boolean;
const
  SQL_PEDIDOS =
    ' SELECT SQL_NO_CACHE ' +
    '   CONCAT(FGO_NUMDOC,"-",FGO_ESPDOC,"-",FGO_CODEMP, " - Valor Total: ", '+
    '   REPLACE(LPAD(FGO_VLRCON, 10, " "), ".", ",")) ' +
    ' FROM FATGOR INNER JOIN EXTGOR ON FGO_SEQFGO = FATGOR.AUTOINCREM ' +
    ' WHERE FGO_ESPDOC = "PD" ' +
    '   AND FGO_CODEMP = :EMPORI ' +
    '   AND FGO_EMP_CD = :EMP_CD ' +
    '   AND FGO_ENT_CD = "S" ' +
    '   AND FGO_JAFATU = 0 ' +
    ' ORDER BY FGO_NUMDOC ';
var
  LQuery: TUniQuery;
  LPedidos: TArray<String>;
begin
  Result := False;

  LQuery := fCriaQuery;
  Try
    LQuery.SQL.Text := SQL_PEDIDOS;
    LQuery.ParamByName('EMPORI').AsString := FEmpOri;
    LQuery.ParamByName('EMP_CD').AsString := FEmp_CD;
    LQuery.Open;

    SetLength(LPedidos, LQuery.RecordCount);

    While Not LQuery.Eof Do
    Begin
      LPedidos[LQuery.RecNo-1] := LQuery.Fields[0].AsString;
      LQuery.Next;
    End;
  Finally
    FreeAndNil(LQuery);
  End;

  If Length(LPedidos) = 0 Then
  Begin
    pMensagemOk('Não foram encontradas pedidos para reverter a empresa!');
    Exit;
  End;

  If Length(LPedidos) = 1 Then
    FNumPed := LeftStr(LPedidos[0],12)
  Else
    FNumPed := LeftStr(LPedidos[fGetMenu('Pedido(s)', LPedidos, 0) -1],12);

  Result := fPergunta('Confirma reverter a empresa de faturamento do pedido ' +
    FNumPed + '-' + 'PD' + '-' + FEmpOri + ' ?');
end;

function TFatReverterEmpresaFaturamentoPedido.fReverterTransferenciaEstoque: Boolean;
  Var
    objAltPed: TAlterarPedido;
begin
  Result := False;

  If Not fCfgSis('TRARET', VarBoolean, FEmpOri) Then
    Exit(True);

  If Not fCfgSis('TRARET', VarBoolean, FEmp_CD) Then
    Exit(True);

  objAltPed := TAlterarPedido.Create(nil);

  Try
    objAltPed.strNumPed := FNumPed;
    objAltPed.strEspPed := 'PD';
    objAltPed.strEmpPed := FEmpOri;

    If Not objAltPed.fCarregarPedido Then
      Exit;

    If Not objAltPed.fCalculaTotalPedido Then
      Exit;

    If fUsaRotinaWMS Then
      objAltPed.objVenda.blnTransferenciaParaEmpresaFaturamentoPedidoWms := True;

    Result := TFatTransfEstoqueParaEmpresaFaturamentoPedido.New
      (objAltPed.objVenda, FEmp_CD, FEmpOri, False, objAltPed.objVenda.strEspDoc).fTransferirEstoqueParaEmpresaFaturamento;
  Finally
    FreeAndNil(objAltPed);
  End;
end;

class function TFatReverterEmpresaFaturamentoPedido.New(AEmpOri: String): IFatReverterEmpresaFaturamentoPedido;
begin
  Result := Self.Create(AEmpOri);
end;

{ TFatDevolucaoRegimeEspecial }

constructor TFatDevolucaoRegimeEspecial.Create(AObjVenda: TFatVenda;
  AEmpresaOrigem, AEmpresaDestino, AEmpresaEstFis, ARegEsp, AEspDocOri: String);
begin
  FObjVenda := AObjVenda;
  FEmpresaOrigem := AEmpresaOrigem;
  FEmpresaDestino := AEmpresaDestino;
  FEmpresaEstFis := AEmpresaEstFis;
  FstrRegEsp := ARegEsp;
  FEspDocOri := AEspDocOri;
  FObjFuncoes := TFatAltEmpFatPedidoFuncoes.New(True, fRegimeEspecialAndNotaFiscal);

  FstrCodFpgVenda := fCampoTabela('GER_CODFPG', 'MOVGER',
    ['GER_NUMDOC', 'GER_ESPDOC', 'GER_CODEMP'],
    [FObjVenda.arrMatItens[0].strDocDev,
    FObjVenda.arrMatItens[0].strEspDev,
    FObjVenda.arrMatItens[0].strEmpDev]);

end;

function TFatDevolucaoRegimeEspecial.fDevolucaoRegimeEspecial: Boolean;
var
  LEmpresaBackup: String;
  LInTransaction: Boolean;
begin
  Result := False;
  LInTransaction := fInTransaction;
  LEmpresaBackup := VS_strCodEmp;
  Try
    If Not LInTransaction Then
      fStartTransaction();

    if FstrRegEsp = 'S' then
    begin
      Result := fGravaEntGer(FEmpresaOrigem, FEmpresaDestino) And
                fGravaEntDet(FEmpresaDestino) And
                fRealizaTransferencia(FEmpresaOrigem) And
                fRealizaEntrada(FEmpresaDestino);

      If Result And (FEmpresaDestino <> FEmpresaEstFis) Then
        Result := fGravaEntGer(FEmpresaDestino, FEmpresaEstFis) And
                  fGravaEntDet(FEmpresaEstFis) And
                  fRealizaTransferencia(FEmpresaDestino) And
                  fRealizaEntrada(FEmpresaEstFis);
    end
    else
    begin
      Result := fGravaEntGer(FEmpresaOrigem, FEmpresaEstFis) And
                fGravaEntDet(FEmpresaEstFis) And
                fRealizaTransferencia(FEmpresaOrigem) And
                fRealizaEntrada(FEmpresaEstFis);
    end;

  Finally
    pSetaEmpresaLogada(LEmpresaBackup);

    If Not LInTransaction Then
      If Result Then
        fCommit()
      Else
        fRollBack();
  End;
end;

function TFatDevolucaoRegimeEspecial.fGravaEntDet(AEmpresaDestino: String): Boolean;
var
  strCodFpgBkp: String;
begin
  strCodFpgBkp := FObjVenda.strCodFpg;
  FObjVenda.strCodFpg := FstrCodFpgVenda;
  try
    Result := FObjFuncoes.fGravaEntDet(
      FObjVenda,
      AEmpresaDestino,
      FAutIncEnt,
      FObjVenda.arrMatItens);
  finally
    FObjVenda.strCodFpg := strCodFpgBkp;
  end;
end;

function TFatDevolucaoRegimeEspecial.fGravaEntGer(AEmpresaOrigem, AEmpresaDestino: String): Boolean;
var
  strCodFpgBkp: String;
begin
  strCodFpgBkp := FObjVenda.strCodFpg;
  FObjVenda.strCodFpg := FstrCodFpgVenda;
  try
    Result := FObjFuncoes.fGravaEntGer(
      FObjVenda,
      AEmpresaOrigem,
      AEmpresaDestino,
      FAutIncEnt);
  finally
    FObjVenda.strCodFpg := strCodFpgBkp;
  end;
end;

function TFatDevolucaoRegimeEspecial.fRealizaEntrada(AEmpresaDestino: String): Boolean;
begin
  Result := FObjFuncoes.fRealizaEntrada(
    FObjVenda,
    AEmpresaDestino,
    FAutIncEnt,
    FEspDocOri);
end;

function TFatDevolucaoRegimeEspecial.fRealizaTransferencia(AEmpresaOrigem: String): Boolean;
begin
  Result := FObjFuncoes.fRealizaTransferencia(
    FObjVenda,
    AEmpresaOrigem,
    FAutIncEnt,
    fRegimeEspecialAndNotaFiscal)
end;

function TFatDevolucaoRegimeEspecial.fRegimeEspecialAndNotaFiscal: Boolean;
begin
  Result := True;

  If (FObjVenda.strTipPed = 'A') Then
    Exit;

  If (Self.FEspDocOri = 'NF') Then
    Exit;

  Result := False;
end;

class function TFatDevolucaoRegimeEspecial.New(AObjVenda: TFatVenda;
  AEmpresaOrigem, AEmpresaDestino, AEmpresaEstFis, ARegEsp, AEspDocOri: String): IFatDevolucaoRegimeEspecial;
begin
  Result := Self.Create(AObjVenda, AEmpresaOrigem, AEmpresaDestino, AEmpresaEstFis, ARegEsp, AEspDocOri);
end;

{ TFatAltEmpFatPedidoFuncoes }

function TFatAltEmpFatPedidoFuncoes.fGravaEntGer(AObjVenda: TFatVenda;
  AEmpresaOrigem, AEmpresaDestino: String; var strAutIncEnt: String): Boolean;
var
  strAutIncEntrada: String;
begin
  With AObjVenda Do
    Result := untEntGer.fGravaEntGer(strAutIncEntrada,
                                     AEmpresaDestino,
                                     strNumDoc,
                                     strEspDoc,
                                     strCodVen,
                                     strCodTra,
                                     strCodCli,
                                     strSerFsc,
                                     AObjVenda.VS_Date,
                                     fTime(),
                                     DateToStr(AObjVenda.VS_Date),
                                     strConPag,
                                     strCliEst,
                                     strCliNom,
                                     strCliEnd,
                                     strCliBai,
                                     strCliCep,
                                     strCodCid,
                                     strCliEst,
                                     strCliTel,
                                     intCgcCpf,
                                     strCliCgc,
                                     strCliIes,
                                     fltDesEsp,
                                     fltTotPro,
                                     fltTotCus,
                                     fltTotMed,
                                     strTipFre,
                                     fltValFre,
                                     fltPesBru,
                                     fltPesLiq,
                                     intQtdTra,
                                     strEspTra,
                                     strMarTra,
                                     strMen001,
                                     strMen002,
                                     arrDuplicata[00].curValor,
                                     arrDuplicata[01].curValor,
                                     arrDuplicata[02].curValor,
                                     arrDuplicata[03].curValor,
                                     arrDuplicata[04].curValor,
                                     arrDuplicata[05].curValor,
                                     arrDuplicata[06].curValor,
                                     arrDuplicata[07].curValor,
                                     arrDuplicata[08].curValor,
                                     arrDuplicata[09].curValor,
                                     arrDuplicata[10].curValor,
                                     arrDuplicata[11].curValor,
                                     strCodDig,
                                     fltPorDes,
                                     strCli_Rg,
                                     strCodCnd,
                                     strCodFpg,
                                     strCodS01,
                                     strCodS02,
                                     strCodS03,
                                     strCodS04,
                                     strCodS05,
                                     strCodS06,
                                     strDesS01,
                                     strDesS02,
                                     strDesS03,
                                     strDesS04,
                                     strDesS05,
                                     strDesS06,
                                     fltValS01,
                                     fltValS02,
                                     fltValS03,
                                     fltValS04,
                                     fltValS05,
                                     fltValS06,
                                     intPraEnt,
                                     fltTotSer,
                                     fltPerIss,
                                     fltValIss,
                                     strDesCla,
                                     'V',
                                     Length(arrMatItens),
                                     AEmpresaOrigem,
                                     strMen003,
                                     strMen004,
                                     strMen005,
                                     strEmpresaAbastecimentoOutrasSaidas);

  strAutIncEnt := strAutIncEntrada;
end;

constructor TFatAltEmpFatPedidoFuncoes.Create(blnDevRegimeEspecial: Boolean; blnEntradaComoNotaRegimeEspecial: Boolean);
begin
  Self.FblnDevRegimeEspecial := blnDevRegimeEspecial;
  Self.FEntradaComoNotaRegimeEspecial := blnEntradaComoNotaRegimeEspecial;
end;

function TFatAltEmpFatPedidoFuncoes.fDeveGerarNotaFiscal(AObjVenda: TFatVenda; const AEspDocOri : String): Boolean;
  const
    SEGUIR_FATURAMENTO : String = '1';
    TRANSFERENCIA_ESTOQUE : String = '2';
begin
  Result := True;
  If (AObjVenda.strOpcDoc = 'DV') And
     (AObjVenda.blnEhDevolucaoAbastecimentoDeposito) And
     (AObjVenda.blnDevolucaoEmpresaAbastecimento) Then
  Begin
    If (fCfgSis('ABADEV', varString) = SEGUIR_FATURAMENTO) Then
    Begin
      If (fEhTipoDeDocumentoFiscal(AEspDocOri)) Then
        Exit(True)
      Else
        Exit(False);
    End;
    If (fCfgSis('ABADEV', varString) = TRANSFERENCIA_ESTOQUE) Then
      Exit(False);
  End;
  If (AObjVenda.blnAbastecimentoDeposito) Then
    Exit;
  If (AObjVenda.blnRegimeEspecialPorEmpresaComFaturamentoDuplo) Then
    Exit;
  If (FEntradaComoNotaRegimeEspecial) Then
    Exit;
  Result := False;
end;

function TFatAltEmpFatPedidoFuncoes.fEhTipoDeDocumentoFiscal(
  const strEspDoc: String): Boolean;
begin
  Result := True;

  If (strEspDoc = 'NF') Then
    Exit;

  If (strEspDoc = 'IF') Then
    Exit;

  Result := False;
end;

function TFatAltEmpFatPedidoFuncoes.fGravaEntDet(AObjVenda: TFatVenda;
  AEmpresaDestino, AAutIncEnt: String; const Itens: TMatrizFechamento): Boolean;
var
  item: TDadosFechamento;
begin
  Result := True;
  With AObjVenda Do
    For item In Itens Do
      Result := Result And
        untEntGer.fGravaEntDet(AAutIncEnt,
                               AEmpresaDestino,
                               strCodVen,
                               item.strCodIte,
                               strCodDiv,
                               item.strCodMar,
                               strCodCli,
                               strNumDoc,
                               strEspDoc,
                               strSerFsc,
                               AObjVenda.VS_Date,
                               fTime(),
                               AObjVenda.VS_Date,
                               strConPag,
                               strCliEst,
                               item.strDesIte,
                               item.strDesOri,
                               item.strRefere,
                               item.strCodUni,
                               item.strCodFor,
                               item.fltQtdIte,
                               item.fltUniTar,
                               item.fltUniOri,
                               item.fltUniVis,
                               item.fltTotIte,
                               item.fltTotCus,
                               item.fltTotMed,
                               item.fltDesCon,
                               item.fltValFre,
                               item.fltDesEsp,
                               strCodRep,
                               0.0,
                               0.0,
                               item.strCodFis,
                               item.fltPesoIt * item.fltQtdIte,
                               0.0,
                               item.strIdePro,
                               item.strIncPis,
                               item.strIteTin,
                               item.strIteCha,
                               item.strDesCor,
                               item.strTipEmb,
                               item.fltQtdEmb,
                               item.fltQtdEmb * item.fltUniEmb,
                               item.strTipPre,
                               item.fltPrvTin,
                               item.fltPrcTin,
                               item.fltFatTin,
                               item.strProEmb,
                               strCodDig,
                               strCodCnd,
                               strCodFpg,
                               item.strIteEmb,
                               item.intLazQua,
                               item.strPromoc,
                               strAutIncDet,
                               strCodVe2,
                               0.0,
                               0.0,
                               'V',
                               item.strNumLot,
                               item.fltTaxJur,
                               item.strLotAba,
                               strEmpresaAbastecimentoOutrasSaidas,
                               item.blnProAca,
                               item.strCodAca,
                               item.strEmpAca);
end;

function TFatAltEmpFatPedidoFuncoes.fRealizaTransferencia(AObjVenda: TFatVenda; AEmpresaOrigem, AAutIncEnt: String; AblnNotaFiscal: Boolean): Boolean;
Var
  LObjConEnt: TControleEntrega;
begin
  pSetaEmpresaLogada(AEmpresaOrigem);

  LObjConEnt := TControleEntrega.Create(nil);
  Try
    LObjConEnt.blnAbastecimentoDeposito := AObjVenda.blnAbastecimentoDeposito;
    LObjConEnt.blnEhDevolucaoAbastecimentoDeposito := AObjVenda.blnEhDevolucaoAbastecimentoDeposito;
    LObjConEnt.blnRegimeEspecialPorProdutoComFaturamentoDuplo := Not fEmptyStr(AObjVenda.strEmpOriRegEsp);
    LObjConEnt.blnRegimeEspecialPorEmpresaComFaturamentoDuplo := AObjVenda.blnRegimeEspecialPorEmpresaComFaturamentoDuplo;
    LObjConEnt.strEmpresaAbastecimentoOutrasSaidas := AObjVenda.strEmpresaAbastecimentoOutrasSaidas;
    LObjConEnt.blnDevRegimeEspecial := Self.FblnDevRegimeEspecial;
    LObjConEnt.fatVendaNF := AObjVenda;

    if AblnNotaFiscal then
      Result := LObjConEnt.fProcessaEntGerMatrizNF(AAutIncEnt, LObjConEnt.blnAbastecimentoDeposito)
    else
      Result := LObjConEnt.fProcessaEntGerMatriz(AAutIncEnt, '', LObjConEnt.blnAbastecimentoDeposito);
  Finally
    FreeAndNil(LObjConEnt);
  End;
end;

class function TFatAltEmpFatPedidoFuncoes.New(blnDevRegimeEspecial: Boolean; blnEntradaComoNotaRegimeEspecial: Boolean): IFatAltEmpFatPedidoFuncoes;
begin
  Result := Self.Create(blnDevRegimeEspecial, blnEntradaComoNotaRegimeEspecial);
end;

function TFatAltEmpFatPedidoFuncoes.fRealizaEntrada(AObjVenda: TFatVenda; AEmpresaDestino, AAutIncEnt: String; AEspDocOri: String = ''): Boolean;
  Var
    LObjConEnt : TControleEntrega;
    LDeveGerarNotaFiscal : Boolean;
begin
  LDeveGerarNotaFiscal := fDeveGerarNotaFiscal(AObjVenda, AEspDocOri);

  pSetaEmpresaLogada(AEmpresaDestino);

  LObjConEnt := TControleEntrega.Create(nil);
  Try
    LObjConEnt.blnAbastecimentoDeposito := AObjVenda.blnAbastecimentoDeposito;
    LObjConEnt.blnEhDevolucaoAbastecimentoDeposito := AObjVenda.blnEhDevolucaoAbastecimentoDeposito;
    LObjConEnt.blnRegimeEspecialPorProdutoComFaturamentoDuplo := Not fEmptyStr(AObjVenda.strEmpOriRegEsp);
    LObjConEnt.blnRegimeEspecialPorEmpresaComFaturamentoDuplo := AObjVenda.blnRegimeEspecialPorEmpresaComFaturamentoDuplo;
    LObjConEnt.strEmpresaAbastecimentoOutrasSaidas := AObjVenda.strEmpresaAbastecimentoOutrasSaidas;
    LObjConEnt.blnDevRegimeEspecial := Self.FblnDevRegimeEspecial;
    LObjConEnt.fatVendaNF := AObjVenda;

    If LDeveGerarNotaFiscal Then
      Result := LObjConEnt.fGeraEntradaMercadoriasNF(AAutIncEnt, LObjConEnt.blnAbastecimentoDeposito, AEspDocOri)
    else
      Result := LObjConEnt.fGeraEntradaMercadorias(AAutIncEnt, '', LObjConEnt.blnAbastecimentoDeposito);
  Finally
    FreeAndNil(LObjConEnt);
  End;

end;

end.
