unit untTransferenciaMovimentacaoProgramada;

interface

uses
  StrUtils, SysUtils, Classes, Forms, DB, untTypesSistema, Variants, untMovimentacaoProgramadaVencimento,
  Uni, Controls, EditFocus, UniClientDataSet, Math, ComCtrls, untCadLote, untMovimentacaoProgramada,
  untZClient, cxProgressBar;

Type
  TopcEdits = (opcLimpar, opcEditar, opcGravar);

  TRecFiltrosAbastecimentoPreventivoPicking = Record
    blnConsiderarMovimentacoesEmAndamento,
    blnConsiderarEmbalagemFechada,
    blnAbastecerItensPctg: Boolean;
    strNivGir,
    strCodEmp,
    strCodOpe: String;
    fltPctCapMax: Double;
    strOrdemLote: String;
  End;


  TLoteItemSelecionados = record
    strCodIte_chave: String;
    Index: integer;
    strLotes: String;
  End;


  TArrLoteSelecionadoItem = array of TLoteItemSelecionados;

  TLotesSelecionadosMovPro = class
  private
    ArrLoteSelecionadoItem: TArrLoteSelecionadoItem;
    function GetItem(Index: string): TLoteItemSelecionados;
    //function fGetIndex(ACodIte: String): integer;
  public
    strCodIteAtual: String;
    procedure pAdd(LoteItemSelecionados: TLoteItemSelecionados);
    procedure pAtualizaLote(LoteItemSelecionados: TLoteItemSelecionados);
    procedure Reincia;
    property ItemLotes[index: string]:TLoteItemSelecionados  read GetItem;

  End;

  TTransferenciaLote = Class(TComponent)
  Private
    FobjMovLot: TMovimentacaoProgramada;
    blnCadLoc    : Boolean;
    qryInsert: TUniQuery;
    FTransf,
    FInsert,
    FCopDad: TUniClientDataSet;
    FdtsTra: TDataSource;
    FCdsAbastPrev,
    FCdsAbastPrevDetail: TZClient;
    FCodOpe: String;
    FProgre: TProgressBar;
    stlListaTrava: TStringList;
    RemoveTodasAsTravas: Boolean;
    FQtdCur: Double; // QUANTIDA ORIGINAL DO REGISTRO CORRENTE
    Procedure pCancela(csdClient: TUniClientDataSet);
    Procedure pCopiaRegistro;
    Procedure pInsertTransf;
    Procedure pFormataCampos(cdsClient: TUniClientDataSet);
    Procedure pConsultarLoteVencimento(const intDia: Integer; objDataSet: TDataSet);
    function fIsPicking(strCodLoc: String): Boolean;
    //Abastecimento preventivo de picking
    Function fGetSQLAbastecimentoPreventivoMaster(ARecFiltros: TRecFiltrosAbastecimentoPreventivoPicking): String;
    Function fGetSQLBaseComLote(ARecFiltros: TRecFiltrosAbastecimentoPreventivoPicking; blnCapa: Boolean = False): String;
    function fGetSQLBase(ARecFiltros: TRecFiltrosAbastecimentoPreventivoPicking): String;

    Function fGetSQLAbastecimentoPreventivoDetail(ARecFiltros: TRecFiltrosAbastecimentoPreventivoPicking): String;
    procedure pCriaOsLocks;

  Public
    function ObjMovLot: TMovimentacaoProgramada;
    Procedure pEditaItem;
    Procedure pSalvaItem;
    Procedure pCancelaEdicaoItem(opcEdits: TopcEdits = opcLimpar);
    procedure pDeleteRegistroCopia(strCodIte,  strLotOri, strLocDes: string);
    Function fValidarLocalizacaoDestino(const strCodIte, strLocDes: String): Boolean;
    Function fCarregarLote(strLocFis: String; cdsExterno: TUniClientDataSet = nil): Boolean;
    procedure pDecideCdsClient(cdsExterno: TUniClientDataSet; var cdsClient: TUniClientDataSet);

    Procedure pCarregarLoteVencimento;
    Function fGeraTransferencia(blnManual: Boolean = False;  blnConfirmacaoPainel: Boolean = False): Boolean;
    Function fGeraTransferenciaAbastecimentoPicking(blnManual: Boolean = False;  blnConfirmacaoPainel: Boolean = False): Boolean;
    function fCriaLocks(pgbProgresso: TcxProgressBar): Boolean;
    function fRemovLocks(pgbProgresso: TcxProgressBar): Boolean;
    procedure pRemoveLocks;

    function fLockUnLock(ACodIte, ANumLot, ACodEmp: String; blnTrava: Boolean; var strTrava: String): Boolean;
    procedure pGerenciaListaTrava(ATrava: String; AblnTrava: Boolean; var blnChamaTrava: Boolean);

    Constructor Create(Owner: TComponent;
                       cdsTransf: TUniClientDataSet;
                       dtsTransf: TDataSource;
                       prbProgre: TProgressBar); Reintroduce;
    destructor Destroy; override;
    //Abastecimento preventivo de picking
    Function fPesquisar(ARecFiltros: TRecFiltrosAbastecimentoPreventivoPicking): Boolean;
    procedure OnCdsAbastPrevDetailBeforePost(DataSet: TDataSet);
    Function fGetcdsAbastPrevMaster: TUniClientDataSet;
    Function fGetcdsAbastPrevDetail: TUniClientDataSet;
    Function fGeraTransferenciaAbastecimentoPreventivoPicking(strCodOpe: String = ''): Boolean;
    Function fGetOrdenacaoLotes(AItems: TStrings): String;


    Property strCodOpe: String Read FCodOpe Write FCodOpe;
  end;

implementation

Uses
  untFuncoesSimples, untReimpressao, untPcmger, untConstantes,
  untTFatReservaSaldo, untGravando;

constructor TTransferenciaLote.Create(Owner: TComponent;
          cdsTransf: TUniClientDataSet; dtsTransf: TDataSource;
          prbProgre: TProgressBar);
begin
  inherited Create(Owner);
  FobjMovLot := TMovimentacaoProgramadaManual.Create('');
  qryInsert := fCriaQuery(Owner);
  RemoveTodasAsTravas := False;

  FTransf           := cdsTransf;
  FdtsTra           := dtsTransf;
  FInsert           := TUniClientDataSet.Create(Self);
  FInsert.Data      := FTransf.Data;

  FCdsAbastPrev := TZClient.Create(Owner);
  FCdsAbastPrevDetail := TZClient.Create(Owner);

  If Assigned(dtsTransf) Then
  Begin
    dtsTransf.DataSet := FInsert;
    pFormataCampos(FTransf);
    pFormataCampos(FInsert);
  End;

  FProgre := prbProgre;
  FQtdCur := 0;

  blnCadLoc := fCfgSis('CADLOC', varBoolean);

  FCopDad := TUniClientDataSet.Create(Self);
  FCopDad.Data := FTransf.Data;
end;

Procedure TTransferenciaLote.pCopiaRegistro;
Var
  intContador: Integer;
Begin
  If FInsert.IsEmpty Or
     fEmptyStr(FInsert.FieldByName('CODITE').AsString)
  Then
    Exit;

  FTransf.Append;

  For intContador := 0 To FInsert.Fields.Count - 1 Do
    FTransf.Fields[intContador].Value := FInsert.Fields[intContador].Value;

  FTransf.Post;
  FCopDad.Data := FTransf.Data;

  FInsert.EmptyDataSet;
End;

procedure TTransferenciaLote.pCriaOsLocks;
var frmGravando: TfrmGravando;
Begin
  pCriarFormularios(TfrmGravando, frmGravando);
  Try
    frmGravando.lblGravando.Caption := 'Aguarde, Criando as travas de proteção dos lotes...';
    frmGravando.fExecutarAcao := fCriaLocks;
    frmGravando.ShowModal;
  Finally
    FreeAndNil(frmGravando);
  End;

end;

function TTransferenciaLote.fCriaLocks(pgbProgresso: TcxProgressBar): Boolean;
var strTrava: String;
begin
  If Not Assigned(stlListaTrava) Then
    stlListaTrava := TStringList.Create;

  Result := True;

  If Not FCdsAbastPrevDetail.Active Then
    Exit;

  FCdsAbastPrevDetail.First;
  pgbProgresso.Properties.Max := FCdsAbastPrevDetail.RecordCount -1;
  while not FCdsAbastPrevDetail.Eof Do
  Begin
    If FCdsAbastPrevDetail.FieldByName('LOT_SELECE_DETAIL').AsString = 'S' Then
    Begin
      If (Not fLockUnLock(FCdsAbastPrevDetail.FieldByName('ITE_CODITE').AsString,
                          FCdsAbastPrevDetail.FieldByName('LOT_NUMLOT').AsString,
                          FCdsAbastPrevDetail.FieldByName('LCI_CODEMP').AsString,
                          True,
                          strTrava)) Then
      Begin
        FCdsAbastPrevDetail.Edit;
        FCdsAbastPrevDetail.FieldByName('LOT_SELECE_DETAIL').AsString := 'N';
        FCdsAbastPrevDetail.Post;
      End;
    End;

    FCdsAbastPrevDetail.Next;
    pgbProgresso.Position := FCdsAbastPrevDetail.RecNo;
    Application.ProcessMessages;
  End;
end;

function TTransferenciaLote.fRemovLocks(pgbProgresso: TcxProgressBar): Boolean;
var strTrava: String;
begin
  Result := True;

  If Not FCdsAbastPrevDetail.Active Then
    Exit;

  FCdsAbastPrevDetail.Filtered := False;
  FCdsAbastPrevDetail.First;
  pgbProgresso.Properties.Max := FCdsAbastPrevDetail.RecordCount -1;
  RemoveTodasAsTravas := True;
  Try
    while not FCdsAbastPrevDetail.Eof Do
    Begin
      fLockUnLock(FCdsAbastPrevDetail.FieldByName('ITE_CODITE').AsString,
                          FCdsAbastPrevDetail.FieldByName('LOT_NUMLOT').AsString,
                          FCdsAbastPrevDetail.FieldByName('LCI_CODEMP').AsString,
                          False,
                          strTrava);
      FCdsAbastPrevDetail.Next;
      pgbProgresso.Position := FCdsAbastPrevDetail.RecNo;
      Application.ProcessMessages;
    End;
  Finally
    RemoveTodasAsTravas := false;
  End;
end;



function TTransferenciaLote.fLockUnLock(ACodIte, ANumLot,
  ACodEmp: String; blnTrava: Boolean; var strTrava: String): Boolean;
var blnChamaTrava: Boolean;
begin
  Result := True;
  strTrava := 'transferencia_' + ACodIte + '_' +
                                 ANumLot + '_' +
                                 ACodEmp;
 pGerenciaListaTrava(strTrava, blnTrava, blnChamaTrava);
 If blnChamaTrava Then
   Result := fLock_Unlock(strTrava, blnTrava, False)

end;

procedure TTransferenciaLote.pGerenciaListaTrava(ATrava: String; AblnTrava: Boolean; var blnChamaTrava: Boolean);
var index : integer;
Begin
  blnChamaTrava := false;
  index := stlListaTrava.IndexOf(ATrava);
  If AblnTrava Then
  Begin
    If index = -1 Then
    Begin
      blnChamaTrava := True;
      stlListaTrava.Add(ATrava);
    End;
  End
  Else If RemoveTodasAsTravas Then
    blnChamaTrava := True;

end;

procedure TTransferenciaLote.pDeleteRegistroCopia(strCodIte,  strLotOri, strLocDes: string);
begin
  If FCopDad.Locate('CODITE;LOTORI;LOCDES', VarArrayOf([strCodIte, strLotOri, strLocDes]), []) Then
    FCopDad.Delete;
end;

Procedure TTransferenciaLote.pInsertTransf;
Begin
  pCancela(FTransf);
  pCancela(FInsert);

  FInsert.Insert;
  FInsert.FieldByName('QTDITE').AsFloat  := 0;

  FdtsTra.DataSet := FInsert;
End;

procedure TTransferenciaLote.pRemoveLocks;
var frmGravando: TfrmGravando;
Begin
  pCriarFormularios(TfrmGravando, frmGravando);
  Try
    frmGravando.lblGravando.Caption := 'Aguarde, Removendo as travas de proteção dos lotes...';
    frmGravando.fExecutarAcao := fRemovLocks;
    frmGravando.ShowModal;
  Finally
    FreeAndNil(frmGravando);
  End;
  If Assigned(stlListaTrava) Then
    FreeAndNil(stlListaTrava);

end;

Procedure TTransferenciaLote.pSalvaItem;
Begin
  If FTransf.State = dsEdit Then
  Begin
    FTransf.Post;
    FCopDad.Data := FTransf.Data;
  End Else
  Begin
    pCopiaRegistro;
  End;

  pInsertTransf;
End;

Procedure TTransferenciaLote.pCancela(csdClient: TUniClientDataSet);
Begin
  If csdClient.State In [dsEdit, dsInsert] Then
    csdClient.Cancel;
End;

Procedure TTransferenciaLote.pCancelaEdicaoItem(opcEdits: TopcEdits = opcLimpar);
Begin
  pCancela(FTransf);
  pCancela(FInsert);

  Case opcEdits Of
    opcEditar: FdtsTra.DataSet := FTransf;
    opcLimpar: pInsertTransf;
  End;
End;

procedure TTransferenciaLote.pCarregarLoteVencimento;
Var
  ObjData: TUniClientDataSet;
  objForm: TfrmMovimentacaoProgramadaVencimento;
begin
  objForm := TfrmMovimentacaoProgramadaVencimento.Create(nil);
    Try
    objForm.
      pConsultarLoteVencimento(pConsultarLoteVencimento).
      fValidarLocalizacaoDestino(fValidarLocalizacaoDestino).
      fTemMovimentoProgramadoEmAberto(ObjMovLot.fTemMovimentoProgramadoEmAberto);

    If objForm.ShowModal <> mrCancel Then
    Begin
      objData := objForm.cdsItens;
      objData.DisableControls;
      objData.First;
      while Not ObjData.Eof do
      Begin
        if (Not fEmptyStr(objData.FieldByName('LOCDES').AsString)) And (objData.FieldByName('QTDITE').AsCurrency > 0) then
        Begin
          Finsert.Append;
          Finsert.FieldByName('AUTINC').Value := objData.FieldByName('AUTINC').Value;
          Finsert.FieldByName('CODITE').Value := objData.FieldByName('CODITE').Value;
          Finsert.FieldByName('DESITE').Value := objData.FieldByName('DESITE').Value;
          Finsert.FieldByName('DESMAR').Value := objData.FieldByName('DESMAR').Value;
          Finsert.FieldByName('SIGUNI').Value := objData.FieldByName('SIGUNI').Value;
          Finsert.FieldByName('LOTORI').Value := objData.FieldByName('NUMLOT').Value;
          Finsert.FieldByName('LOCORI').Value := objData.FieldByName('LOCFIS').Value;
          Finsert.FieldByName('LOCDES').Value := objData.FieldByName('LOCDES').Value;
          Finsert.FieldByName('QTDITE').Value := objData.FieldByName('QTDITE').Value;
          pSalvaItem;
        End;
        ObjData.Next;
      End;
    End;
  Finally
    FreeAndNil(objForm);
  End;
end;

procedure TTransferenciaLote.pConsultarLoteVencimento(const intDia: Integer; objDataSet: TDataSet);
Var
  objData: TUniQuery;
Begin
  objData := fCriaQuery(Self);
  Try
    objData.SQL.Add(' SELECT                                               ');
    objData.SQL.Add('  L.AUTOINCREM,                                       ');
    objData.SQL.Add('  L.LOT_CODITE CODITE,                                ');
    objData.SQL.Add('  I.ITE_DESITE DESITE,                                ');
    objData.SQL.Add('  MAR_DESMAR DESMAR,                                  ');
    objData.SQL.Add('  UNI_SIGUNI SIGUNI,                                  ');
    objData.SQL.Add('  L.LOT_NUMLOT,                                       ');
    objData.SQL.Add('  L.LOT_LOCFIS LOCFIS,                                ');
    objData.SQL.Add('  L.LOT_DTAVAL DTAVAL,                                ');
    objData.SQL.Add('  DATEDIFF(L.LOT_DTAVAL, CURRENT_DATE) DIAVAL,        ');
    objData.SQL.Add('  L.LOT_SALDOS + L.LOT_SAL_ML SALDOS,                 ');
    objData.SQL.Add('  NULL LOCDES,                                        ');
    objData.SQL.Add('  0 QTDITE,                                           ');
    objData.SQL.Add('  CADLOC.LOC_CRITIC CRITIC                            ');
    objData.SQL.Add(' FROM CADLOT L                                        ');
    objData.SQL.Add(' INNER JOIN CADITE I ON I.ITE_CODITE = LOT_CODITE     ');
    objData.SQL.Add(' INNER JOIN ITEGER G ON G.ITE_CODITE= LOT_CODITE      ');
    objData.SQL.Add('                    AND G.ITE_CODEMP = LOT_CODEMP     ');
    objData.SQL.Add(' LEFT  JOIN CADMAR   ON   MAR_CODMAR = ITE_CODMAR     ');
    objData.SQL.Add(' LEFT  JOIN CADUNI   ON   UNI_CODUNI = ITE_CODUNI     ');
    objData.SQL.Add(' LEFT  JOIN CADLOC   ON      LOC_CODLOC = LOT_LOCFIS  ');
    objData.SQL.Add('                    AND   LOT_CODEMP = LOC_CODEMP     ');
    objData.SQL.Add(' WHERE LOT_CODEMP = :CODEMP                           ');
    objData.SQL.Add('   AND LOT_SALDOS > 0                                 ');
    objData.SQL.Add('   AND CURRENT_DATE <= L.LOT_DTAVAL                   ');
    objData.SQL.Add('   AND DATEDIFF(L.LOT_DTAVAL, CURRENT_DATE) <= :DIAVAL');
    objData.SQL.Add('   AND LOT_NUMLOT <> "A DEFINIR"                      ');
    objData.SQL.Add('   AND LOT_NUMLOT <> "A REGULARIZAR"                  ');
    objData.SQL.Add('   AND LOT_BROKER = ''N''                             ');
    objData.SQL.Add('   AND IFNULL(LOC_CRITIC,"N") = "N"                   ');
    objData.SQL.Add('   AND IFNULL(LOC_PICKIN,"N") = "S"                   ');
    objData.SQL.Add('   AND ((LOT_SALDOS > 0) OR (IFNULL(LOC_PICKIN,"N") = "S"))');
    objData.SQL.Add(' ORDER BY CODITE, DTAVAL                              ');

    objData.ParamByName('CODEMP').AsString := VS_strCodEmp;
    objData.ParamByName('DIAVAL').AsInteger := intDia;
    objData.Open;
    objData.First;
    while Not objData.Eof do
    begin
      pCopiaRegistroDataSet(objData,objDataSet);

      If (objData.FieldByName('CRITIC').AsString <> 'S') Then
      Begin
        objDataSet.Edit;
        objDataSet.FieldByName('SALDOS').AsFloat := objDataSet.FieldByName('SALDOS').AsFloat +
                                                   TSaldoReservado.New(
                                                     TReservaParametros.New()
                                                       .EmpresaItem(VS_strCodEmp)
                                                       .CodigoItem(objData.FieldByName('CODITE').AsString)
                                                       .CodEmpresa(VS_strCodEmp)
                                                       .NumeroLote(objData.FieldByName('LOT_NUMLOT').AsString)
                                                     ).fGetQuantidade();
        objDataSet.Post;
      End;
      objData.Next;
    end;
  Finally
    FreeAndNil(objData)
  End;
end;

Procedure TTransferenciaLote.pEditaItem;
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

destructor TTransferenciaLote.Destroy;
begin
  pRemoveLocks;
  FreeAndNil(FobjMovLot);
  inherited;
end;

procedure TTransferenciaLote.pDecideCdsClient(cdsExterno: TUniClientDataSet; var cdsClient: TUniClientDataSet);
begin
  If Assigned(cdsExterno) Then
  Begin
    cdsClient := cdsExterno;
    If cdsClient.State <> dsInsert Then
      cdsClient.Insert;
  End
  Else If FdtsTra.DataSet = FTransf Then
    cdsClient := FTransf
  Else
    cdsClient := FInsert;
end;

Function TTransferenciaLote.fCarregarLote(strLocFis: String;cdsExterno: TUniClientDataSet = nil): Boolean;
Var
  cdsClient: TUniClientDataSet;
  qryDadIte: TUniQuery;
Begin
  pDecideCdsClient(cdsExterno, cdsClient);


  qryDadIte := fCriaQuery(Self);
  Try
    qryDadIte.SQL.Clear;
    qryDadIte.SQL.Add(' SELECT L.*,                                      ');
    qryDadIte.SQL.Add('        G.ITE_PRECUS,                             ');
    qryDadIte.SQL.Add('        I.ITE_CODMAR,                             ');
    qryDadIte.SQL.Add('        I.ITE_CODITE,                             ');
    qryDadIte.SQL.Add('        I.ITE_DESITE,                             ');
    qryDadIte.SQL.Add('          LOC_PICKIN,                             ');
    qryDadIte.SQL.Add('          MAR_DESMAR,                             ');
    qryDadIte.SQL.Add('          IFNULL(LOC_CRITIC,"N") AS LOC_CRITIC,   ');
    qryDadIte.SQL.Add('          UNI_SIGUNI                              ');
    qryDadIte.SQL.Add(' FROM CADLOT L                                    ');
    qryDadIte.SQL.Add(' INNER JOIN CADITE I ON I.ITE_CODITE = LOT_CODITE ');
    qryDadIte.SQL.Add(' INNER JOIN ITEGER G ON G.ITE_CODITE = LOT_CODITE ');
    qryDadIte.SQL.Add('                    AND G.ITE_CODEMP = LOT_CODEMP ');
    qryDadIte.SQL.Add(' LEFT  JOIN CADMAR   ON   MAR_CODMAR = ITE_CODMAR ');
    qryDadIte.SQL.Add(' LEFT  JOIN CADUNI   ON   UNI_CODUNI = ITE_CODUNI ');
    qryDadIte.SQL.Add(' LEFT  JOIN CADLOC   ON   LOC_CODLOC = LOT_LOCFIS ');
    qryDadIte.SQL.Add('                    AND   LOT_CODEMP = LOC_CODEMP ');
    qryDadIte.SQL.Add(' WHERE LOT_CODEMP = :CODEMP                       ');
    qryDadIte.SQL.Add('   AND LOT_CODITE = :CODITE                       ');
    qryDadIte.SQL.Add('   AND LOT_NUMLOT = :NUMLOT                       ');
    qryDadIte.ParamByName('CODITE').AsString := cdsClient.FieldByName('CODITE').AsString;
    qryDadIte.ParamByName('NUMLOT').AsString := strLocFis;
    qryDadIte.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryDadIte.Open;
    Result := Not qryDadIte.IsEmpty;

    If blnCadLoc And fEmptyStr(qryDadIte.FieldByName('LOT_LOCFIS').AsString) And
                              (qryDadIte.FieldByName('LOT_NUMLOT').AsString <> 'A DEFINIR') Then
    Begin
      Result := False;
      pMensagemOk('Lote sem localização Física definida!')
    End Else If Not Result Then
    Begin
      Result := False;
      pMensagemOk('Lote não encontrado!')
    End;

    If (Result) And (cdsClient.State In [dsInsert, dsEdit]) Then
    Begin
      cdsClient.FieldByName('AUTINC').AsString := qryDadIte.FieldByName('AUTOINCREM').AsString;
      cdsClient.FieldByName('DESITE').AsString := qryDadIte.FieldByName('ITE_DESITE').AsString;
      cdsClient.FieldByName('CODMAR').AsString := qryDadIte.FieldByName('ITE_CODMAR').AsString;
      cdsClient.FieldByName('DESMAR').AsString := qryDadIte.FieldByName('MAR_DESMAR').AsString;
      cdsClient.FieldByName('ORIPIC').AsString := IIF(qryDadIte.FIeldByName('LOC_PICKIN').AsString = 'S','S','');
      cdsClient.FieldByName('SIGUNI').AsString := qryDadIte.FieldByName('UNI_SIGUNI').AsString;
      cdsClient.FieldByName('SALORI').AsFloat := qryDadIte.FieldByName('LOT_SALDOS').AsFloat +
        qryDadIte.FieldByName('LOT_SAL_ML').AsFloat;
      cdsClient.FieldByName('SALORIRES').AsFloat := 0;
//      cdsClient.FieldByName('SALORI').AsFloat := cdsClient.FieldByName('SALORI').AsFloat - cdsClient.FieldByName('SALORIRES').AsFloat;
      cdsClient.FieldByName('MAXORI').AsFloat := qryDadIte.FieldByName('LOT_CAPACI').AsFloat;
      cdsClient.FieldByName('REPORI').AsFloat := qryDadIte.FieldByName('LOT_PONREP').AsFloat;
      cdsClient.FieldByName('LOCORI').AsString:= qryDadIte.FieldByName('LOT_LOCFIS').AsString;
      If (qryDadIte.FieldByName('LOC_CRITIC').AsString <> 'S') Then
      Begin
        cdsClient.FieldByName('SALORIRES').AsFloat := fGetSaldoResLotDor(cdsClient.FieldByName('CODITE').AsString, strLocFis, VS_strCodEmp);
        cdsClient.FieldByName('SALORIDIS').AsFloat := qryDadIte.FieldByName('LOT_SALDOS').AsFloat +
                                                       qryDadIte.FieldByName('LOT_SAL_ML').AsFloat -
                                                   TSaldoReservado.New(
                                                     TReservaParametros.New()
                                                       .EmpresaItem(VS_strCodEmp)
                                                       .CodigoItem(qryDadIte.FieldByName('LOT_CODITE').AsString)
                                                       .CodEmpresa(VS_strCodEmp)
                                                       .NumeroLote(qryDadIte.FieldByName('LOT_NUMLOT').AsString)
                                                     ).fGetQuantidade();
      End;

      If cdsClient.FindField('DESLFO') <> Nil Then
        cdsClient.FieldByName('DESLFO').AsString := fRetNomLocFisica(qryDadIte.FieldByName('LOT_LOCFIS').AsString);
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
    End;

  Finally
    FreeAndNil(qryDadIte);
  End;
End;

Function TTransferenciaLote.fGeraTransferencia(blnManual: Boolean = False;  blnConfirmacaoPainel: Boolean = False): Boolean;
Var
  strKey: String;
  strCodIte,
  strLotOri,
  strLocDes:  String;
  strDesIte: String;
  strMensagem: String;
  strOpeDes: String;
  fltQtdIte:  Currency;
begin
  Result := False;
  FProgre.Position := 0;
  FProgre.Visible  := True;
  FProgre.Max      := 2* FTransf.RecordCount + 1;

  objMovLot.pLimpar;

  Try
    FTransf.DisableControls;
    fStartTransaction;

    FTransf.First;
    While (Not FTransf.Eof) Do
    Begin
      Result := False;
      FProgre.StepBy(1);
      Application.ProcessMessages;

      strKey := FTransf.FieldByName('AUTINC').AsString;
      strCodIte := FTransf.FieldByName('CODITE').AsString;
      strDesIte := FTransf.FieldByName('DESITE').AsString;
      strLocDes := FTransf.FieldByName('LOCDES').AsString;
      fltQtdIte := FTransf.FieldByName('QTDITE').AsCurrency;
      strOpeDes := FTransf.FieldByName('OPEDES').AsString;
      If blnManual then
        strLotOri := FTransf.FieldByName('LOTORI').AsString;

      objMovLot.
        fDataVencimento(fNow).
        fOperador(FCodOpe).
        fPickin(blnManual);

      If Not blnManual Then
      Begin
        if objMovLot.fTemMovimentoProgramadoEmAberto(strCodIte) then
        begin
          strMensagem := Format('O item %s - %s tem movimentação programada em aberto!',[strCodIte,strDesIte]);
          Break;
        end;
      End;

      if Not objMovLot.fRealizaMovimentos(strCodIte,strLocDes,fltQtdIte, strOpeDes, blnManual, strLotOri, blnConfirmacaoPainel) then
      begin
        strMensagem := 'Não foi possível gerar movimentação programada manual';
        Break;
      end;

      Result := true;
      FTransf.Next;
    End;
    FTransf.EnableControls;
    FProgre.Position := 0;
    FProgre.Visible  := False;

    if Not Result then
      Abort;

    fCommit;
    pRemoveLocks;
    FInsert.EmptyDataSet;
    FTransf.EmptyDataSet;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      raise Exception.Create(strMensagem + IIF(fEmptyStr(strMensagem), '', sLineBreak) + E.Message);
    End;
  End;
End;

Function TTransferenciaLote.fGeraTransferenciaAbastecimentoPicking(blnManual: Boolean = False;  blnConfirmacaoPainel: Boolean = False): Boolean;
Var
  strKey: String;
  strCodIte,
  strLotOri,
  strLocDes:  String;
  strDesIte: String;
  strMensagem: String;
  strOpeDes: String;
  fltQtdIte:  Currency;
begin
  Result := False;
  FProgre.Position := 0;
  FProgre.Visible  := True;
  FProgre.Max      := 2* FTransf.RecordCount + 1;

  objMovLot.pLimpar;

  Try
    FTransf.DisableControls;
    fStartTransaction;

    FTransf.First;
    While (Not FTransf.Eof) Do
    Begin
      Result := False;
      FProgre.StepBy(1);
      Application.ProcessMessages;

      strKey := FTransf.FieldByName('AUTINC').AsString;
      strCodIte := FTransf.FieldByName('CODITE').AsString;
      strDesIte := FTransf.FieldByName('DESITE').AsString;
      strLocDes := FTransf.FieldByName('LOCDES').AsString;
      fltQtdIte := FTransf.FieldByName('QTDITE').AsCurrency;
      strOpeDes := FTransf.FieldByName('OPEDES').AsString;
      If blnManual then
        strLotOri := FTransf.FieldByName('LOTORI').AsString;

      objMovLot.
        fDataVencimento(fNow).
        fOperador(FCodOpe).
        fPickin(blnManual);

      if objMovLot.fTemMovimentoProgramadoEmAberto(strCodIte) then
      begin
        strMensagem := Format('O item %s - %s tem movimentação programada em aberto!',[strCodIte,strDesIte]);
        Break;
      end;

      if Not objMovLot.fRealizaMovimentos(strCodIte,strLocDes,fltQtdIte, strOpeDes, blnManual, strLotOri, blnConfirmacaoPainel) then
      begin
        strMensagem := 'Não foi possível gerar movimentação programada manual';
        Break;
      end;

      Result := true;
      FTransf.Next;
    End;
    FTransf.EnableControls;
    FProgre.Position := 0;
    FProgre.Visible  := False;

    if Not Result then
      Abort;

    fCommit;
    FInsert.EmptyDataSet;
    FTransf.EmptyDataSet;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      raise Exception.Create(strMensagem + IIF(fEmptyStr(strMensagem), '', sLineBreak) + E.Message);
    End;
  End;
End;

Procedure TTransferenciaLote.pFormataCampos(cdsClient: TUniClientDataSet);
  Var
    intDecUni: Integer;
begin
  intDecUni := fCfgSis('DECUNI');
  TFloatField(cdsClient.FieldByName('QTDITE')).DisplayFormat := fMskDigitos(intDecUni);
  TFloatField(cdsClient.FieldByName('SALDOS')).DisplayFormat := fMskDigitos(intDecUni);
  TFloatField(cdsClient.FieldByName('SALORI')).DisplayFormat := fMskDigitos(intDecUni);
  TFloatField(cdsClient.FieldByName('MAXORI')).DisplayFormat := fMskDigitos(intDecUni);
  TFloatField(cdsClient.FieldByName('REPORI')).DisplayFormat := fMskDigitos(intDecUni);
  TFloatField(cdsClient.FieldByName('SALDES')).DisplayFormat := fMskDigitos(intDecUni);
  TFloatField(cdsClient.FieldByName('MAXDES')).DisplayFormat := fMskDigitos(intDecUni);
  TFloatField(cdsClient.FieldByName('REPDES')).DisplayFormat := fMskDigitos(intDecUni);

  TFloatField(cdsClient.FieldByName('SALORIRES')).DisplayFormat := fMskDigitos(intDecUni);
  TFloatField(cdsClient.FieldByName('SALORIDIS')).DisplayFormat := fMskDigitos(intDecUni);
  TFloatField(cdsClient.FieldByName('SALDESRES')).DisplayFormat := fMskDigitos(intDecUni);
  TFloatField(cdsClient.FieldByName('SALDESDIS')).DisplayFormat := fMskDigitos(intDecUni);
end;

function TTransferenciaLote.fValidarLocalizacaoDestino(const strCodIte,strLocDes: String): Boolean;
Var
  qryDadIte: TUniQuery;
  cdsClient: TUniClientDataSet;
Begin
  If FdtsTra.DataSet = FTransf Then
    cdsClient := FTransf
  Else
    cdsClient := FInsert;

  qryDadIte := fCriaQuery(Self);
  Try
    qryDadIte.SQL.Add('SELECT I.ITE_CODITE,I.ITE_DESITE, LOT_SALDOS FROM CADLOT       ');
    qryDadIte.SQL.Add(' INNER JOIN CADITE I ON I.ITE_CODITE = LOT_CODITE');
    qryDadIte.SQL.Add(' INNER JOIN ITEGER G ON G.ITE_CODITE= LOT_CODITE ');
    qryDadIte.SQL.Add('                    AND G.ITE_CODEMP = LOT_CODEMP');
    qryDadIte.SQL.Add(' LEFT  JOIN CADLOC   ON   LOC_CODLOC = LOT_LOCFIS ');
    qryDadIte.SQL.Add('                    AND   LOT_CODEMP = LOC_CODEMP ');
    qryDadIte.SQL.Add('WHERE LOT_CODEMP = :CODEMP ');
    qryDadIte.SQL.Add('  AND LOT_LOCFIS = :LOCFIS ');
    qryDadIte.SQL.Add('  AND LOT_CODITE <> :CODITE');
    qryDadIte.ParamByName('LOCFIS').AsString := strLocDes;
    qryDadIte.ParamByName('CODITE').AsString := strCodIte;
    qryDadIte.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryDadIte.Open;
    Result := (qryDadIte.IsEmpty);
    If (Not qryDadIte.IsEmpty) Then
     If (qryDadIte.FieldByName('LOT_SALDOS').AsFloat > 0) Then
       Result := (fMensagem('"Atenção!', 'A localização física informada está vinculada' +
                ' a outro produto: ' + qryDadIte.FieldByName('ITE_CODITE').AsString + ' ' +
                qryDadIte.FieldByName('ITE_DESITE').AsString +
                '. Deseja continuar?', ['&Sim', '&Não'],2) In [0,1])
     Else
       Result := True;

    If (Result) And (cdsClient.State In [dsInsert, dsEdit]) Then
    begin
     cdsClient.FieldByName('DESPIC').AsString := IIF(fIsPicking(strLocDes),'S','');
      qryDadIte.Close;
      qryDadIte.SQL.Clear;

      qryDadIte.SQL.Add('SELECT I.LCI_QTDMAX AS QTDMAX');
      qryDadIte.SQL.Add('  FROM CADLOC B ');
      qryDadIte.SQL.Add(' LEFT JOIN LOCITE I ON LCI_LOCFIS = B.AUTOINCREM ');
      qryDadIte.SQL.Add('WHERE B.LOC_CODLOC = :CODLOC');
      qryDadIte.SQL.Add('  AND I.LCI_CODITE = :CODITE');

      qryDadIte.ParamByName('CODITE').AsString := strCodIte;
      qryDadIte.ParamByName('CODLOC').AsString := strLocDes;
      qryDadIte.Open;

      if not qryDadIte.IsEmpty then
        cdsClient.FieldByName('MAXDES').AsFloat := qryDadIte.FieldByName('QTDMAX').AsFloat
      else
        cdsClient.FieldByName('MAXDES').AsFloat := 0;
    end;

  Finally
    FreeAndNil(qryDadIte);
  End;
end;

function TTransferenciaLote.fIsPicking(strCodLoc: String): Boolean;
var
  qryLoc: TUniQuery;
begin
  Try
    qryLoc := fCriarQuery('SELECT LOC_PICKIN FROM CADLOC WHERE LOC_CODLOC = '+QuotedStr(strCodLoc));
    qryLoc.Open;
    Result := qryLoc.FieldByName('LOC_PICKIN').AsString = 'S';
  Finally
    FreeAndNil(qryLoc);
  End;
end;

function TTransferenciaLote.ObjMovLot: TMovimentacaoProgramada;
begin
  Result := FobjMovLot;
end;

procedure TTransferenciaLote.OnCdsAbastPrevDetailBeforePost(DataSet: TDataSet);
var strTrava: String;
begin
  If DataSet.FieldByName('LOT_SELECE_DETAIL').AsString =  'S' Then
  Begin
    If Not fLockUnLock(DataSet.FieldByName('ITE_CODITE').AsString,
                          DataSet.FieldByName('LOT_NUMLOT').AsString,
                          DataSet.FieldByName('LCI_CODEMP').AsString,
                          True,
                          strTrava) Then
    Begin
      fMensagem('ATENÇÃO!', 'Essa cotação está sendo utilizado por outra estação: ' + fGetHostLock(strTrava), ['&Ok']);
      DataSet.FieldByName('LOT_SELECE_DETAIL').AsString := 'N';
    End
  End
  Else
    fLockUnLock(DataSet.FieldByName('ITE_CODITE').AsString,
                DataSet.FieldByName('LOT_NUMLOT').AsString,
                DataSet.FieldByName('LCI_CODEMP').AsString,
                False,
                strTrava)
end;

function TTransferenciaLote.fPesquisar(ARecFiltros: TRecFiltrosAbastecimentoPreventivoPicking): Boolean;
begin
  Try
    If Not FCdsAbastPrev.IsEmpty Then
      pRemoveLocks;

    FCdsAbastPrev.qryQuery.SQL.Clear;
    FCdsAbastPrev.qryQuery.SQL.Add(fGetSQLAbastecimentoPreventivoMaster(ARecFiltros));
    FCdsAbastPrev.fAbreClient(True, 'TTransferenciaLote.fPesquisar', False, True);

    (FCdsAbastPrev.FieldByName('ITE_QTDSEP') As TFloatField).DisplayFormat := '#,##0.00';
    (FCdsAbastPrev.FieldByName('ITE_QTDMOV') As TFloatField).DisplayFormat := '#,##0.00';
    (FCdsAbastPrev.FieldByName('ITE_SALDOS') As TFloatField).DisplayFormat := '#,##0.00';
    (FCdsAbastPrev.FieldByName('ITE_SALFIS') As TFloatField).DisplayFormat := '#,##0.00';
    (FCdsAbastPrev.FieldByName('LOC_PONREP') As TFloatField).DisplayFormat := '#,##0.00';
    (FCdsAbastPrev.FieldByName('LOC_CAPACI') As TFloatField).DisplayFormat := '#,##0.00';
    (FCdsAbastPrev.FieldByName('CAPACIDADE_CALCULADA') As TFloatField).DisplayFormat := '#,##0.00';
    (FCdsAbastPrev.FieldByName('ITE_SUGUNI') As TFloatField).DisplayFormat := '#,##0.00';
    (FCdsAbastPrev.FieldByName('ITE_SUGEMB') As TFloatField).DisplayFormat := '#,##0.00';
    (FCdsAbastPrev.FieldByName('BAR_EMBALA') As TFloatField).DisplayFormat := '#,##0.00';


    FCdsAbastPrevDetail.qryQuery.SQL.Clear;
    FCdsAbastPrevDetail.qryQuery.SQL.Add(fGetSQLAbastecimentoPreventivoDetail(ARecFiltros));
    FCdsAbastPrevDetail.fLeDados('TTransferenciaLote.fPesquisar', True, 'Selecionando lotes...');

    If Not FCdsAbastPrevDetail.IsEmpty Then
      pCriaOsLocks;


    FCdsAbastPrevDetail.BeforePost := OnCdsAbastPrevDetailBeforePost;

    Result := True;
  Except On
    E:Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, 'TTransferenciaLote.fPesquisar');
    End;
  End;
end;


function TTransferenciaLote.fGetcdsAbastPrevDetail: TUniClientDataSet;
begin
  Result := FCdsAbastPrevDetail.fGetUniClientDataset;
end;

function TTransferenciaLote.fGetcdsAbastPrevMaster: TUniClientDataSet;
begin
  Result := FCdsAbastPrev.fGetUniClientDataset;
end;


function TTransferenciaLote.fGetOrdenacaoLotes(AItems: TStrings): String;
var
  I: Integer;
Begin
  For I := 0 To Pred(AItems.Count) Do
  Begin
    Case AnsiIndexStr(AItems[I], ['Localização física', 'Data de validade','Proximidade do picking','Data de balanço']) Of
      0: Result := Result + 'CADLOT.LOT_LOCFIS';
      1: Result := Result + 'IFNULL(CADLOT.LOT_DTAVAL,"9999-12-31")';
      2: Result := Result + 'DISTANCIA';
      3: Result := Result + 'IFNULL(CADLOT.LOT_DTABAL,"9999-12-31")';
    End;
    If I < Pred(AItems.Count) Then
      Result := Result + ',';
  End;
end;

function TTransferenciaLote.fGetSQLBase(ARecFiltros: TRecFiltrosAbastecimentoPreventivoPicking): String;
var
  strSalDes,
  strCapaci: String;
Begin
  strSalDes := IIF(ARecFiltros.blnConsiderarMovimentacoesEmAndamento, 'ITE_SALDOS - ITE_QTDSEP + ITE_QTDMOV', 'ITE_SALDOS');
  strCapaci := IIF(ARecFiltros.blnAbastecerItensPctg, '(LOC_CAPACI * ' + StringReplace(FloatToStr(ARecFiltros.fltPctCapMax), ',','.',[]) + ' / 100.00)','LOC_CAPACI');

  Result := '';
  Result := Result + '   SELECT                                                            ';
  Result := Result + '     CAST("S" AS CHAR(1)) AS ITE_SELECE,                             ';
  Result := Result + '     CHAVE_MASTER,                                                   ';
  Result := Result + '     ITE_CODITE,                                                     ';
  Result := Result + '     ITE_NIVGIR,                                                     ';
  Result := Result + '     ITE_DESITE,                                                     ';
  Result := Result + '     UNI_DESUNI,                                                     ';
  Result := Result + '     LCI_CODEMP,                                                     ';
  Result := Result + '     MAR_DESMAR,                                                     ';
  Result := Result + '     BAR_EMBALA,                                                     ';
  Result := Result + '     LOC_CODLOC,                                                     ';
  Result := Result + '     LOC_PREDIO,                                                     ';
  Result := Result + '     LOC_R_U_A_,                                                     ';
  Result := Result + '     ITE_QTDSEP,                                                     ';
  Result := Result + '     LOT_DTABAL,                                                     ';
  Result := Result + '     ITE_QTDMOV,                                                     ';
  Result := Result + '  ' + strCapaci + ' AS CAPACIDADE_CALCULADA,                         ';
  Result := Result + '     ITE_SALDOS AS ITE_SALFIS,                                       ';
  Result := Result +       strSalDes + ' AS ITE_SALDOS,                                    ';
  Result := Result + '     LOC_PONREP,                                                     ';
  Result := Result + '     LOC_CAPACI,                                                     ';
  Result := Result + '     @QTDMOV := ((' + strSalDes + ') - LOC_CAPACI) * -1 VAR_QTDMOV, ';
  Result := Result + '     IFNULL(FLOOR(IF(@QTDMOV < 0 , 0,  @QTDMOV)), 0) AS ITE_SUGUNI,';
  Result := Result + '     FLOOR(                                                        ';
  Result := Result + '       IFNULL(FLOOR(IF(@QTDMOV < 0 , 0,  @QTDMOV)), 0) / BAR_EMBALA';
  Result := Result + '     ) AS ITE_SUGEMB                                                 ';
  Result := Result + '   FROM                                                              ';
  Result := Result + '     (SELECT                                                         ';
  Result := Result + '       CAST(                                                         ';
  Result := Result + '         REPLACE(CONCAT(LOC.LOC_CODLOC, "_", C.ITE_CODITE),"-","") AS CHAR(20)  ';
  Result := Result + '       ) AS CHAVE_MASTER,                                            ';
  Result := Result + '       C.ITE_CODITE,                                                 ';
  Result := Result + '       I.ITE_NIVGIR,                                                 ';
  Result := Result + '       L.LOT_DTABAL,                                                 ';
  Result := Result + '       C.ITE_DESITE,                                                 ';
  Result := Result + '       U.UNI_DESUNI,                                                 ';
  Result := Result + '       M.MAR_DESMAR,                                                 ';
  Result := Result + '     MAP.LCI_CODEMP,                                                 ';
  Result := Result + '       B.BAR_EMBALA,                                                 ';
  Result := Result + '       B.BAR_COMPRA,                                                 ';
  Result := Result + '       L.LOT_STATUS,                                                 ';
  Result := Result + '       LOC.LOC_CODLOC,                                               ';
  Result := Result + '       LOC.LOC_R_U_A_,                                               ';
  Result := Result + '       LOC.LOC_PREDIO,                                               ';
  Result := Result + '       IFNULL(                                                       ';
  Result := Result + '         (SELECT                                                     ';
  Result := Result + '           SUM(LDO_QTDITE)                                           ';
  Result := Result + '         FROM                                                        ';
  Result := Result + '           LOTDOR                                                    ';
  Result := Result + '           INNER JOIN FATDOR                                         ';
  Result := Result + '             ON LDO_SEQFDO = FATDOR.AUTOINCREM                       ';
  Result := Result + '         WHERE LDO_NUMLOT = L.LOT_NUMLOT                             ';
  Result := Result + '           AND FDO_CODEMP = I.ITE_CODEMP                             ';
  Result := Result + '           AND FDO_CODITE = I.ITE_CODITE),                           ';
  Result := Result + '         0                                                           ';
  Result := Result + '       ) AS ITE_QTDSEP,                                              ';
  Result := Result + '       SUM(IF( MLT_DTAREA IS NULL, IF(MLT_LOTDES = L.LOT_NUMLOT, IFNULL(MLT.MLT_QTDMOV, 0) , ';
  Result := Result + '                         - IFNULL(MLT.MLT_QTDMOV, 0)), 0)) AS ITE_QTDMOV,';
  Result := Result + '       IFNULL(                                                       ';
  Result := Result + '         (SELECT                                                     ';
  Result := Result + '           SUM(LOT_SALDOS)                                           ';
  Result := Result + '         FROM                                                        ';
  Result := Result + '           CADLOT                                                    ';
  Result := Result + '         WHERE LOT_LOCFIS = LOC.LOC_CODLOC                           ';
  Result := Result + '           AND LOT_CODITE = I.ITE_CODITE                             ';
  Result := Result + '           AND LOT_SALDOS > 0),                                      ';
  Result := Result + '         0                                                           ';
  Result := Result + '       ) AS ITE_SALDOS,                                              ';
  Result := Result + '       IFNULL(MAP.LCI_QTDREP,0) AS LOC_PONREP,                       ';
  Result := Result + '       IFNULL(MAP.LCI_QTDMAX,0) AS LOC_CAPACI                        ';
  Result := Result + '     FROM                                                            ';
  Result := Result + '      LOCITE MAP                                                     ';

  Result := Result + '     INNER JOIN CADLOC LOC ON MAP.LCI_LOCFIS = LOC.AUTOINCREM ';
  Result := Result + '                           AND LOC.LOC_PICKIN = "S" ';
  Result := Result + '                           AND LOC.LOC_CODEMP = MAP.LCI_CODEMP ';
  Result := Result + '     INNER JOIN CADLOT L ON L.LOT_LOCFIS = LOC.LOC_CODLOC ';
  Result := Result + '                        AND L.LOT_STATUS = "S" ';
  Result := Result + '                        AND L.LOT_CODEMP = MAP.LCI_CODEMP ';
  Result := Result + '                        AND L.LOT_CODITE = MAP.LCI_CODITE ';

  Result := Result + '      INNER JOIN CADITE C ON C.ITE_CODITE = L.LOT_CODITE             ';
  Result := Result + '      INNER JOIN ITEGER I ON I.ITE_CODITE = C.ITE_CODITE             ';
  Result := Result + '                         AND I.ITE_CODEMP = MAP.LCI_CODEMP           ';
  Result := Result + '      INNER JOIN CADMAR M ON MAR_CODMAR = C.ITE_CODMAR               ';
  Result := Result + '      INNER JOIN CADUNI U ON ITE_CODUNI = UNI_CODUNI                 ';
  Result := Result + '      LEFT JOIN ITEBAR B ON BAR_CODITE = I.ITE_CODITE  AND BAR_COMPRA = 1 ';
  Result := Result + '      LEFT JOIN MOVLOT MLT ON MLT.MLT_CODITE = I.ITE_CODITE          ';
  Result := Result + '                          AND MLT.MLT_CODEMP = I.ITE_CODEMP          ';
  Result := Result + '                             AND MLT.MLT_DTAREA IS NULL              ';
  Result := Result + '                          AND ((MLT_LOTDES = L.LOT_NUMLOT) OR        ';
  Result := Result + '                              (MLT_LOTORI = L.LOT_NUMLOT))           ';
  Result := Result + '    WHERE MAP.LCI_CODEMP = ' + QuotedStr(ARecFiltros.strCodEmp)       ;
  Result := Result + '      AND IFNULL(MAP.LCI_QTDMAX, 0) >  0 ' ;

  Result := Result + ' AND LOC.AUTOINCREM NOT IN (SELECT LAR_LOCFIS FROM CADLAR LAR WHERE LAR.LAR_LOCFIS = LOC.AUTOINCREM ) ';
  Try
    Result := Result + ' AND LOC.LOC_CODLOC <> ' + QuotedStr(fCfgSis('LCTALC'));
  Except
  End;

  Try
    Result := Result + ' AND LOC.LOC_CODLOC NOT LIKE ' + QuotedStr(fCfgSis('LCTASE') + '%');
  Except
  End;

  Result := Result + '    GROUP BY LOT_LOCFIS, LOT_CODITE) TMP                             ';
  Result := Result + '  WHERE ITE_SALDOS < ' + strCapaci                                    ;

  If ARecFiltros.blnConsiderarEmbalagemFechada Then
    Result := Result + ' AND BAR_COMPRA  = 1 ';

  If ARecFiltros.strNivGir <> 'T' Then
    Result := Result + ' AND ITE_NIVGIR = ' + QuotedStr(ARecFiltros.strNivGir);

  Result := Result + '  ORDER BY ITE_CODITE ';



End;

Function TTransferenciaLote.fGetSQLBaseComLote(ARecFiltros: TRecFiltrosAbastecimentoPreventivoPicking; blnCapa: Boolean = False): String;
begin

  Result := '';
  Result := Result + 'SET @QTDTRANSFRES := 0; ';
  Result := Result + 'SET @CHAVEMESTRE := ""; ';
  Result := Result + 'SET @AUTINC := 0; ';
  Result := Result + 'SET @LOT_SALDOS := 0; ';
  Result := Result + 'SET @DISTANCIA := 0; ';

  Result := Result + 'SELECT * ';
  If blnCapa Then
    Result := Result + ' , GROUP_CONCAT(' + QuotedStr('"') + ',  LOT_NUMLOT, ' + QuotedStr('"') + ') AS LOTES_AMARRADOS ';

  Result := Result + ' FROM (SELECT ';
  Result := Result + '       @DISTANCIA := (ABS(MASTER.LOC_R_U_A_ - CADLOC.LOC_R_U_A_) * 2 + ABS(MASTER.LOC_PREDIO - CADLOC.LOC_PREDIO)) AS DISTANCIA, ';
  Result := Result + '       MASTER.*, ';
  Result := Result + '       CAST("S" AS CHAR(1)) AS LOT_SELECE_DETAIL,  ';

  Result := Result + ' CADLOT.AUTOINCREM, ';
  Result := Result + '  LOT_LOCFIS, ';
  Result := Result + '  LOT_NUMLOT, ';

  Result := Result + ' @LOT_SALDOS := LOT_SALDOS - IFNULL((SELECT SUM(LDO_QTDITE) ';
  Result := Result + '                                       FROM LOTDOR ';
  Result := Result + '                                      INNER JOIN FATDOR ON LDO_SEQFDO = FATDOR.AUTOINCREM ';
  Result := Result + '                                      WHERE LDO_NUMLOT = CADLOT.LOT_NUMLOT ';
  Result := Result + '                                        AND FDO_CODEMP = CADLOT.LOT_CODEMP ';
  Result := Result + '                                        AND FDO_CODITE = CADLOT.LOT_CODITE), 0) ';
  Result := Result + '                           - IFNULL((SELECT SUM(IFNULL(MLT.MLT_QTDMOV, 0)) ';
  Result := Result + '                                       FROM MOVLOT MLT ';
  Result := Result + '                                      WHERE MLT.MLT_CODITE = LOT_CODITE ';
  Result := Result + '                                        AND MLT.MLT_CODEMP = LOT_CODEMP ';
  Result := Result + '                                        AND MLT.MLT_DTAREA IS NULL ';
  Result := Result + '                                        AND MLT_LOTORI = LOT_NUMLOT), 0) AS LOT_SALDOS , ';

  Result := Result + '  LOT_DTAVAL, ';
  Result := Result + '  @AUTINC := @AUTINC + 1 AS CHAVE_FILHO, ';

  If ARecFiltros.blnConsiderarEmbalagemFechada Then
  Begin
    Result := Result + '  IF(@CHAVEMESTRE  <> MASTER.CHAVE_MASTER,  @QTDTRANSFRES := (ITE_SUGEMB * BAR_EMBALA), @QTDTRANSFRES) AS RESTO_TRASF, ';
    Result := Result + '  @QTD_TRANSF := IF(@QTDTRANSFRES > 0 , IF(@QTDTRANSFRES > @LOT_SALDOS , BAR_EMBALA * FLOOR(@LOT_SALDOS/ BAR_EMBALA), @QTDTRANSFRES), 0) AS QTD_TRANSF, ';
  End
  Else
  Begin
    Result := Result + '  IF(@CHAVEMESTRE  <> MASTER.CHAVE_MASTER,  @QTDTRANSFRES := ITE_SUGUNI, @QTDTRANSFRES) AS RESTO_TRASF, ';
    Result := Result + '  @QTD_TRANSF := IF(@QTDTRANSFRES > 0 , IF(@QTDTRANSFRES > @LOT_SALDOS, @LOT_SALDOS, @QTDTRANSFRES), 0) AS QTD_TRANSF, ';
  End;

  Result := Result + '  @QTDTRANSFRES := @QTDTRANSFRES- @QTD_TRANSF AS CALCRES, ';
  Result := Result + '  IF(@CHAVEMESTRE  <> MASTER.CHAVE_MASTER,  @CHAVEMESTRE := MASTER.CHAVE_MASTER, @CHAVEMESTRE) AS PICKING_ATUAL ';
  Result := Result + ' FROM ';
  Result := Result + ' (' + fGetSQLBase(ARecFiltros) + ') MASTER ';
  Result := Result + '  INNER JOIN CADLOT ON CADLOT.LOT_CODITE = MASTER.ITE_CODITE ';
  Result := Result + '                 AND CADLOT.LOT_CODEMP = MASTER.LCI_CODEMP ';
  Result := Result + '  INNER JOIN CADLOC ON CADLOT.LOT_LOCFIS = CADLOC.LOC_CODLOC ';
  Result := Result + '                   AND CADLOT.LOT_CODEMP = CADLOC.LOC_CODEMP ';
  Result := Result + '    WHERE CADLOC.LOC_PICKIN = "N" ';
  Result := Result + '      AND CADLOT.LOT_STATUS = "S" ';
  Result := Result + '      AND CADLOT.LOT_DIGCON <> "S"';
  Result := Result + '      AND CADLOT.LOT_CODEMP = ' + QuotedStr(ARecFiltros.strCodEmp);
  Result := Result + '      AND CADLOT.LOT_SALDOS > 0 ';
  Result := Result + '      AND CADLOT.LOT_PRITIN = "N" ';
  Result := Result + '      AND CADLOT.LOT_TRANSI = "N" ';
  Result := Result + '      AND CADLOT.LOT_NUMLOT NOT IN("A DEFINIR", "GARANTIA") ';
  Result := Result + '      AND CADLOC.AUTOINCREM NOT IN (SELECT LAR_LOCFIS FROM CADLAR LAR WHERE LAR.LAR_LOCFIS = CADLOC.AUTOINCREM ) ';
  Try
    Result := Result + '      AND CADLOC.LOC_CODLOC <> ' + QuotedStr(fCfgSis('LCTALC'));
  Except
  End;
  Try
    Result := Result + '      AND CADLOC.LOC_CODLOC NOT LIKE ' + QuotedStr(fCfgSis('LCTASE') + '%');
  Except
  End;
  Result := Result + '   ORDER BY CADLOT.LOT_CODITE, CADLOT.LOT_CODEMP, ' + ARecFiltros.strOrdemLote;
  Result := Result + '  ) DETAIL ';
  Result := Result + ' WHERE QTD_TRANSF > 0 ';
  If blnCapa Then
    Result := Result + '    GROUP BY CHAVE_MASTER ';
  Result := Result + 'ORDER BY ITE_CODITE ';
End;

function TTransferenciaLote.fGetSQLAbastecimentoPreventivoMaster(ARecFiltros: TRecFiltrosAbastecimentoPreventivoPicking): String;
begin
  Result :=  fGetSQLBaseComLote(ARecFiltros, True);
end;

Function TTransferenciaLote.fGetSQLAbastecimentoPreventivoDetail(ARecFiltros: TRecFiltrosAbastecimentoPreventivoPicking): String;
Begin
  Result :=  fGetSQLBaseComLote(ARecFiltros, False);
End;

Function TTransferenciaLote.fGeraTransferenciaAbastecimentoPreventivoPicking(strCodOpe: String): Boolean;
Var
  strCodIte,
  strDesIte,
  strLotOri,
  strLocOri,
  strLocDes: String;
  fltQtdTransf:  Currency;
  qryIns: TUniQuery;
  dtaDtaVal: TDateTime;
begin
  Result := False;
  FProgre.Position := 0;
  FProgre.Visible  := True;

  qryIns := ObjMovLot.fCriaQueryInsertMovLot;

  Try
    FCdsAbastPrev.DisableControls;
    FCdsAbastPrevDetail.DisableControls;
    fStartTransaction;

    FCdsAbastPrev.Filter := 'ITE_SELECE = ''S''';
    FCdsAbastPrev.Filtered := True;
    FCdsAbastPrev.First;

    FProgre.Max      := 2* FCdsAbastPrev.RecordCount + 1;

    While (Not FCdsAbastPrev.Eof) Do
    Begin
      Result := False;
      FProgre.StepBy(1);
      Application.ProcessMessages;

      FCdsAbastPrevDetail.Filtered := False;
      FCdsAbastPrevDetail.Filter := 'CHAVE_MASTER = ' + QuotedStr(FCdsAbastPrev.FieldByName('CHAVE_MASTER').AsString) + ' AND LOT_SELECE_DETAIL = ''S''';
      FCdsAbastPrevDetail.Filtered := True;

      If FCdsAbastPrevDetail.IsEmpty Then
        Result := False;

      FCdsAbastPrevDetail.First;
      While Not FCdsAbastPrevDetail.Eof Do
      Begin
        Result := True;

        strCodIte := FCdsAbastPrev.FieldByName('ITE_CODITE').AsString;
        strDesIte := FCdsAbastPrev.FieldByName('ITE_DESITE').AsString;
        strLocDes := FCdsAbastPrev.FieldByName('LOC_CODLOC').AsString;
        fltQtdTransf := FCdsAbastPrevDetail.FieldByName('QTD_TRANSF').AsFloat;
        strLotOri := FCdsAbastPrevDetail.FieldByName('LOT_NUMLOT').AsString;
        strLocOri := FCdsAbastPrevDetail.FieldByName('LOT_LOCFIS').AsString;  //Pulmão daonde está vindo o lote
        dtaDtaVal := FCdsAbastPrevDetail.FieldByName('LOT_DTAVAL').AsDateTime;

        ObjMovLot.fOperador(FCodOpe);
        ObjMovLot.pGravarMovLotAbastPicking(qryIns, strCodIte, strLotOri, strLocOri, strLocDes, strCodOpe, fltQtdTransf, dtaDtaVal);

        FCdsAbastPrevDetail.Next;
      End;

      FCdsAbastPrev.Next;
    End;

    FProgre.Position := 0;
    FProgre.Visible  := False;

    Try
      fCommit;
      FCdsAbastPrev.EmptyDataSet;
      pRemoveLocks;
      FCdsAbastPrevDetail.EmptyDataSet;
    Except
      On E: Exception Do
      Begin
        fRollBack;

        FCdsAbastPrev.Filtered := False;
        FCdsAbastPrevDetail.Filtered := False;
        pMensagensErro(E.Message, 'TTransferenciaLote.fGeraTransferenciaAbastecimentoPreventivoPicking');
      End;
    End;

  Except
    On E: Exception Do
    Begin
      fRollBack;
      FCdsAbastPrev.EnableControls;
      FCdsAbastPrevDetail.EnableControls;
      FCdsAbastPrev.Filtered := False;
      FCdsAbastPrevDetail.Filtered := False;
      pMensagensErro(E.Message, 'TTransferenciaLote.fGeraTransferenciaAbastecimentoPreventivoPicking');
    End;
  End;

  FreeAndNil(qryIns);
End;



{ TLotesSelecionadosMovPro }

{function TLotesSelecionadosMovPro.fGetIndex(ACodIte: String): integer;
var i: integer;
begin

  If ACodIte = '' Then
    Result := -1;

  For i:= 0 To High(ArrLoteSelecionadoItem) do
  Begin
     If ArrLoteSelecionadoItem[i].strCodIte_chave = ACodIte then
       Exit(i)
  End;
  Result := -1;
end;
}
function TLotesSelecionadosMovPro.GetItem(Index: string): TLoteItemSelecionados;
var   LoteItemSelecionados: TLoteItemSelecionados;
begin
  Result.strCodIte_chave := '';
  Result.strLotes := '';

  For LoteItemSelecionados in ArrLoteSelecionadoItem do
  begin
    If LoteItemSelecionados.strCodIte_chave = Index then
    Begin
      Result := LoteItemSelecionados;
      Exit(Result);
    End;
  End;

end;

procedure TLotesSelecionadosMovPro.pAdd(LoteItemSelecionados: TLoteItemSelecionados);
begin
  If High(ArrLoteSelecionadoItem)= -1 Then
    SetLength(ArrLoteSelecionadoItem, 1)
  Else
    SetLength(ArrLoteSelecionadoItem, Length(ArrLoteSelecionadoItem) + 1);
  ArrLoteSelecionadoItem[ High(ArrLoteSelecionadoItem)] := LoteItemSelecionados;
  ArrLoteSelecionadoItem[ High(ArrLoteSelecionadoItem)].Index := High(ArrLoteSelecionadoItem);

end;

procedure TLotesSelecionadosMovPro.pAtualizaLote(
  LoteItemSelecionados: TLoteItemSelecionados);
begin
 ArrLoteSelecionadoItem[LoteItemSelecionados.Index] := LoteItemSelecionados;
end;

procedure TLotesSelecionadosMovPro.Reincia;
begin
    SetLength(ArrLoteSelecionadoItem, 0)

end;
end.


