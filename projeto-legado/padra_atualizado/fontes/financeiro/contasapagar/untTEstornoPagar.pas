unit untTEstornoPagar;

interface

uses Classes, Uni, SysUtils, StrUtils, untTCadPag, System.Generics.Collections,
  Data.DB, System.Threading, Aurelius.Bind.Dataset, Aurelius.Criteria.Expression,
  Aurelius.Criteria.Base, Aurelius.Criteria.Linq, untTCadRcxx, System.Variants,  Math,
  untTCadPagRepository, untTCadRcxxRepository, untTChqEmiRepository, untTCtpDetRepository,
  untTCtpDet, untTMovBan, untTMovBanRepository, untCadChq, untTCadChqRepository,
  untTBanCtpRepository, untTBanChqRepository, Controls, untFechamentoFinanceiro,
  untRcxTResumoDeCaixa, untObjectManager, untCadPag;

Type
  TEstornoPagar = Class(TComponent)
  Private
    FNumDup: String;
    FParcel: String;
    FCodEmp: String;
    FDesEmp: String;
    FDesFor: String;
    FCodFor: String;
    FSerie_: String;

    FBaixaDesmembradaPorModalidadePagamento: Boolean;

    FblnFechadoCaixa: Boolean;

    lstCadPag: TList<TCadPag>;
    lstPagMar: TList<TCadPag>;
    qryCadPag: TAureliusDataset;

    repCadPag: TCadPagRepository;
    repCadRcx: TCadRcxxRepository;
    repChqEmi: TChqEmiRepository;
    repCtpDet: TCtpDetRepository;
    repMovBan: TMovBanRepository;
    repCadChq: TCadChqRepository;

    blnResCai: Boolean;
    strOpeRcx: String;
    dtaDtaCai: TDate;

    repBanCtp: TBanCtpRepository;
    repBanChq: TBanChqRepository;

    blnModalidade: Boolean;
    objFechamento: TFechamentoFinanceiro;

    strCodigoCaixa  : String;
    objResumoDeCaixa: TResumoDeCaixa;
    strTabelaPgoAntecipado: String;

    function fDuplicataPrincipalBaixada(ADup: TCadPag): Boolean;
    function fVerificaDuplicataPrincipal(ADup: TCadPag): Boolean;
    function fEhCadPagUsoConsumo(ADup: TCadPag): Boolean;
    function fDupJaEstornada(ADup: TCadPag): Boolean;

    function fSemVincularSeqCon(APag: TCadPag; blnRecalcularModalidade: Boolean = True): Boolean; overload;
    function fSemVincularSeqCon(ADatasetEstorno: TDataset; blnRecalcularModalidade: Boolean = True): Boolean; overload;

    function fSemMovimentoBancario(APag:TList<TCadPag>): Boolean; overload;
    function fSemMovimentoBancario(ADatasetEstorno: TDataset): Boolean; overload;

    function BaixaDesmembradaPorModalidadePagamento:Boolean;
    function fEhBaixaZeradaCTP(APag:TList<TCadPag>): Boolean;

    procedure setCodEmp(const Value: String);
    procedure setCodFor(const Value: String);
    procedure setNumDup(const Value: String);
    procedure setParcel(const Value: String);
    procedure setSerie_(const Value: String);

    procedure pValidationBeforeConfirm;
    procedure pEstornaDuplicataResumoCaixa(ADup: TCadPag; blnEstDtaDoc: Boolean);
    procedure pDeterminaModalidadeEstorno(intSeqCon: Integer; ARcx: TCadRcxx);
    procedure pGravaMovBan(ADup: TCadPag; blnEstDtaDoc: Boolean; blnEstornoPG: Boolean = False); Overload;
    procedure pGravaMovBan(ADup: TCadPag; lstCtp: TList<TCtpDet>; blnEstDtaDoc: Boolean); Overload;
    procedure pGravaMovBan(lstMov: TList<TMovBan>; blnEstDtaDoc: Boolean; blnEstornoPG: Boolean = False); Overload;
    procedure pRegravaLogBan(strSeqLanProcurar: String; strSeqLanGravacao: String);
    procedure pDefineEhUmPG(ADup: TCadPag);
    function getSelecaoIndividual: Boolean;
    function fLimpaAutoIncremTarifaEntradaBoletoCadRec(strAutoIncremCTP: String): Boolean;

    function DuplicataBaixadaPeloCaixaECaixaDoDiaFechado: Boolean;

    function RetornaAutoIncremsDuplicata: String;
    procedure pAtualizaCTRPAG(vstrAutInc,
                              vstrNumDup,
                              vstrParcel,
                              vstrCodEmp,
                              vstrCodFor,
                              vstrSerie  : String;
                              vintSeqBai : Integer);

    procedure pGravaLogExclusaoPG(ADuplicata: TCadPag);
  Public
    constructor Create(Owner: TComponent;
                       blnResCai: Boolean;
                       strOpeRcx: String;
                       dtaDtaCai: TDate;
                       strCodigoCaixa: String;
                       objResumoDeCaixa: TResumoDeCaixa); Reintroduce;
    destructor Destroy; Override;

    function fVerificaDatasDiferentes(ADup: TCadPag): Boolean;
    function fVerificaDatasDiferentesRcx(ADup: TCadPag): Boolean;
    function fVerificaSaldoMaximoCaixa(ADup: TCadPag): Boolean;
    function fEstornaDuplicataConjugadas(strChamada: String = ''): Boolean;
    function VerificaSeExisteRcxCon: Boolean;
    function fTemPagamentoAntecipadoComPagamentoNormal: Boolean;

    procedure pDeletaChqEmi(ADup: TCadPag);
    procedure pEstornaDuplicataSimples(ADup: TCadPag; strChamada: String = ''; blnPagamentoAntecipado: Boolean = False);
    procedure pEstornaDuplicataParcial(ADup: TCadPag; strChamada: String = ''; blnPagamentoAntecipado: Boolean = False);
    procedure pDeleteSelecion;
    procedure pInsertSelecion;

    procedure pCarregaDados;
    procedure pLimparDados;

    function fVerificaModalidadeBaixa: Boolean; overload;
    function fVerificaModalidadeBaixa(ADatasetEstorno: TDataset): Boolean; overload;

    function fTemPgoGer(ADup: TCadPag; var ATabelaPgoAntecipado: String): Boolean;
    procedure pRelancaPagamentoAntecipado(ADup: TCadPag);

    property strNumDup: String Read FNumDup Write setNumDup;
    property strParcel: String Read FParcel Write setParcel;
    property strCodEmp: String Read FCodEmp Write setCodEmp;
    property strDesEmp: String Read FDesEmp;
    property strCodFor: String Read FCodFor Write setCodFor;
    property strDesFor: String Read FDesFor;
    property strSerie_: String Read FSerie_ Write setSerie_;

    property PagMar   : TList<TCadPag> Read lstPagMar;
    property CadPag   : TList<TCadPag> Read lstCadPag;
    property qryPag   : TAureliusDataset     Read qryCadPag Write qryCadPag;
    property blnSelecaoIndividual: Boolean read getSelecaoIndividual;

    property blnFechadoCaixa: Boolean read FblnFechadoCaixa write FblnFechadoCaixa;
  End;

implementation

uses untFuncoesSimples, untConstantes, untPesqAux, untTChqEmi, untMovBan,
  untLogCtp, untFuncoes, untCadRcxx, untUtilRepository, untLogBan, untTBanCtp,
  untTBanChq, untDigOcorrencia, untLogCtr, untTCadRecRepository,
  untTypesSistema;

{ TEstornoPagar }

procedure TEstornoPagar.setCodEmp(const Value: String);
  Var
    qryGen: TUniQuery;
begin

  If fEmptyStr(Value) Then Raise ExceptionAutCom.Create('O Código da Empresa deve ser preenchido!')
  Else
  Begin
    qryGen := fCriaQuery(Self); pPesquisaCadEmp(qryGen, qryGen, Value);
    FDesEmp := qryGen.FieldByName('EMP_NOMEMP').AsString;
    FreeAndNil(qryGen);

    If fEmptyStr(FDesEmp) Then Raise ExceptionAutCom.Create('Essa empresa não está cadastrada!')
    Else If Pos(Value, strEmpAcessoUsuarioLogado) <= 0 Then Raise ExceptionAutCom.Create('Usuário sem permissão de acesso a essa Empresa!')
    Else FCodEmp := Value;
  End;

end;

procedure TEstornoPagar.setCodFor(const Value: String);
  Var
    qryGen: TUniQuery;
begin

  If fEmptyStr(Value) Then Raise ExceptionAutCom.Create('O Código do Fornecedor deve ser preenchido!')

  Else
  Begin
    qryGen := fCriaQuery(Self); pPesquisaCadFor(qryGen, qryGen, Value);
    FDesFor := qryGen.FieldByName('FOR_NOMFOR').AsString;
    FreeAndNil(qryGen);

    If fEmptyStr(FDesFor) Then Raise ExceptionAutCom.Create('Esse Fornecedor não está cadastrado!')
    Else FCodFor := Value;
  End;

end;

procedure TEstornoPagar.setNumDup(const Value: String);
begin
  If fEmptyStr(Value) Then Raise ExceptionAutCom.Create('O Número da Duplicata deve ser preenchido!')
  Else FNumDup := Value;
end;

procedure TEstornoPagar.setParcel(const Value: String);
begin
  If fEmptyStr(Value) Then Raise ExceptionAutCom.Create('A Parcela deve ser preenchida!')
  Else FParcel := Value;
end;

procedure TEstornoPagar.setSerie_(const Value: String);
begin
  FSerie_ := Value;
end;

{*******************************************************************************************}
{* PERCORRE A LISTA DE DUPLICATAS MARCADAS E VAI VERIFICANDO SE O RCXCON EXISTE NA CADRCXX *}
{*REQ*149088*****************************************************************************MO*}
function TEstornoPagar.VerificaSeExisteRcxCon: Boolean;
Var
  ADuplic: TCadPag;
  _I_    : Integer;
  ARcx   : TCadRcxx;
begin
  Result  := True;
  ADuplic := Nil;
  Try
    For _I_ := 0 To lstPagMar.Count -1 Do
    Begin
      ADuplic := lstPagMar.Items[_I_];

      //A DUPLICATA TEM QUE SER DO CAIXA
      If not (ADuplic.intRescai = 1) then
      Begin
        Result := True;
        Exit;
      End;

      //A DUPLICATA TEM QUE TER RCXCON
      if (ADuplic.intRcxCon <= 0 ) Then
      Begin
        Result := True;
        Exit;
      End;

      ARcx := repCadRcx.RetornaRegistros(ADuplic.intRcxCon, ADuplic.strEmpBai);

      //SE NÃO RETORNAR REGISTRO DO CAIXA APRESENTA A MENSAGEM
      if not Assigned(ARcx) then
        Result := False;
    End;

    if not Result then
      pMensagemOk('Não é possível estornar esta Duplicata!' + #13 +
                  'Duplicata proveniente do caixa com RcxCon não encontrado na CADRCXX!' +#13 + #13 +
                  'Código RcxCon: ' + IntToStr(ADuplic.intRcxCon) + '-' + ADuplic.strEmpBai + '-' + ADuplic.strDtaPag);
  Finally

  End;
end;

function TEstornoPagar.BaixaDesmembradaPorModalidadePagamento: Boolean;
  Var
    I: Integer;
    LSeqCon: Integer;
    LNumDup: String;
    LParcel: String;
    LCodFor: String;
    LCodEmp: String;
    LSerie_: String;
begin
  Result := False;

  If Not (lstCadPag.Count > 1) Then
    Exit;

  LSeqCon := lstCadPag[0].intSeqCon;
  LNumDup := lstCadPag[0].strNumDup;
  LParcel := lstCadPag[0].strParcel;
  LCodFor := lstCadPag[0].strCodFor;
  LCodEmp := lstCadPag[0].strCodEmp;
  LSerie_ := lstCadPag[0].strSerie;

  For I := 1 To lstCadPag.Count -1 Do
  Begin
    If (LSeqCon = lstCadPag[I].intSeqCon) And
       (LNumDup = lstCadPag[I].strNumDup) And
       (LParcel = lstCadPag[I].strParcel) And
       (LCodFor = lstCadPag[I].strCodFor) And
       (LCodEmp = lstCadPag[I].strCodEmp) And
       (LSerie_ = lstCadPag[I].strSerie)  Then
    Begin
      Result := True;
      Break;
    End;
  End;
end;

constructor TEstornoPagar.Create(Owner: TComponent;
                                 blnResCai: Boolean;
                                 strOpeRcx: String;
                                 dtaDtaCai: TDate;
                                 strCodigoCaixa: String;
                                 objResumoDeCaixa: TResumoDeCaixa);
begin
  inherited Create(Owner);
  Self.blnResCai := blnResCai;
  Self.strOpeRcx := strOpeRcx;
  Self.dtaDtaCai := dtaDtaCai;

  Self.strCodigoCaixa   := strCodigoCaixa;
  Self.objResumoDeCaixa := objResumoDeCaixa;

  lstPagMar := TList<TCadPag>.Create;
  qryCadPag := TAureliusDataset.Create(Owner);
  repCadPag := TCadPagRepository.Create;
  repCadRcx := TCadRcxxRepository.Create;
  repChqEmi := TChqEmiRepository.Create;
  repCtpDet := TCtpDetRepository.Create;
  repMovBan := TMovBanRepository.Create;
  repCadChq := TCadChqRepository.Create;
  repBanCtp := TBanCtpRepository.Create;
  repBanChq := TBanChqRepository.Create;
end;

procedure TEstornoPagar.pCarregaDados;
  Var
    objPag: TCadPag;
    lstPag: TList<TCadPag>;
    LCadPag: TCadPag;
    LCadPagAux: TCadPag;
    LListaCadPag: TList<TCadPag>;

  function fEncontraSeqBai: Boolean;
    Var
      APag: TCadPag;
  Begin
    Result := False;

    For APag in lstPag do
      If APag.intSeqBai = 0 Then
      Begin
        objPag := APag;
        Result := True;
        Break;
      End;
  End;
begin
  if Assigned(lstCadPag) Then
    pDeleteSelecion;

  {************************}
  {* ENCONTRA A DUPLICATA *}
  {*********************AF*}
  lstPag := repCadPag.fRetDuplicatasBaixadas(FNumDup, FParcel, FCodEmp, FCodFor, FSerie_, blnResCai);

  If (Not Assigned(lstPag)) Or (lstPag.Count <= 0) Then
    Raise ExceptionAutCom.Create('Não há duplicatas a serem estornadas' + IIF(blnResCai,' ou não foi baixada pelo resumo de caixa!', '!'));

  If Not fEncontraSeqBai Then
  Begin
    lstPag.Sort(repCadPag.orderSeqBaiDesc);

    objPag := lstPag[0];
  End;

  {********************************************************}
  {* CASO EXISTA SEQCON PREENCHIDO FAZ A BUSCA POR SEQCON *}
  {*****************************************************AF*}
  If objPag.intSeqCon > 0 Then
  Begin
    lstCadPag := TList<TCadPag>.Create;

    For LCadPag in lstPag do
    Begin

      If Not LCadPag.dtaDtaBai.IsNull Then
        LListaCadPag := repCadPag.fRetDuplicatasBaixadas(blnResCai, LCadPag.intSeqCon, LCadPag.strEmpBai, LCadPag.dtaDtaBai)
      Else
        LListaCadPag := repCadPag.fRetDuplicatasBaixadas(blnResCai, LCadPag.intSeqCon, LCadPag.strEmpBai);

      For LCadPagAux in LListaCadPag do
      Begin
        If (lstCadPag.IndexOf(LCadPagAux) < 0) Then
          lstCadPag.Add(LCadPagAux);
      End;

    End;


  End
  Else
  Begin
    lstCadPag := repCadPag.fRetDuplicatasBaixadas(objPag.strNumDup, objPag.strParcel,
      objPag.strCodEmp, objPag.objCodFor.FOR_CODFOR, objPag.strSerie, blnResCai);
  End;

  FBaixaDesmembradaPorModalidadePagamento := BaixaDesmembradaPorModalidadePagamento;

  qryCadPag.Close;
  qryCadPag.SetSourceList(lstCadPag);
  qryCadPag.Open;

  TFloatField(qryCadPag.FieldByName('fltValPag')).DisplayFormat := '#,##0.00';
end;

procedure TEstornoPagar.pDeleteSelecion;
Var
    objADuplic: TCadPag;
begin
  objADuplic := qryCadPag.Current<TCadPag>;

  if Not fSemMovimentoBancario(lstCadPag) then
  Begin
    If fSemVincularSeqCon(objADuplic) Then
      lstPagMar.Remove(objADuplic)
    Else
      lstPagMar.Clear;
  End
  else
  begin
    lstPagMar.Clear;
  end;
end;

function TEstornoPagar.fSemVincularSeqCon(APag: TCadPag; blnRecalcularModalidade: Boolean = True): Boolean;
Begin
  {**************************************************}
  {* AO ESTORNAR BAIXAS PARCIAIS COM OUTRAS BAIXAS, *}
  {* QUANDO O AURELIUS APAGA A DUPLICATA DA BAIXA,  *}
  {* A lstCadPag É ATUALIZADA, GERANDO LIXO NOS     *}
  {* CAMPOS DO REGISTRO APAGADO , FAZENDO COM QUE   *}
  {* FALHE ESSA VERIFICAÇÃO REQ 109262              *}
  {***********************************************AJ*}
  blnModalidade  :=  IIF(blnRecalcularModalidade,
                         fVerificaModalidadeBaixa,
                         blnModalidade);

  Result := (
              ((APag.fltDinhei <> 0) And (APag.fltOrdPag = 0) And (Not blnModalidade)) Or
              ((APag.fltDinhei = 0) And (APag.fltOrdPag <> 0) And (Not blnModalidade))
            ) And
            (APag.fltChqAvi = 0) And (APag.fltRepChq = 0) And (Not blnModalidade) and (Not FBaixaDesmembradaPorModalidadePagamento);
End;

procedure TEstornoPagar.pInsertSelecion;
  Var
    objADuplic: TCadPag;
    intSeqCon : Integer;
    strEmpBai : String;
    dtaDtaBai : TDateTime;

    {pDesmarcaConjunto}
    procedure pDesmarcaConjunto;
    Begin
      lstPagMar.Clear;
    End;

    {pInsert}
    procedure pInsert;
    Begin
      lstPagMar.Add(objADuplic);
    End;

    {fValidaMesmoRecebimento}
    function fValidaMesmoRecebimento: Boolean;
    begin
      Result := (intSeqCon = objADuplic.intSeqCon) And (strEmpBai = objADuplic.strEmpBai) And
                (dtaDtaBai = objADuplic.dtaDtaPag);
    end;

    function fVinculadoReceber: Boolean;
    var
      qryConsulta:  TUniQuery;
    begin
      qryConsulta := fCriaQuery;

      with qryConsulta do
      begin
        Sql.Clear;
        Sql.Text := 'SELECT CTR_AUTCTP FROM CADREC WHERE CTR_AUTCTP = :AUTCTP AND CTR_DTAREC IS NOT NULL';

        ParamByName('AUTCTP').AsString := objADuplic.strAutInc ;
        Open;

        Result := Not IsEmpty;

        Close;
      end;
      FreeAndNil(qryConsulta);
    end;

    {pSelecionaPrincipal}
    procedure pSelecionaPrincipal(ASemVincularSeqCon: Boolean = False);
    Begin

      If fValidaMesmoRecebimento And (objADuplic.intSeqBai = 0) Then
      Begin
        If objADuplic.strEmpBai <> VS_strCodEmp Then
        Begin
          pDesmarcaConjunto;
          Raise ExceptionAutCom.Create('Permitido apenas estornar documentos baixados pela empresa ' + VS_strCodEmp + '!' + #$A#$D +
                                       'Este documento deve ser baixado pela empresa ' + objADuplic.strEmpBai +'.');
        End;

        If fEhDuplicataOriginadaDeConverte(objADuplic.strNumDup,objADuplic.strParcel,
                                           objADuplic.strCodEmp,objADuplic.strCodFor,
                                           '',objADuplic.strSerie,'CADPAG') Then
        Begin
          pDesmarcaConjunto;
          Raise ExceptionAutCom.Create('Há duplicata(s) originada(s) de converte, portanto não será possível realizar o estorno, pois a(s) mesma(s) são somente para consultas!');
        End;

        if ASemVincularSeqCon then
        begin
          if EstaConciliado(IntToStr(objADuplic.intSeqCon), 'CADPAG', fCfgSis('CTP_AS'),
                            False, objADuplic.strEmpBai, objADuplic.strNumDup,
                            objADuplic.strParcel, Copy(objADuplic.strEmpGer, 1, 3),
                            objADuplic.strSerie,objADuplic.dtaDtaPag,objADuplic.strCodFor) then
          begin
            pDesmarcaConjunto;
            Raise ExceptionAutCom.Create('Não é possível estornar esse título, pois o mesmo está conciliado. ' +
                                         'Para ser possível estorná-lo, o mesmo deve ser desconciliado. Acessar PRINCIPAL > CONTROLE FINANCEIRO > CONCILIAÇÃO BANCÁRIA.');
          end;
        end
        else
        begin
          if EstaConciliado(IntToStr(objADuplic.intSeqCon),'CADPAG', fCfgSis('CTP_AS'), True, objADuplic.strEmpBai,'','','','',objADuplic.dtaDtaPag) then
          begin
            pDesmarcaConjunto;
            Raise ExceptionAutCom.Create('Não é possível estornar esse título, pois o mesmo está conciliado. ' +
                                         'Para ser possível estorná-lo, o mesmo deve ser desconciliado. Acessar PRINCIPAL > CONTROLE FINANCEIRO > CONCILIAÇÃO BANCÁRIA.');
          end;
        end;

        If Not fEhCadPagUsoConsumo(objADuplic) Then
          pInsert
        Else
        Begin
          pDesmarcaConjunto;
          Raise ExceptionAutCom.Create('Não é possível estornar um contas a pagar originado de um documento de Uso e Consumo!');
        End;
      End;

    End;

    {pSelecionaParcial}
    procedure pSelecionaParcial(ASemVincularSeqCon: Boolean = False);
    Begin

      If fValidaMesmoRecebimento And (objADuplic.intSeqBai <> 0) Then
      Begin

        {*******************************************}
        {* VERIFICA SE A DUPLICATA PRINCIPAL AINDA *}
        {* NAO FOI RECEBIDA OU NÃO EXISTE          *}
        {****************************************AF*}
        If fVerificaDuplicataPrincipal(objADuplic) Then
        Begin
          If objADuplic.strEmpBai <> VS_strCodEmp Then
          Begin
            pDesmarcaConjunto;
            Raise ExceptionAutCom.Create('Permitido apenas estornar documentos baixados pela empresa ' + VS_strCodEmp + '!');
          End;

          If fEhDuplicataOriginadaDeConverte(objADuplic.strNumDup,objADuplic.strParcel,
                                             objADuplic.strCodEmp,objADuplic.strCodFor,
                                             '',objADuplic.strSerie,'CADPAG') Then
          Begin
            pDesmarcaConjunto;
            Raise ExceptionAutCom.Create('Há duplicata(s) originada(s) de converte, portando não será possível realizar o estornar, pois a(s) mesma(s) são somente para consultas! ');
          End;

          {*******************************************}
          {* VERIFICA SE TEM DUPLICATA COM SEQBAI    *}
          {* MAIOR BAIXADA                           *}
          {****************************************AF*}
          If repCadPag.fTemDuplicataPosteriorBaixada(objADuplic) Then
          Begin
            pDesmarcaConjunto;
            Raise ExceptionAutCom.Create('Há duplicata(s) parciais de ' + objADuplic.strNumDup + '-' +
              objADuplic.strSerie + ', baixadas posteriormente. '+ #13#10 +
              'As duplicatas parciais devem ser estornadas a partir da última baixa.');
          End

          Else If fEhCadPagUsoConsumo(objADuplic) Then
          Begin
            pDesmarcaConjunto;
            Raise ExceptionAutCom.Create('Não é possível estornar um contas a pagar originado de um documento de Uso e Consumo!');
          End
          Else
          begin
            if ASemVincularSeqCon then
            begin
              if EstaConciliado(IntToStr(objADuplic.intSeqCon), 'CADPAG', fCfgSis('CTP_AS'),
                                False, objADuplic.strEmpBai, objADuplic.strNumDup,
                                objADuplic.strParcel, Copy(objADuplic.strEmpGer, 1, 3),
                                objADuplic.strSerie,objADuplic.dtaDtaPag) then
              begin
                pDesmarcaConjunto;
                Raise ExceptionAutCom.Create('Não é possível estornar esse título, pois o mesmo está conciliado. ' +
                                             'Para ser possível estorná-lo, o mesmo deve ser desconciliado. Acessar PRINCIPAL > CONTROLE FINANCEIRO > CONCILIAÇÃO BANCÁRIA.');
              end
              else
                pInsert;
            end
            else
            begin
              if EstaConciliado(IntToStr(objADuplic.intSeqCon),'CADPAG', fCfgSis('CTP_AS'), True, objADuplic.strEmpBai,'','','','',objADuplic.dtaDtaPag) then
              begin
                pDesmarcaConjunto;
                Raise ExceptionAutCom.Create('Não é possível estornar esse título, pois o mesmo está conciliado. ' +
                                             'Para ser possível estorná-lo, o mesmo deve ser desconciliado. Acessar PRINCIPAL > CONTROLE FINANCEIRO > CONCILIAÇÃO BANCÁRIA.');
              end
              else
                pInsert;
            end;
          end;
        End
        Else
        Begin
          pDesmarcaConjunto;
          Raise ExceptionAutCom.Create('Primeiro você deve estornar a duplicata principal de: ' +
            objADuplic.strNumDup + '-' + objADuplic.strParcel + '-' + objADuplic.strSerie + '-' +
            objADuplic.strCodEmp + '!');
        End;

      End;

    End;

begin

  If (lstPagMar.Count > 0) And (Not fSemVincularSeqCon(qryCadPag.Current<TCadPag>)) Then
    Raise ExceptionAutCom.Create('É necessário baixar uma duplicata por vez!');

  objADuplic := qryCadPag.Current<TCadPag>;

  intSeqCon := objADuplic.intSeqCon;
  strEmpBai := objADuplic.strEmpBai;
  dtaDtaBai := objADuplic.dtaDtaPag;

  if fVinculadoReceber then
    Raise ExceptionAutCom.Create('Documento vinculado a baixa do contas a receber! '+#13+'É necessário efetuar o estorno do documento original no contas a receber!');

  {*****************************************}
  {* CASO RECEBIDO                         *}
  {* APENAS EM DINHEIRO OU ORDEM DE PAG    *}
  {* PERMITE SELECIONAR APENAS UM REGISTRO *}
  {*02/10/2015***rq:41022****************AF*}
  if Not fSemMovimentoBancario(lstCadPag) then
  begin
    If fSemVincularSeqCon(objADuplic) Then
    Begin
      pSelecionaPrincipal(True);
      pSelecionaParcial(True);
      Exit;
    End;
  end;

  {********************************************}
  {* SELECIONA TODOS OS RECEBIMENTOS BAIXADOS *}
  {* JUNTO COM SEQBAI = 0 OU SEJA PRINCIPAIS  *}
  {*****************************************AF*}
  qryCadPag.First;
  While Not qryCadPag.Eof Do
  Begin
    objADuplic := qryCadPag.Current<TCadPag>;
    pSelecionaPrincipal;
    qryCadPag.Next;
  End;

  {********************************************}
  {* SELECIONA TODOS OS RECEBIMENTOS BAIXADOS *}
  {* JUNTO COM SEQBAI <> 0 OU SEJA PARCIAIS   *}
  {*****************************************AF*}
  qryCadPag.First;
  While Not qryCadPag.Eof Do
  Begin
    objADuplic := qryCadPag.Current<TCadPag>;
    pSelecionaParcial;
    qryCadPag.Next;
  End;

end;

function TEstornoPagar.fLimpaAutoIncremTarifaEntradaBoletoCadRec(strAutoIncremCTP: String): Boolean;
  Var
    qryUpdate: TUniQuery;
begin
  Try
    qryUpdate := fCriaQuery;

    qryUpdate.SQL.Text := 'SELECT * FROM CADREC WHERE CTR_CTPTXE=:AUTOIN';

    qryUpdate.ParamByName('AUTOIN').AsString := strAutoIncremCTP;
    qryUpdate.Open;

    Result := qryUpdate.RecordCount > 0;
    If Result Then
    Begin
      While Not qryUpdate.Eof Do
      Begin
        qryUpdate.Edit;
        qryUpdate.FieldByName('CTR_CTPTXE').Clear;
        qryUpdate.Post;
        untLogCtr.GravaLogCtr(qryUpdate.FieldByName('AUTOINCREM').AsString,
                              'ALTERAÇÃO ESTORNO DE TARIFA',
                              'untTEstornoPagar');

        qryUpdate.Next;
      End;
    End;

    FreeAndNil(qryUpdate);
  Except
    On E: Exception Do
      Raise Exception.Create('Ocorreu um erro ao desvincular a tarifa no Contas a Receber.' + #13 +
                             'Erro gerado: ' + E.Message);
  End;
end;

procedure TEstornoPagar.pLimparDados;
Begin
  FNumDup := '';
  FParcel := '';
  FCodEmp := '';
  FDesEmp := '';
  FDesFor := '';
  FCodFor := '';
  FSerie_ := '';

  If qryCadPag.Active Then qryCadPag.Close;
  If Assigned(lstCadPag) Then lstCadPag.Clear;
  lstPagMar.Clear;
End;

procedure TEstornoPagar.pRegravaLogBan(strSeqLanProcurar,
  strSeqLanGravacao: String);
  Var
    lstBanCtp : TList<TBanCtp>;
    lstBanChq : TList<TBanChq>;
    objBanCtpOri : TBanCtp;
    objBanChqOri : TBanChq;
    objBanCtp : TBanCtp;
    objBanChq : TBanChq;
begin
  lstBanCtp := repBanCtp.fRetDocumentos<TBanCtp>(strSeqLanProcurar);

  For objBanCtpOri In lstBanCtp Do
  Begin
    objBanCtp := TBanCtp.Create;
    objBanCtp.strNumDup := objBanCtpOri.strNumDup;
    objBanCtp.strParcel := objBanCtpOri.strParcel;
    objBanCtp.strSerie_ := objBanCtpOri.strSerie_;
    objBanCtp.strCodEmp := objBanCtpOri.strCodEmp;
    objBanCtp.intSeqBai := objBanCtpOri.intSeqBai;
    objBanCtp.strCodFor := objBanCtpOri.strCodFor;
    objBanCtp.strHist01 := objBanCtpOri.strHist01;
    objBanCtp.strHist02 := objBanCtpOri.strHist02;
    objBanCtp.fltValPag := objBanCtpOri.fltValPag;
    objBanCtp.strCodCta := objBanCtpOri.strCodCta;
    objBanCtp.strEmpCta := objBanCtpOri.strEmpCta;
    objBanCtp.fltDinhei := objBanCtpOri.fltDinhei;
    objBanCtp.fltChqEmi := objBanCtpOri.fltChqEmi;
    objBanCtp.fltChqRep := objBanCtpOri.fltChqRep;
    objBanCtp.fltOrdPag := objBanCtpOri.fltOrdPag;
    objBanCtp.fltValJur := objBanCtpOri.fltValJur;
    objBanCtp.fltValDes := objBanCtpOri.fltValDes;
    objBanCtp.fltValPri := objBanCtpOri.fltValPri;

    TGravaLogBan.fGravaLogBan(objBanCtp, VS_strCodEmp, strSeqLanGravacao);
  End;

  lstBanChq := repBanChq.fRetDocumentos<TBanChq>(strSeqLanProcurar);

  For objBanChqOri In lstBanChq Do
  Begin
    objBanChq := TBanChq.Create;
    objBanChq.strCodBco := objBanChqOri.strCodBco;
    objBanChq.strNumAge := objBanChqOri.strNumAge;
    objBanChq.strConCor := objBanChqOri.strConCor;
    objBanChq.strNumChq := objBanChqOri.strNumChq;
    objBanChq.strCodCli := objBanChqOri.strCodCli;
    objBanChq.strNomEmi := objBanChqOri.strNomEmi;
    objBanChq.fltValChq := objBanChqOri.fltValChq;
    objBanChq.strHist01 := objBanChqOri.strHist01;
    objBanChq.strHist02 := objBanChqOri.strHist02;
    objBanChq.strCodEmp := objBanChqOri.strCodEmp;
    objBanChq.strCodFor := objBanChqOri.strCodFor;

    TGravaLogBan.fGravaLogBan(objBanChq, VS_strCodEmp, strSeqLanGravacao);
  End;
end;

function TEstornoPagar.fDuplicataPrincipalBaixada(ADup: TCadPag): Boolean;
  Var
    strMsg: String;
    objDup: TCadPag;
Begin
  objDup := repCadPag.fRetDuplicata(ADup.strNumDup, ADup.strParcel, 0, ADup.strCodEmp, ADup.objCodFor.FOR_CODFOR, ADup.strSerie);

  If Not Assigned(objDup) Then
  Begin
    strMsg := 'Estorno não permitido, pois a duplicata principal da duplicata ' + #13#10 +
              '(' + ADup.strNumDup + ADup.strParcel + '-' + ADup.strSerie + '-' + ADup.strCodEmp + '-' + fValN(ADup.objCodFor.FOR_CODFOR) + ') não ' +
              ' foi encontrada.';
    Raise ExceptionAutcom.Create(strMsg);
  End;

  Result := (objDup.dtaDtaPag.HasValue);

  If result Then
  Begin
     If (ADup.intSeqCon = objDup.intSeqCon) Then
        Result := False;
  End;
End;

function TEstornoPagar.fVerificaDuplicataPrincipal(ADup: TCadPag): Boolean;
begin
  If ADup.intSeqBai = 0 Then Result := True
  Else Result := Not fDuplicataPrincipalBaixada(ADup);
end;

function TEstornoPagar.fVerificaModalidadeBaixa(
  ADatasetEstorno: TDataset): Boolean;
  Var
    LValorCheque,
    LValorOrdemPagamento,
    LValorChequeRepasse,
    LValorDinheiro: Double;
begin
  Result := False;

  If FBaixaDesmembradaPorModalidadePagamento Then
    Exit;

  LValorCheque := 0;
  LValorOrdemPagamento := 0;
  LValorChequeRepasse := 0;
  LValorDinheiro := 0;

  ADatasetEstorno.First;
  While Not ADatasetEstorno.Eof Do
  Begin
    If IfNull(ADatasetEstorno.FieldByName('CTP_REPCHQ').Value, 0) > 0 Then
      LValorChequeRepasse := LValorChequeRepasse +
                             ADatasetEstorno.FieldByName('CTP_REPCHQ').AsFloat;

    If IfNull(ADatasetEstorno.FieldByName('CTP_CHQAVI').Value, 0) > 0 Then
      LValorCheque := LValorCheque +
                      ADatasetEstorno.FieldByName('CTP_CHQAVI').AsFloat;

    If IfNull(ADatasetEstorno.FieldByName('CTP_ORDPAG').Value, 0) > 0 Then
      LValorOrdemPagamento := LValorOrdemPagamento +
                              ADatasetEstorno.FieldByName('CTP_ORDPAG').AsFloat;

    If IfNull(ADatasetEstorno.FieldByName('CTP_VALORI').Value, 0) < 0 Then
    Begin
      If IfNull(ADatasetEstorno.FieldByName('CTP_DINHEI').Value, 0) < 0 Then
        LValorDinheiro := LValorDinheiro +
                          ADatasetEstorno.FieldByName('CTP_DINHEI').AsFloat;
    End;

    ADatasetEstorno.Next;
  End;

  If fFormataFloat(LValorCheque + LValorChequeRepasse, 2) <> 0 Then
    Exit(True);

  If fFormataFloat(LValorOrdemPagamento, 2) <> 0 Then
    Exit(fFormataFloat(LValorDinheiro, 2) <> 0);
end;

{***************************************************************}
{* ESTA FUNÇÃO VERIFICA SE EXISTEM CONTAS BAIXADAS COM O MESMO *}
{* (CTP_SEQCON + CTP_EMPBAI) COM DATAS DIFERENTES. SE HOUVER,  *}
{* NÃO DEIXA ESTORNAR A DUPLICATA E EXIBE MENSAGEM.            *}
{************************************************************AF*}
function TEstornoPagar.fVerificaDatasDiferentes(ADup: TCadPag): Boolean;
  Var
    stl: TStringList;
    pag: TCadPag;
    strDta: String;

    function fExiste(str: String): Boolean;
      Var
        i: Integer;
    Begin
      Result := False;

      For i := 0 To stl.Count -1 Do
      Begin
        If stl[i] = str Then
        Begin
          Result := True;
          Break;
        End;
      End;

    End;

begin

  If ADup.intSeqCon <= 0 Then
  Begin
    Result := True;
    Exit;
  End;

  stl := TStringList.Create;
  stl.Duplicates := dupIgnore;

  For pag in repCadPag.fRetDuplicatas(False, ADup.intSeqCon, ADup.strEmpBai) Do
  Begin
    If Not qryCadPag.Locate('strAutInc', pag.strAutInc, []) Then
      Continue;

    If pag.dtaDtaBai.IsNull Then
    Begin
      stl.Clear;

      Break;
    End;

    strDta := FormatDateTime('dd/mm/yyyy', pag.dtaDtaBai);

    If Not fExiste(strDta) Then
      stl.Add(strDta);
  End;

  Result := (stl.Count = 1);

  If Not Result Then
    pMensagemOk('Não é possível estornar esta Duplicata!' + #13 +
                'Entre em contato com a Citel Software pois existem' + #13 +
                'configurações a serem feitas antes da realização do estorno!' +#13 + #13 +
                'Código SeqCon: ' + IntToStr(ADup.intSeqCon) + '-' + ADup.strEmpBai + '-' + ADup.strDtaPag);

  FreeAndNil(stl);
end;

function TEstornoPagar.fVerificaDatasDiferentesRcx(ADup: TCadPag): Boolean;
var
  stl: TStringList;
  objCadRcxx: TCadRcxx;
  strDta: String;
begin
  If ADup.intRcxCon <= 0 Then
  Begin
    Result := True;
    Exit;
  End;

  If Not ((ADup.intRescai = 1) And (ADup.dtaDtaPag = dtaDtaCai)) Then
  Begin
    Result := True;
    Exit;
  End;

  stl := TStringList.Create;
  Try
    stl.Duplicates := dupIgnore;

    For objCadRcxx in repCadRcx.fRetRegistros(ADup.intRcxCon, ADup.strEmpBai) Do
    Begin
      strDta := FormatDateTime('dd/mm/yyyy', objCadRcxx.dtaDtaCad);

      If Not stl.IndexOf(strDta) > -1 Then
        stl.Add(strDta);
    End;

    Result := (stl.Count = 1);

    If Not Result Then
      pMensagemOk('Não é possível estornar esta Duplicata!' + #13 +
                  'Entre em contato com a Citel Software pois existem' + #13 +
                  'configurações a serem feitas antes da realização do estorno!' +#13 + #13 +
                  'Código RcxCon: ' + IntToStr(ADup.intRcxCon) + '-' + ADup.strEmpBai + '-' + ADup.strDtaPag);
  Finally
    FreeAndNil(stl);
  End;
end;

function TEstornoPagar.fEhCadPagUsoConsumo(ADup: TCadPag): Boolean;
Begin

  Result := (Not fEmptyStr(ADup.strUsoCli)) And (Not fEmptyStr(ADup.strUsoDoc)) And
            (Not fEmptyStr(ADup.strUsoEsp)) And (Not fEmptyStr(ADup.strUsoEmp)) And
            (ADup.fltValori > 0);

End;

{*******************************************}
{* REALIZA VALIDAÇÕES ANTES DA CONFIRMAÇÃO *}
{****************************************AF*}
procedure TEstornoPagar.pValidationBeforeConfirm;
  Var
    ADuplic: TCadPag;
    I: Integer;
begin
  Try
    For I := 0 To lstPagMar.Count -1 Do
    Begin
      ADuplic := lstPagMar.Items[I];

      {***************************************}
      {* APENAS PARA VERIFICAR SE EXISTE A   *}
      {* DUPLICATA PRINCIPAL CASO NÃO EXISTA *}
      {* RETORNA RAISE EXCEPTIONAUTCOM       *}
      {************************************AF*}
      fDuplicataPrincipalBaixada(ADuplic);

      fDupJaEstornada(ADuplic);


      pDefineEhUmPG(ADuplic);
      If ADuplic.blnEhUmPG Then
        pMensagemOk('Duplicata proveniente de caixa! Portanto ela será excluída!');
    End;

  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;

end;

function TEstornoPagar.RetornaAutoIncremsDuplicata: String;
  Var
    LDuplicata: TCadPag;
begin
  Result := EmptyStr;

  If Not Assigned(lstCadPag) Then
    Exit;

  If lstCadPag.Count = 0 THen
    Exit;

  For LDuplicata In lstCadPag Do
    Result := Result + LDuplicata.strAutInc + '_';
end;

function TEstornoPagar.fEstornaDuplicataConjugadas(strChamada: String = ''): Boolean;
  Var
    blnEstDtaDoc: Boolean;
    blnGravaCaix: Boolean;
    blnGravaMovB: Boolean;
    blnMovBanAna: Boolean;
    intSeqCon   : Integer;
    intCtbSeqCon: Integer;
    strEmpBai   : String;
    intSeqRCH   : Integer;
    strEmpRCH   : String;
    intCont     : Integer;
    strMotEst   : String;
    objRcx      : TCadRcxx;
    lstMovBan   : TList<TMovBan>;
    blnSemMovBan  : Boolean;
    blnEhdoCaixa: Boolean;
    blnBaixaZeradaCTP: Boolean;
    QtdPagamenentoAntecipado: Integer;
    QtdSemPagamenentoAntecipado: Integer;
    blnEstornoDeDebitoComPagamentoAntecipado: Boolean;
    lTabelaPgoAntecipado : String;
    blnPagamentoAntecipado: Boolean;
    intTipDtaEstBai  : Integer;


  function fVaiGravarCaixa: Boolean;
  begin
    Result := (blnGravaCaix) OR
              ((blnEhdoCaixa) And
              (not (blnGravaMovB)) and
               (lstPagMar[0].dtaDtaPag <> dtaDtaCai) And
               (Not lstPagMar[0].blnEhUmPG) And
               (Not FblnFechadoCaixa) And
               (Not (blnMovBanAna And (lstPagMar[0].dtaDtaPag <> dtaDtaCai)))
              );
  end;

begin
  Result := False;
  objFechamento := TFechamentoFinanceiro.Create(Nil, 'untTEstornoPagar');

  strMotEst := '';
  If fCfgSis('PMOTES', varBoolean) Then
  begin
     Try
      pCriarFormularios(TfrmDigOcorrencia, frmDigOcorrencia);

      If (frmDigOcorrencia.ShowModal = mrOk) Then
      Begin
        strMotEst := (frmDigOcorrencia.strCodOco);
      End;
    Finally
      FreeAndNil(frmDigOcorrencia);
    End;

    if strMotEst = '' then
    begin
      pMensagemOk('O código da ocorrência do estorno, deve ser preenchido!');
      Exit;
    end;
  end;

  Try
    objRcx       := Nil;

    intSeqCon    := 0;
    intCtbSeqCon := 0;
    strEmpBai    := '';
    strEmpRCH    := '';

    pValidationBeforeConfirm;

    If DuplicataBaixadaPeloCaixaECaixaDoDiaFechado Then
      Exit;


    If Not fVerificaAcessoSistema('DTAOEP') Then
    Begin
       pMensagemOk('Operador sem acesso a "Estorno com Data do Dia do Estorno" e "Estorno com Data do Dia da Baixa". Por favor, verifique os direitos de acesso.');
       Exit;
    End;

    Case fCfgSis('RDTEMB', varInteger) of
      1: blnEstDtaDoc := (fTipDtaEstBai(fVerificaAcessoSistema('DTAOEP')) = 2);
      2: blnEstDtaDoc := True;    // Data Documento;
      3: blnEstDtaDoc := False;   // Data Atual;
    Else
      Begin

        intTipDtaEstBai := fTipDtaEstBai(fVerificaAcessoSistema('DTAOEP'));
        If (intTipDtaEstBai = 2) Then
          blnEstDtaDoc := True
        Else If (intTipDtaEstBai = 1) Then
          blnEstDtaDoc := False
        Else
        Begin
          pMensagemOk('Operador sem acesso a "Estorno com Data do Dia do Estorno" e "Estorno com Data do Dia da Baixa". Por favor, verifique os direitos de acesso.');
          Exit;
        End;
      End;
    End;

    //FECHAMENTO FINANCEIRO
    //VERIFICA A DATA DA BAIXA DO DOCUMENTO, CASO ESCOLHIDA
    if blnEstDtaDoc then
    begin
      if objFechamento.FechamentoFinanceiroJaRealizado(lstPagMar[0].strCodEmp, lstPagMar[0].dtaDtaPag) then
      begin
        Result := False;
        Exit;
      end;
    end;

    blnGravaCaix := (lstPagMar[0].intRescai = 1) And
                    (lstPagMar[0].intRcxCon > 0) And
                    (lstPagMar[0].dtaDtaPag = dtaDtaCai) And
                    (Not lstPagMar[0].blnEhUmPG) And
                    (Not FblnFechadoCaixa);

    {*********************************************************************}
    {* VERIFICANDO SE A DUPLICATA É DO CAIXA SEM OLHAR DATA DE PAGAMENTO *}
    {*REQ*128987*******************************************************MO*}
    blnEhdoCaixa := (lstPagMar[0].intRescai = 1) And
                    (lstPagMar[0].intRcxCon > 0) And
                    (Not lstPagMar[0].blnEhUmPG);

    blnGravaMovB := False;
    blnMovBanAna := False;

    intSeqRCH := lstPagMar[0].intSeqRCH;
    strEmpRCH := lstPagMar[0].strEmpBai.Value;

    blnSemMovBan := fSemMovimentoBancario(lstPagMar);

    blnBaixaZeradaCTP := fEhBaixaZeradaCTP(lstPagMar);

    If fCfgSis('CTP_AS') = 'S' Then
    Begin
      blnGravaMovB :=((((lstPagMar[0].intRescai = 0) And (Not blnSemMovBan))Or
                     (((lstPagMar[0].intRescai <> 0) And (fCfgSis('CTBPAG', varBoolean)))
                      And (Not blnSemMovBan)))
                      And (Not fSemVincularSeqCon(lstPagMar[0]))) Or
                      blnBaixaZeradaCTP;

      intCtbSeqCon := lstPagMar[0].intSeqCon;
      strEmpBai    := lstPagMar[0].strEmpBai;
    End;

    fStartTransaction;
    QtdPagamenentoAntecipado := 0;
    QtdSemPagamenentoAntecipado := 0;
    For intCont := 0 To lstPagMar.Count-1 Do
    Begin
      if strMotEst <> '' then
         lstPagMar[intCont].strMotEst := strMotEst;

      {*****************************************}
      {* VERIFICA SE É UM PG GERADO PELO CAIXA *}
      {* SE FOR O REGISTRO DEVE SER APAGADO    *}
      {**************************************AF*}
      If lstPagMar[intCont].blnEhUmPG Then
        pEstornaDuplicataResumoCaixa(lstPagMar[intCont], blnEstDtaDoc)

      Else
      Begin
        If fTemPgoGer(lstPagMar[intCont], lTabelaPgoAntecipado) then
          Inc(QtdPagamenentoAntecipado)
        Else
          Inc(QtdSemPagamenentoAntecipado);

        {*****************************************}
        {* GRAVA MOVBAN ANALÍTICO                *}
        {**************************************AF*}
        If (lstPagMar[intCont].intRescai = 0) Or
          ((lstPagMar[intCont].intRescai <> 0) And (fCfgSis('CTBPAG', varBoolean))) Then
        Begin
          If (fCfgSis('CTP_AS') <> 'S') Or (fSemVincularSeqCon(lstPagMar[intCont], False)) Then
          Begin
            If Not fTemPgoGer(lstPagMar[intCont], strTabelaPgoAntecipado) Then
              pGravaMovBan(lstPagMar[intCont], blnEstDtaDoc);
            blnMovBanAna := True;
          End;
        End;

        {************************************************************************************************}
        {* PREPARA GRAVAÇÃO DO CAIXA CASO SEJA O MESMO DIA DO PAGAMENTO OU QUANDO NÃO GRAVA MOVBAN, *****}
        {* E A DATA DE PAGAMENTO É DIFERENTE DA DATA DO CAIXA E NÃO É UM TITULO DE ESPÉCIE 'PG' *********}
        {*REQ*128987**********************************************************************************MO*}
        If fVaiGravarCaixa and (Not fTemPgoGer(lstPagMar[intCont], lTabelaPgoAntecipado)) Then
        Begin
          If Not Assigned(objRcx) Then
            objRcx := TCadRcxx.Create;

          intSeqCon := lstPagMar[intCont].intRcxCon;
          objRcx.fltValDoc.Value := objRcx.fltValDoc.Value + (lstPagMar[intCont].fltValPag);
          objRcx.strIdeCai := '1';
            {**Req. 97805**23/04/2018**WS**}
          objRcx.strNumDoc := IfThen(lstPagMar.Count > 1, 'Diversos', lstPagMar[intCont].strNumDup);
          objRcx.strParcel := IfThen(lstPagMar.Count > 1, '', lstPagMar[intCont].strParcel);

          objRcx.strDescri := 'REF.ESTORNO ' +  lstPagMar[intCont].strNumDup + '-' + lstPagMar[intCont].strParcel + '-' +
                              VS_strCodEmp + '-' + fValN(lstPagMar[intCont].objCodFor.FOR_CODFOR);
        End;

        {******************************}
        {* ESTORNA SIMPLES OU PARCIAL *}
        {***************************AF*}
        blnPagamentoAntecipado := fTemPgoGer(lstPagMar[intCont], strTabelaPgoAntecipado);
        If blnPagamentoAntecipado Then
          pRelancaPagamentoAntecipado(lstPagMar[intCont]);

        If (lstPagMar[intCont].intSeqBai = 0) Then
          pEstornaDuplicataSimples(lstPagMar[intCont], strChamada, blnPagamentoAntecipado)
        Else
          pEstornaDuplicataParcial(lstPagMar[intCont], strChamada, blnPagamentoAntecipado);

      End;

    End;

    blnEstornoDeDebitoComPagamentoAntecipado := QtdPagamenentoAntecipado > 0;
    If (QtdPagamenentoAntecipado > 0) And (QtdSemPagamenentoAntecipado > 0) then
      Raise ExceptionAutcom.Create('Não é possível estornar duplicatas com pagamento antecipado junto com duplicatas sem pagamento antecipado!');


    {*****************************************}
    {* GRAVA MOVBAN SINTÉTICO                *}
    {**************************************AF*}
    If (fCfgSis('CTP_AS') = 'S') And (blnGravaMovB) and (Not blnEstornoDeDebitoComPagamentoAntecipado) Then
    Begin
      lstMovBan := repMovBan.fRetDocumentos(intCtbSeqCon, strEmpBai);

      If Assigned(lstMovBan) And (lstMovBan.Count > 0) Then
        pGravaMovBan(lstMovBan, blnEstDtaDoc)
      Else
      Begin
        Raise ExceptionAutcom.Create('Não foi possível gravar o movimento bancário contra-partida, pois o sequencial abaixo não foi encontrado: ' + Chr(13) +
                                     'SEQCON: ' + IntToStr(intCtbSeqCon) + Chr(13) +
                                     'EMPBAI: ' + strEmpBai + Chr(13) +
                                     'Ligue imediatamente para a Citel.');
      End;
    End;

    If (intSeqRCH > 0)  and (Not blnEstornoDeDebitoComPagamentoAntecipado)Then
      repCadChq.pEstornaRepasseCheques(intSeqRCH, strEmpRCH);

    {****************************************************************************************}
    {* GRAVA LC NO CAIXA CASO SEJA O MESMO DIA DO PAGAMENTO OU QUANDO NÃO GRAVA MOVBAN, *****}
    {* E A DATA DE PAGAMENTO É DIFERENTE DA DATA DO CAIXA E NÃO É UM TITULO DE ESPÉCIE 'PG' *}
    {*REQ*128987**************************************************************************MO*}
    If fVaiGravarCaixa and  (Not blnEstornoDeDebitoComPagamentoAntecipado) Then
    Begin
      pDeterminaModalidadeEstorno(intSeqCon, objRcx);

      If objRcx.fltDinRec < 0 Then objRcx.fltDinRec := -objRcx.fltDinRec.Value;
      If objRcx.fltCarRec < 0 Then objRcx.fltCarRec := -objRcx.fltCarRec.Value;
      If objRcx.fltChqAvi < 0 Then objRcx.fltChqAvi := -objRcx.fltChqAvi.Value;
      If objRcx.fltChqPre < 0 Then objRcx.fltChqPre := -objRcx.fltChqPre.Value;
      If objRcx.fltOrdRec < 0 Then objRcx.fltOrdRec := -objRcx.fltOrdRec.Value;

      If objRcx.fltDinRec > 0 Then
        objRcx.fltDinRec := objRcx.fltValDoc;
      If objRcx.fltOrdRec > 0 Then
        objRcx.fltOrdRec := objRcx.fltValDoc;

      objRcx.intSqFcRx := StrToInt(fCfgSisL('SQFCRX'));
      objRcx.intSeqCon := StrToInt(fRetRcxCon);
      objRcx.strCodOpe := strOpeRcx;
      objRcx.strEspDoc := 'LC';
      objRcx.strCodEmp := VS_strCodEmp;
      objRcx.strEmpDup := VS_strCodEmp;
      objRcx.dtaDtaCad := dtaDtaCai;
      objRcx.dtaHorCad := fTime();
      objRcx.dtaDtaGrv := fCampoTabela('CURRENT_TIMESTAMP', 'DUAL', [],[]);
      objRcx.strLanFec := 'N';

      If Not strCodigoCaixa.IsEmpty Then
        objRcx.strCodCax := strCodigoCaixa;

      if strMotEst <> '' then
        objRcx.strMotEst := strMotEst;

      If Not fGravaCadRcx(objRcx) Then
      Begin
        Raise ExceptionAutcom.Create('Não foi possível gravar resumo de caixa!');
      End;
    End;

    fCommit;

    pMensagemOk('Duplicata(s) estornada(s) com sucesso!');
    Result := True;

  Except
    On E: ExceptionAutcom Do
    Begin
      fRollBack;
      pMensagemOk(E.Message);
    End;

    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro('Erro ao tentar estornar duplicatas:' + #13 + E.Message, '[pEstornaDuplicataConjug]');
    End;
  End;

end;

destructor TEstornoPagar.Destroy;
begin
  FreeAndNil(repCadPag);
  FreeAndNil(repCadRcx);
  FreeAndNil(repChqEmi);
  FreeAndNil(repCtpDet);
  FreeAndNil(repMovBan);
  FreeAndNil(repCadChq);
  FreeAndNil(repBanCtp);
  FreeAndNil(repBanChq);
  inherited;
end;

function TEstornoPagar.DuplicataBaixadaPeloCaixaECaixaDoDiaFechado: Boolean;
  Var
    LUltimoFechamento: TDateTime;

    LSaldoFechamento: Double;
    LResumoCaixa : TResumoDeCaixa;
begin
  Result := False;

  LResumoCaixa := TResumoDeCaixa.Create;
  try
    Try
      If lstPagMar[0].intRescai <> 1 Then
        Exit(False);

      If fCfgSis('TPFCCX') = 'C' Then
        Exit(False);

      LResumoCaixa.fRetornaUltimoFechamento(LSaldoFechamento,
                                            LUltimoFechamento,
                                            '',
                                            VS_strCodEmp);

      If LUltimoFechamento < VS_Date Then
        Exit(False);

      Result := lstPagMar[0].dtaDtaPag = LUltimoFechamento;
      If Result Then
        fMensagem('ATENÇÃO', 'O estorno não pode ser realizado pois, a(s) duplicata(s) foi(ram) baixada(s) pelo caixa hoje,' +
                             ' porém já foi fechado.' + #13 + #13 + 'Cancele o fechamento do caixa ou realize o estorno no dia posterior.', ['&Ok']);
    Except
      On E: ExceptionAutCom Do
        Raise ExceptionAutCom.Create(E.Message);

      On E: Exception Do
        Raise Exception.Create(E.Message);
    End;
  finally
    if Assigned(LResumoCaixa) then
      FreeAndNil(LResumoCaixa);
  end;
end;

function TEstornoPagar.fDupJaEstornada(ADup: TCadPag): Boolean;
  Var
    objDup: TCadPag;
Begin

  Try
    objDup := repCadPag.fRetDuplicataBaixada(ADup, False);

    If Not Assigned(objDup) Then
    Begin
      Raise ExceptionAutCom('Duplicata: ' + ADup.strNumDup + ADup.strParcel + '-' + ADup.strSerie + '-' + ADup.strCodEmp + '-' +
        ADup.strDtaCad + ' encontra-se em aberto, possívelmente já foi estornado em outra estação, carregue os dados novamente.');
    End
    Else
      Result := False;

  Except
    On E: ExceptionAutCom Do
      Raise ExceptionAutCom.Create(E.Message);

    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;

End;

procedure TEstornoPagar.pEstornaDuplicataResumoCaixa(ADup: TCadPag; blnEstDtaDoc: Boolean);
  Var
    objCadRcx: TCadRcxx;

    LGravarCaixa: Boolean;
    LQryCadPag: TUniQuery;
    LDataPagamento : TDate;
    LDiasTolerancia : Integer;
    LSadoUltimoFechamento: Double;
    LDataUltimoFechamento: TDateTime;
    LDentroToleranciaEstorno : Boolean;
    LCaixaFechado : Boolean;
begin

  LQryCadPag := nil;
  LGravarCaixa := False;
  try
    Try
      frwk.objDBManager.Refresh(ADup);

      LQryCadPag := fCriarQuery('SELECT * FROM CADPAG WHERE AUTOINCREM = ' + ADup.strAutInc.QuotedString,Nil);
      LQryCadPag.Open;
      fVerificaIntegridade('pEstornaDuplicataResumoCaixa','CADPAG',LQryCadPag);
      FreeAndNil(LQryCadPag);

      pDeletaChqEmi(ADup);

      LCaixaFechado := FblnFechadoCaixa;
      If fCfgSis('TPFCCX') <> 'C' Then
      begin
        objResumoDeCaixa.fRetornaUltimoFechamento(LSadoUltimoFechamento,
                                                  LDataUltimoFechamento,
                                                  strCodigoCaixa,
                                                  ADup.strEmpBai);

        LCaixaFechado := ((Trunc(LDataUltimoFechamento) = Trunc(VS_Date)) or (LDataUltimoFechamento >= dtaDtaCai));
      end;

      LDiasTolerancia := fCfgSis('TOLEST', varInteger);
      LDataPagamento := ADup.dtaDtaPag;

      LDentroToleranciaEstorno := False;
      if LDiasTolerancia > 0 then
        LDentroToleranciaEstorno := (Abs(dtaDtaCai - LDataPagamento) <= LDiasTolerancia);

      LGravarCaixa := ADup.dtaDtaPag = dtaDtaCai;
      If LGravarCaixa Then
        LGravarCaixa := Not LCaixaFechado;

      If Not LGravarCaixa Then
        LGravarCaixa := (Not fCfgSis('CTBPAG', varBoolean) and LDentroToleranciaEstorno);

      {****************}
      {* GRAVA MOVBAN *}
      {*************AF*}
      If fCfgSis('CTBPAG', varBoolean) Then
        pGravaMovBan(ADup, blnEstDtaDoc, True);

      {*******************************}
      {* GRAVA LC NO CAIXA CASO SEJA *}
      {* O MESMO DIA DO PAGAMENTO    *}
      {****************************AF*}
      If LGravarCaixa Then
      Begin
        objCadRcx := TCadRcxx.Create;

        objCadRcx.fltValDoc := (ADup.fltValPag - ADup.fltValJur + ADup.fltValDes);

        pDeterminaModalidadeEstorno(ADup.intRcxCon, objCadRcx);

        If objCadRcx.fltDinRec < 0 Then objCadRcx.fltDinRec := -objCadRcx.fltDinRec.Value;
        If objCadRcx.fltCarRec < 0 Then objCadRcx.fltCarRec := -objCadRcx.fltCarRec.Value;
        If objCadRcx.fltChqAvi < 0 Then objCadRcx.fltChqAvi := -objCadRcx.fltChqAvi.Value;
        If objCadRcx.fltChqPre < 0 Then objCadRcx.fltChqPre := -objCadRcx.fltChqPre.Value;
        If objCadRcx.fltOrdRec < 0 Then objCadRcx.fltOrdRec := -objCadRcx.fltOrdRec.Value;

        objCadRcx.strIdeCai := '1';
        objCadRcx.intSqFcRx := StrToInt(fCfgSisL('SQFCRX'));
        objCadRcx.intSeqCon := StrToInt(fRetRcxCon);
        objCadRcx.strCodOpe := strOpeRcx;
        objCadRcx.strNumDoc := ADup.strNumDup;
        objCadRcx.strParcel := ADup.strParcel; {**Req. 97805**20/04/2018**WS**}
        objCadRcx.strNumDup := ADup.strNumDup; {**Req. 97805**20/04/2018**WS**}
        objCadRcx.strEspDoc := 'LC';
        objCadRcx.strCodEmp := VS_strCodEmp;
        objCadRcx.strEmpDup := VS_strCodEmp;
        objCadRcx.dtaDtaCad := dtaDtaCai;
        objCadRcx.dtaHorCad := fTime();
        objCadRcx.dtaDtaGrv := fCampoTabela('CURRENT_TIMESTAMP', 'DUAL', [],[]);
        objCadRcx.strLanFec := 'N';

        If Not strCodigoCaixa.IsEmpty Then
          objCadRcx.strCodCax := strCodigoCaixa;

        if ADup.strMotEst <> '' then
           objCadRcx.strMotEst := ADup.strMotEst;

        objCadRcx.strDescri := 'REF.ESTORNO PG ' +  ADup.strNumDup + '-' + ADup.strParcel + '-' +
                               VS_strCodEmp + '-' + fValN(ADup.objCodFor.FOR_CODFOR);

        If Not fGravaCadRcx(objCadRcx) Then
          Raise ExceptionAutcom.Create('Não foi possível gravar resumo de caixa!');

      End
      Else if Not fCfgSis('CTBPAG', varBoolean) then
      begin
        pGravaMovBan(ADup, blnEstDtaDoc, True);
      end;

      untLogCtp.GravaLogCtp(ADup.strAutInc,
                            'ESTORNO CONTAS A PAGAR [pEstornaDuplicataResumoCaixa]',
                            IIF(Trim(Self.Name).IsEmpty, 'TEstornoPagar', Self.Name));

      pGravaLogExclusaoPG(ADup);

      repCadPag.pDeletar(ADup);

    Except
      On E: ExceptionAutcom Do
        Raise ExceptionAutcom.Create(E.Message);

      On E: Exception Do
        Raise Exception.Create(E.Message);
    End;
  finally
    if Assigned(LQryCadPag) then
      FreeAndNil(LQryCadPag);

    If LGravarCaixa Then
    begin
      if Assigned(objCadRcx) then
        FreeAndNil(objCadRcx);
    end;
  end;

End;

procedure TEstornoPagar.pDefineEhUmPG(ADup: TCadPag);

  function fEspecieRcx(intSeqCon: Integer; strCodEmp: String): String;
    Var
      ARcx: TCadRcxx;
  Begin
    ARcx := repCadRcx.fRetRegistros(intSeqCon, strCodEmp)[0];
    Result := ARcx.strEspDoc;
  End;

begin
  ADup.blnEhUmPG := (ADup.intRcxCon > 0) And
                    (ADup.intRescai > 0) And
                    (fEspecieRcx(ADup.intRcxCon, ADup.strEmpBai) = 'PG');
end;

procedure TEstornoPagar.pDeletaChqEmi(ADup: TCadPag);
  Var
    lstChqEmi: TList<TChqEmi>;
    intCon: Integer;
Begin
  lstChqEmi := repChqEmi.fRetCheques(ADup.objCodFor.FOR_CODFOR, ADup.strNumDup, ADup.strParcel,
                                     ADup.strCodEmp, ADup.strSerie, ADup.intSeqBai);

  If Assigned(lstChqEmi) And (lstChqEmi.Count > 0) Then
  Begin
    For intCon := 0 To lstChqEmi.Count-1 Do
      repChqEmi.pDeletaChqEmi(lstChqEmi[intCon]);
  End;

End;

procedure TEstornoPagar.pEstornaDuplicataSimples(ADup: TCadPag; strChamada: String = ''; blnPagamentoAntecipado: Boolean = False);
  Var
    blnApagaCadPagTarifaBancaria: Boolean;
begin

  Try
    pDeletaChqEmi(ADup);
    {*****************************************************}
    {* LIMPANDO A ORIGEM DO REGISTRO PRINCIPAL DA MOVBAN *}
    {*REQ*155872***************************************MO*}
    If not blnPagamentoAntecipado then
    If (ADup.intRescai = 0) Or
       ((ADup.intRescai <> 0) And (fCfgSis('CTBPAG', varBoolean))) Then
      repMovBan.pLimparOrigemPrincipal(ADup);

    blnApagaCadPagTarifaBancaria := fLimpaAutoIncremTarifaEntradaBoletoCadRec(ADup.strAutInc);
    repCadPag.pEstornaDuplicataSimples(ADup, 'untTEstornoPagar ' + strChamada);

    If blnApagaCadPagTarifaBancaria Then
    Begin
      untLogCtp.GravaLogCtp(ADup.strAutInc,
                            'EXCLUSÃO CONTAS A PAGAR DE TARIFA [pEstornaDuplicataSimples]',
                            'untTEstornoPagar');

      repCadPag.pGravaDelCadPag(ADup, Self.Name);
      repCadPag.pDeletar(ADup);
    End;
  Except
    On E: ExceptionAutcom Do
      Raise ExceptionAutcom.Create(E.Message);

    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;

end;

{*************************************************************}
{* PROCEDIMENTO QUE CHAMA A GRAVAÇÃO DO MOVBAN POR DUPLICATA *}
{*REQ. 36383 18/06/2015************************************JU*}
procedure TEstornoPagar.pGravaMovBan(ADup: TCadPag; blnEstDtaDoc: Boolean; blnEstornoPG: Boolean = False);
  Var
    lstCtpDet: TList<TCtpDet>;
    objMov   : TMovBan;
    objBanCtp: TBanCtp;
    strSeqLan: String;
    lstBanChq : TList<TBanChq>;
    objBanChqOri : TBanChq;
    objBanChq : TBanChq;
begin

  If not ADup.strPorBai.HasValue Then
    Exit;

  lstCtpDet := Nil;

  {***************************}
  {* RETORNA DESMEMBRAMENTOS *}
  {************************JU*}
  If Not blnEstornoPG Then
  Begin
    If (fCfgSis('CTP_AS') = 'A') And (fCfgSis('PRBAMB', varInteger) = 1) Then
      lstCtpDet := repCtpDet.fRetDuplicatas(ADup);
  End;

  If Not Assigned(lstCtpDet) Or (lstCtpDet.Count <= 0) Then
  Begin
    objMov := repMovBan.fRetObjMovBan(ADup);

    objMov.fltValLan := ADup.fltValPag * IIF(ADup.fltValPag > 0, 1, -1);
    objMov.strCreDeb := IIF(ADup.fltValPag > 0, 'C', 'D');
    objMov.strCodCta := IIF(fEmptyStr(ADup.strCtaBai), ADup.strCodCta,
                                                       ADup.strCtaBai);
    objMov.dtaDtaLan := IIF(blnEstDtaDoc, ADup.dtaDtaPag, VS_Date);
    objMov.strCompet := IIF(blnEstDtaDoc, FormatDateTime('mm/YYYY',ADup.dtaDtaPag), FormatDateTime('mm/YYYY',VS_Date));
    objMov.strCodPor := ADup.strPorBai;
    objMov.strCodOpe := strLoginUsuarioLogado;
    objMov.dtaHorLan := fTime();
    objMov.strNumDoc := ADup.strNumDup;
    objMov.strNumDup := ADup.strNumDup;
    objMov.strCodEmp := VS_strCodEmp;

    objMov.strHist01 := Copy(IIF(blnEstornoPG,
                            'REF.ESTORNO PG ' +  ADup.strNumDup + '-' + ADup.strParcel + '-' + VS_strCodEmp + '-' + fValN(ADup.objCodFor.FOR_CODFOR),
                            'ESTORNO BX. CT. PAGAR ' + ADup.strNumDup + '-' + ADup.strParcel + '-' + VS_strCodEmp + '-' + fVAlN(ADup.objCodFor.FOR_CODFOR)), 1, 40);

    objMov.strCodFor := ADup.objCodFor.FOR_CODFOR;
    objMov.intSeqBai := 0;
    objMov.strParcel := ADup.strParcel;
    objMov.strEmpDup := VS_strCodEmp;
    objMov.strSerie_ := ADup.strSerie;
    objMov.strOrigem := repMovBan.fGetOrigem('CTP');
    If ADup.strCodEve.HasValue Then
      objMov.strCodEve := ADup.strCodEve;

    strSeqLan := repMovBan.fGravaMovBan(objMov);

    If fEmptyStr(strSeqLan) Then
      Raise ExceptionAutcom.Create('Não foi possível gravar o movimento bancário!');

    objBanCtp := TBanCtp.Create;
    objBanCtp.strNumDup := ADup.strNumDup;
    objBanCtp.strParcel := ADup.strParcel;
    objBanCtp.strSerie_ := ADup.strSerie;
    objBanCtp.strCodEmp := ADup.strCodEmp;
    objBanCtp.strCodFor := ADup.objCodFor.FOR_CODFOR;
    objBanCtp.strHist01 := ADup.strHist01;
    objBanCtp.strHist02 := ADup.strHist02;
    objBanCtp.strCodCta := ADup.strCodCta;
    objBanCtp.strEmpCta := ADup.strEmpBai;
    objBanCtp.intSeqBai := ADup.intSeqBai;
    objBanCtp.fltValPag := ADup.fltValPag;
    objBanCtp.fltDinhei := 0;
    objBanCtp.fltChqEmi := 0;
    objBanCtp.fltChqRep := 0;
    objBanCtp.fltOrdPag := 0;
    objBanCtp.fltValJur := ADup.fltValJur;
    objBanCtp.fltValDes := ADup.fltValDes;
    objBanCtp.fltValPri := ADup.fltValAnt;

    TGravaLogBan.fGravaLogBan(objBanCtp, VS_strCodEmp, strSeqLan);

    {***************************************}
    {* GRAVA O ESTORNO DO CHEQUE NO BANCHQ *}
    {***********07/03/2018****WS**REQ.93054*}

    If ADup.strDocBai.HasValue Then
    Begin
      If Not fEmptyStr(ADup.strDocBai.Value) Then
      Begin
        lstBanChq := repBanChq.fRetDocumentos<TBanChq>(ADup.strDocBai);
        For objBanChqOri In lstBanChq Do
        Begin
          objBanChq := TBanChq.Create;
          objBanChq.strCodBco := objBanChqOri.strCodBco;
          objBanChq.strNumAge := objBanChqOri.strNumAge;
          objBanChq.strConCor := objBanChqOri.strConCor;
          objBanChq.strNumChq := objBanChqOri.strNumChq;
          objBanChq.strCodCli := objBanChqOri.strCodCli;
          objBanChq.strNomEmi := objBanChqOri.strNomEmi;
          objBanChq.fltValChq := objBanChqOri.fltValChq;
          objBanChq.strHist01 := objBanChqOri.strHist01;
          objBanChq.strHist02 := objBanChqOri.strHist02;
          objBanChq.strCodEmp := objBanChqOri.strCodEmp;
          objBanChq.strCodFor := objBanChqOri.strCodFor;

          TGravaLogBan.fGravaLogBan(objBanChq, VS_strCodEmp, strSeqLan);
        End;
      End;
    End;
  End
  Else
    pGravaMovBan(ADup, lstCtpDet, blnEstDtaDoc);

end;

{********************************************************}
{* GRAVAÇÃO DO MOVBAN DE ACORDO COM UMA LISTA DE MOVBAN *}
{* ANTERIOR                                             *}
{*27/07/2015******************************************AF*}
procedure TEstornoPagar.pGravaLogExclusaoPG(ADuplicata: TCadPag);
var
  LNomeFormulario: String;
begin
  LNomeFormulario := IIF(Trim(Self.Name).IsEmpty, 'TEstornoPagar', Self.Name);

  untLogCtp.GravaLogCtp(ADuplicata.strAutInc,
                        'EXCLUSAO CONTAS A PAGAR (ESTORNO DE PG) [pEstornaDuplicataResumoCaixa]',
                        LNomeFormulario);
end;

procedure TEstornoPagar.pGravaMovBan(lstMov: TList<TMovBan>; blnEstDtaDoc: Boolean; blnEstornoPG: Boolean = False);
  Var
    objMov: TMovBan;
    movOri: TMovBan;
    strSeqLan : String;
Begin

  For movOri In lstMov Do
  Begin
    objMov := TMovBan.Create;

    objMov.fltValLan := movOri.fltValLan;
    objMov.strCreDeb := IIF(movOri.strCreDeb = 'D', 'C', 'D');
    objMov.strCodCta := movOri.strCodCta;
    objMov.dtaDtaLan := IIF(blnEstDtaDoc, movOri.dtaDtaLan, VS_Date);
    objMov.strCompet := IIF(blnEstDtaDoc, movOri.strCompet, FormatDateTime('mm/YYYY',VS_Date));
    objMov.strCodPor := movOri.strCodPor;
    objMov.strCodOpe := strLoginUsuarioLogado;
    objMov.dtaHorLan := fTime();
    objMov.strNumDoc := movOri.strNumDoc;
    objMov.strNumDup := movOri.strNumDup;
    objMov.strCodEmp := VS_strCodEmp;

    objMov.strHist01.Value := IIF(blnEstornoPG,
                        'REF.ESTORNO PG ' +  fValN(movOri.strNumDup) + '-' + fValN(movOri.strParcel) + '-' + VS_strCodEmp + '-' + fValN(movOri.strCodFor),
                        'ESTORNO BX. CT. PAGAR ' + fValN(movOri.strNumDup) + '-' + fValN(movOri.strParcel) + '-' + VS_strCodEmp + '-' + fValN(movOri.strCodFor));

    objMov.strCodFor := movOri.strCodFor;
    objMov.intSeqBai := 0;
    objMov.strParcel := movOri.strParcel;
    objMov.strEmpDup := VS_strCodEmp;
    objMov.strSerie_ := movOri.strSerie_;
    objMov.strOrigem := repMovBan.fGetOrigem('CTP');
    If movOri.strCodEve.HasValue Then
      objMov.strCodEve := movOri.strCodEve;

    strSeqLan := repMovBan.fGravaMovBan(objMov);

    If fEmptyStr(strSeqLan) Then
      Raise ExceptionAutcom.Create('Não foi possível gravar o movimento bancário!');

    pRegravaLogBan(movOri.strSeqLan, strSeqLan);
  End;

End;

{******************************************************************}
{* PROCEDIMENTO QUE CHAMA A GRAVAÇÃO DO MOVBAN POR DESMEMBRAMENTO *}
{*REQ. 36383 18/06/2015*****************************************JU*}
procedure TEstornoPagar.pGravaMovBan(ADup: TCadPag; lstCtp: TList<TCtpDet>; blnEstDtaDoc: Boolean);
  Var
    AMov     : TMovBan;
    intCont  : Integer;
    fltVlDesm,
    fltTotDesm: Double;
    strSeqLan : String;
    objBanCtp : TBanCtp;
begin
  fltTotDesm := 0;
  For intCont := 0 To lstCtp.Count - 1 Do
  Begin
    AMov := repMovBan.fRetObjMovBan(ADup);

    fltVlDesm := ADup.fltValPag * lstCtp[intCont].CTP_FATCAL;
    fltVlDesm := fFormataFloat(fltVlDesm, 2);

    fltTotDesm := fltTotDesm + fltVlDesm;

    if intCont = (lstCtp.Count - 1) then
    begin
      if fltTotDesm <> ADup.fltValPag then
         fltVlDesm := ADup.fltValPag - (fltTotDesm-fltVlDesm);
    end;

    AMov.fltValLan := fltVlDesm * IIF(fltVlDesm > 0, 1, -1);
    AMov.strCreDeb := IIF(fltVlDesm > 0, 'C', 'D');
    AMov.strCodCta := lstCtp[intCont].CTP_CODCTA;
    AMov.dtaDtaLan := IIF(blnEstDtaDoc, ADup.dtaDtaPag, VS_Date);
    AMov.strCompet := IIF(blnEstDtaDoc, FormatDateTime('mm/YYYY',ADup.dtaDtaPag),
                                        FormatDateTime('mm/YYYY',VS_Date));
    AMov.strCodPor := ADup.strPorBai;
    AMov.strCodOpe := strLoginUsuarioLogado;
    AMov.dtaHorLan := fTime();
    AMov.strNumDoc := ADup.strNumDup+ADup.strParcel;
    AMov.strNumDup := ADup.strNumDup;
    AMov.strCodEmp := VS_strCodEmp;
    AMov.strHist01 := 'ESTORNO BX. CT. PAGAR ' + ADup.strNumDup + '-' + ADup.strParcel + '-' + VS_strCodEmp + '-' + fValN(ADup.objCodFor.FOR_CODFOR);
    AMov.strCodFor := ADup.objCodFor.FOR_CODFOR;
    AMov.intSeqBai := 0;
    AMov.strParcel := ADup.strParcel;
    AMov.strEmpDup := lstCtp[intCont].CTP_CODEMP;
    AMov.strSerie_ := ADup.strSerie;
    AMov.strOrigem := repMovBan.fGetOrigem('CTP');
    If ADup.strCodEve.HasValue Then
      AMov.strCodEve := ADup.strCodEve;

    strSeqLan := repMovBan.fGravaMovBan(AMov);

    If fEmptyStr(strSeqLan) Then
      Raise ExceptionAutcom.Create('Não foi possível gravar o movimento bancário!');

    objBanCtp := TBanCtp.Create;
    objBanCtp.strNumDup := ADup.strNumDup;
    objBanCtp.strParcel := ADup.strParcel;
    objBanCtp.strSerie_ := ADup.strSerie;
    objBanCtp.strCodEmp := ADup.strCodEmp;
    objBanCtp.strCodFor := ADup.objCodFor.FOR_CODFOR;
    objBanCtp.strHist01 := ADup.strHist01;
    objBanCtp.strHist02 := ADup.strHist02;
    objBanCtp.strCodCta := ADup.strCodCta;
    objBanCtp.strEmpCta := ADup.strEmpBai;
    objBanCtp.intSeqBai := ADup.intSeqBai;
    objBanCtp.fltValPag := ADup.fltValPag;
    objBanCtp.fltDinhei := 0;
    objBanCtp.fltChqEmi := 0;
    objBanCtp.fltChqRep := 0;
    objBanCtp.fltOrdPag := 0;
    objBanCtp.fltValJur := ADup.fltValJur;
    objBanCtp.fltValDes := ADup.fltValDes;
    objBanCtp.fltValPri := ADup.fltValAnt;

    TGravaLogBan.fGravaLogBan(objBanCtp, VS_strCodEmp, strSeqLan);
  End;
end;

procedure TEstornoPagar.pEstornaDuplicataParcial(ADup: TCadPag; strChamada: String = ''; blnPagamentoAntecipado: Boolean = False);
Var
    vstrAutInc,
    vstrNumDup,
    vstrParcel,
    vstrCodEmp,
    vstrCodFor,
    vstrSerie  : String;
    vintSeqBai : Integer;
begin

  Try
    pDeletaChqEmi(ADup);
    {*****************************************************}
    {* LIMPANDO A ORIGEM DO REGISTRO PRINCIPAL DA MOVBAN *}
    {*REQ*155872***************************************MO*}
    If not blnPagamentoAntecipado then
    If (ADup.intRescai = 0) Or
       ((ADup.intRescai <> 0) And (fCfgSis('CTBPAG', varBoolean))) Then
      repMovBan.pLimparOrigemPrincipal(ADup);

    vstrAutInc := ADup.strAutInc;
    vstrNumDup := ADup.strNumDup;
    vstrParcel := ADup.strParcel;
    vstrCodEmp := ADup.strCodEmp;
    vstrCodFor := ADup.strCodFor;
    vstrSerie  := ADup.strSerie;
    vintSeqBai := ADup.intSeqBai;

    repCadPag.pEstornaDuplicataParcial(ADup, 'untTEstornoPagar ' + strChamada);

    pAtualizaCTRPAG(vstrAutInc,
                    vstrNumDup,
                    vstrParcel,
                    vstrCodEmp,
                    vstrCodFor,
                    vstrSerie,
                    vintSeqBai);

  Except
    On E: ExceptionAutcom Do
      Raise ExceptionAutcom.Create(E.Message);

    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;

end;

procedure TEstornoPagar.pDeterminaModalidadeEstorno(intSeqCon: Integer; ARcx: TCadRcxx);
  Var
    fltDinRec,
    fltCarRec,
    fltChqAvi,
    fltChqPre,
    fltOrdRec: Double;

    procedure pDeterminaModalidades;
    begin
      ARcx.fltDinRec := fltDinRec;
      ARcx.fltCarRec := fltCarRec;
      ARcx.fltChqAvi := fltChqAvi;
      ARcx.fltChqPre := fltChqPre;
      ARcx.fltOrdRec := fltOrdRec;
    End;

begin
  untCadRcxx.SomaModalidadesParaEstornoCaixa(intSeqCon,
                                             VS_strCodEmp,
                                             dtaDtaCai,
                                             fltDinRec,
                                             fltCarRec,
                                             fltChqAvi,
                                             fltChqPre,
                                             fltOrdRec);


  pDeterminaModalidades;

  {***************************************}
  {* SEGURANÇA!                          *}
  {************************************AF*}
  If fFormataFloat((ARcx.fltDinRec.Value + ARcx.fltCarRec.Value + ARcx.fltChqAvi.Value +
                    ARcx.fltChqPre.Value + ARcx.fltOrdRec.Value), 2) = 0.0 Then
    ARcx.fltDinRec := ARcx.fltValDoc;
end;



{************************************************}
{* CASO FOR ABATIMENTO DE DUPLICATAS É PERMITIDO*}
{* O ESTORNO SEM GERAR A MENSAGEM DE TRAVA      *}
{46021****************************************LE*}
function TEstornoPagar.fSemMovimentoBancario(APag:TList<TCadPag>): Boolean;
 Var
  I : Integer;
  fltValTot : Double;
  fltValAux : Double;
begin

 Result := False;
 fltValAux := 0;
 fltValTot := 0;

 For I := 0 To APag.Count - 1 Do
 Begin

  If APag[I].fltValPag < 0  Then
    fltValAux := fltValAux + APag[I].fltValPag
  Else
    fltValTot := fltValTot + APag[I].fltValPag;

 End;

 If fltValAux < 0 Then
   fltValTot := RoundTo(fltValTot, -2) + RoundTo(fltValAux, -2);

 If fltValTot = 0 Then
  Result := True;

end;

function TEstornoPagar.fEhBaixaZeradaCTP(APag:TList<TCadPag>): Boolean;
 Var
  I : Integer;
  fltValTot : Double;
  fltValAux : Double;
begin

 Result := False;
 fltValAux := 0;
 fltValTot := 0;

 For I := 0 To APag.Count - 1 Do
 Begin

  If APag[I].fltValPag < 0  Then
    fltValAux := fltValAux + APag[I].fltValPag
  Else
    fltValTot := fltValTot + APag[I].fltValPag;

 End;

 If fltValAux < 0 Then
   fltValTot := fltValTot + fltValAux;

 If (APag.Count > 1) And (fltValTot = 0) And (Not fEmptyStr(fCfgSis('PORBAI', varString))) Then
  Result := True;

end;

{*************************************************}
{* CASO HOUVER ABATIMENTO DE DUPLICATAS VERIFICA *}
{* SE FOI PAGO COM CHQ OU ORDPAG CASO FOR NÃO    *}
{* DEIXA SELECIONAR APENAS A DUPLICATA NEGATIVA  *}
{* POIS DUPLICATAS NEGATIVAS NA BAIXA DO CADPAG  *}
{* NÃO EFETUADO O RATEIO, SOMENTE PAG EM DINHEIRO*}
{46021*****************************************LE*}
function TEstornoPagar.fVerificaModalidadeBaixa: Boolean;
  Var
    fltValChq : Double;
    fltValOrd : Double;
    fltValChqRep : Double;
    fltValDinhei : Double;
    I: Integer;
begin

  If FBaixaDesmembradaPorModalidadePagamento Then
    Exit(False);

  fltValChq    := 0;
  fltValOrd    := 0;
  fltValChqRep := 0;
  fltValDinhei := 0;

  Result := False;

  For I := 0 To lstCadPag.Count -1 Do
  Begin

    If (lstCadPag[I].fltRepChq > 0 ) Then
      fltValChqRep := fltValChqRep +  lstCadPag[I].fltRepChq;

    If (lstCadPag[I].fltChqAvi > 0 ) Then
      fltValChq := fltValChq + lstCadPag[I].fltChqAvi;

    If (lstCadPag[I].fltOrdPag > 0) Then
      fltValOrd := fltValOrd + lstCadPag[I].fltOrdPag;


    If (lstCadPag[I].fltValOri < 0) And (lstCadPag[I].fltDinhei < 0) Then
      fltValDinhei := fltValDinhei +  lstCadPag[I].fltDinhei;

  End;

  If ((fltValChqRep <> 0 ) Or (fltValChq <> 0) Or ((fltValOrd <> 0) And  (fltValDinhei <> 0 ))) Then
    Result := True;

end;



function TEstornoPagar.fVerificaSaldoMaximoCaixa(ADup: TCadPag): Boolean;
var
  fltDinRec,
  fltCarRec,
  fltChqAvi,
  fltChqPre,
  fltOrdRec: Double;
begin
  If ADup.dtaDtaPag = dtaDtaCai Then
  Begin
    repCadRcx.pSomaModalidades(ADup.intRcxCon, fltDinRec, fltCarRec, fltChqAvi, fltChqPre, fltOrdRec);
    fltDinRec := Abs(fltDinRec);
    Result    := objResumoDeCaixa.fVerificaSaldoMaximo(fltDinRec, strOpeRcx, strCodigoCaixa);
  End
  Else
    Result := True;
end;

function TEstornoPagar.fTemPagamentoAntecipadoComPagamentoNormal: Boolean;
var intCont: integer;
    QtdPagamenentoAntecipado: integer;
    QtdSemPagamenentoAntecipado: integer;
    lTabelaPgoAntecipado: String;
begin
  QtdPagamenentoAntecipado := 0;
  QtdSemPagamenentoAntecipado := 0;
  For intCont := 0 To lstPagMar.Count-1 Do
  Begin
    If fTemPgoGer(lstPagMar[intCont], lTabelaPgoAntecipado) then
      Inc(QtdPagamenentoAntecipado)
     Else
      Inc(QtdSemPagamenentoAntecipado);
  End;
  Result := (QtdPagamenentoAntecipado > 0) And (QtdSemPagamenentoAntecipado > 0);
end;

function TEstornoPagar.getSelecaoIndividual: Boolean;
  Var
    LConsulta: TUniQuery;
begin
  //quando remover o aurelius, removemos a consulta também
  LConsulta := fCriaQuery;

  Try
    LConsulta.SQL.Text := 'SELECT * FROM CADPAG WHERE AUTOINCREM IN (' + fRetStrToSQLIn(RetornaAutoIncremsDuplicata) + ')';
    LConsulta.Open;

    Result := (Not fSemMovimentoBancario(LConsulta));
    If Result Then
    Begin
      LConsulta.Locate('AUTOINCREM', qryCadPag.Current<TCadPag>.strAutInc, []);

      Result := fSemVincularSeqCon(LConsulta);
    End;
  Finally
    LConsulta.Close;

    FreeAndNil(LConsulta);
  End;
end;

procedure TEstornoPagar.pRelancaPagamentoAntecipado(ADup: TCadPag);
var
  qryPgoGer,
  qryUpdate,
  qryCadPagOri,
  qryCadPag: TUniQuery;
  strAutInc,
  strParcel,
  strCodEmpOri,
  strCodFor: String;
  intSeqBaiOri: integer;
begin
  qryPgoGer := fCriaQuery;
  qryCadPag := fCriaQuery;
  qryUpdate := fCriaQuery;
  qryCadPagOri := fCriaQuery;
  Try
    Try
      If strTabelaPgoAntecipado = 'PGOGER' then
      Begin
        qryPgoGer.SQL.Add(' SELECT                       ');
        qryPgoGer.SQL.Add('   PGO_DUPORI,                ');
        qryPgoGer.SQL.Add('   PGO_SERORI,                ');
        qryPgoGer.SQL.Add('   PGO_FORORI,                ');
        qryPgoGer.SQL.Add('   PGO_EMPORI,                ');
        qryPgoGer.SQL.Add('   PGO_SEQORI AS PGO_SEQORI, ');
        qryPgoGer.SQL.Add('   PGO_PARORI,                ');
        qryPgoGer.SQL.Add('   PGO_HIST01,                ');
        qryPgoGer.SQL.Add('   PGO_HIST02                 ');
        qryPgoGer.SQL.Add(' FROM  PGOGER                 ');
        qryPgoGer.SQL.Add(' WHERE PGO_SEQPAG = :AUTPAG   ');
      End
      Else
      Begin
        qryPgoGer.SQL.Add(' SELECT                       ');
        qryPgoGer.SQL.Add('   PGF_DUPORI AS PGO_DUPORI,  ');
        qryPgoGer.SQL.Add('   PGF_SERORI AS PGO_SERORI,  ');
        qryPgoGer.SQL.Add('   PGF_FORORI AS PGO_FORORI,  ');
        qryPgoGer.SQL.Add('   PGF_EMPORI AS PGO_EMPORI,  ');
        qryPgoGer.SQL.Add('   PGF_SEQORI AS PGO_SEQORI,  ');
        qryPgoGer.SQL.Add('   PGF_PARORI AS PGO_PARORI,  ');
        qryPgoGer.SQL.Add('   CAST("" AS CHAR(1)) AS PGO_HIST01, ');
        qryPgoGer.SQL.Add('   CAST("" AS CHAR(1)) AS PGO_HIST02  ');

        qryPgoGer.SQL.Add(' FROM  PGOFIS                 ');
        qryPgoGer.SQL.Add(' WHERE PGF_SEQPAG = :AUTPAG   ');
      End;

      qryPgoGer.ParamByName('AUTPAG').AsString := ADup.strAutInc;
      qryPgoGer.Open;


      If qryPgoGer.IsEmpty Then
        Exit;
      strCodFor := qryPgoGer.FieldByName('PGO_FORORI').AsString;

      qryCadPagOri.SQL.Clear;
      qryCadPagOri.Sql.Add('SELECT * FROM CADPAG');
      qryCadPagOri.Sql.Add(' WHERE CTP_NUMDUP = :NUMDUP');
      qryCadPagOri.Sql.Add('   AND CTP_CODFOR = :CODFOR');
      qryCadPagOri.Sql.Add('   AND CTP_SERIE_ = :SERIE_');
      qryCadPagOri.Sql.Add('   AND CTP_CODEMP = IFNULL(:EMPORI, CTP_CODEMP)');
      qryCadPagOri.Sql.Add('   AND CTP_PARCEL = IFNULL(:PARCEL, CTP_PARCEL)');
      qryCadPagOri.Sql.Add('   AND CTP_SEQBAI = IFNULL(:SEQBAI, CTP_SEQBAI)');

      qryCadPagOri.ParamByName('NUMDUP').ASString := qryPgoGer.FieldByName('PGO_DUPORI').AsString;
      qryCadPagOri.ParamByName('CODFOR').ASString := qryPgoGer.FieldByName('PGO_FORORI').AsString;
      qryCadPagOri.ParamByName('SERIE_').ASString := qryPgoGer.FieldByName('PGO_SERORI').AsString;
      qryCadPagOri.ParamByName('EMPORI').Clear;
      If not fEmptyStr(qryPgoGer.FieldByName('PGO_EMPORI').AsString) Then
        qryCadPagOri.ParamByName('EMPORI').ASString := qryPgoGer.FieldByName('PGO_EMPORI').AsString;

      qryCadPagOri.ParamByName('SEQBAI').Clear;
      If not fEmptyStr(qryPgoGer.FieldByName('PGO_SEQORI').AsString) Then
        qryCadPagOri.ParamByName('SEQBAI').ASString := qryPgoGer.FieldByName('PGO_SEQORI').AsString;

      qryCadPagOri.ParamByName('PARCEL').Clear;
      If not fEmptyStr(qryPgoGer.FieldByName('PGO_PARORI').AsString) Then
        qryCadPagOri.ParamByName('PARCEL').ASString := qryPgoGer.FieldByName('PGO_PARORI').AsString;

      qryCadPagOri.Open;
      qryCadPag.SQL.Add('SELECT * FROM CADPAG WHERE AUTOINCREM = :AUTINC');
      qryCadPag.ParamByName('AUTINC').AsString := ADup.strAutinc;
      qryCadPag.Open;

      //Se existe ainda o pagamento atencipado retorna o valor para ele

      If Not qryCadPagOri.IsEmpty Then
      Begin
        qryUpdate.SQL.Clear;
        qryUpdate.SQL.Add('UPDATE CADPAG SET CTP_VALORI = IFNULL(CTP_VALORI, 0) + :VALORI,');
        qryUpdate.SQL.Add('                  CTP_VALPAG = IFNULL(CTP_VALPAG, 0) + :VALPAG');
        qryUpdate.SQL.Add(' WHERE AUTOINCREM =  :AUTINC');

        qryUpdate.ParamByName('VALORI').AsFloat := qryCadPag.FieldByName('CTP_VALORI').AsFloat;
        qryUpdate.ParamByName('VALPAG').AsFloat := qryCadPag.FieldByName('CTP_VALPAG').AsFloat;
        qryUpdate.ParamByName('AUTINC').AsString := qryCadPagOri.FieldByName('AUTOINCREM').AsString;

        qryUpdate.ExecSQL;

        untLogCtp.GravaLogCtp(qryCadPagOri.FieldByName('AUTOINCREM').AsString,
                              'TEstornoPagar.pRelancaPagamentoAntecipado',
                              'RELANÇAMENTO DE PAGAMENTO ANTECIPADO');
      End
      Else
      Begin

        //RELANÇO O PAGAMENTO ANTECIPADO, PARA FICAR DISPONÍVEL NOVAMENTE PARA USO
        strAutInc := fRetAutoincrem('CADPAG', VS_strCodEmp);

        If fEmptyStr(strCodFor) Then
          strCodFor := qryCadPag.FieldByName('CTP_CODFOR').AsString;

        strParcel := qryPgoGer.FieldByName('PGO_PARORI').AsString;
        If fEmptyStr(strParcel) then
          strParcel := 'A';
        strCodEmpOri := qryPgoGer.FieldByName('PGO_EMPORI').AsString;
        If fEmptyStr(strCodempOri) then
          strCodEmpOri := qryCadPag.FieldByName('CTP_CODEMP').AsString;
        If fEmptyStr(qryPgoGer.FieldByName('PGO_SEQORI').AsString) then
          intSeqBaiOri := 0
        Else
          intSeqBaiOri :=  qryPgoGer.FieldByName('PGO_SEQORI').AsInteger;

        fGravaCadPag('TEstornoPagar.pRelancaPagamentoAntecipado',
                     'RELANÇAMENTO DE PAGAMENTO ANTECIPADO',
                     strCodFor,
                     qryPgoGer.FieldByName('PGO_DUPORI').AsString,
                     strParcel,
                     strCodEmpOri,
                     qryCadPag.FieldByName('CTP_CODCTA').AsString,
                     qryPgoGer.FieldByName('PGO_SERORI').AsString,
                     intSeqBaiOri,
                     qryCadPag.FieldByName('CTP_DTACAD').AsDateTime,
                     qryCadPag.FieldByName('CTP_DTAVEN').AsDateTime,
                     qryCadPag.FieldByName('CTP_VALDUP').AsFloat,
                     qryCadPag.FieldByName('CTP_VALORI').AsFloat,
                     qryCadPag.FieldByName('CTP_PREVIS').AsString,
                     qryCadPag.FieldByName('CTP_VEIOBO').AsString,
                     qryCadPag.FieldByName('CTP_DEPOSI').AsString,
                     IIf(strTabelaPgoAntecipado = 'PGOGER', qryPgoGer.FieldByName('PGO_HIST01').AsString, ''),
                     IIf(strTabelaPgoAntecipado = 'PGOGER', qryPgoGer.FieldByName('PGO_HIST02').AsString, ''),
                     qryCadPag.FieldByName('CTP_HISBAI').AsString,
                     qryCadPag.FieldByName('CTP_PORBAI').AsString,
                     qryCadPag.FieldByName('CTP_CTABAI').AsString,
                     qryCadPag.FieldByName('CTP_DOCBAI').AsString,
                     qryCadPag.FieldByName('CTP_OPEBAI').AsString,
                     qryCadPag.FieldByName('CTP_DTAPAG').AsDateTime,
                     qryCadPag.FieldByName('CTP_VALPAG').AsFloat,
                     qryCadPag.FieldByName('CTP_VALJUR').AsFloat,
                     qryCadPag.FieldByName('CTP_VALDES').AsFloat,
                     qryCadPag.FieldByName('CTP_EMPGER').AsString,
                     qryCadPag.FieldByName('CTP_CODEVE').AsString,
                     qryCadPag.FieldByName('CTP_USACHQ').AsString,
                     qryCadPag.FieldByName('CTP_CODPOR').AsString,
                     qryCadPag.FieldByName('CTP_NUMDOC').AsString,
                     qryCadPag.FieldByName('CTP_JURSUJ').AsFloat,
                     qryCadPag.FieldByName('CTP_DESSUJ').AsFloat,
                     qryCadPag.FieldByName('CTP_SEQCON').AsInteger,
                     qryCadPag.FieldByName('CTP_RESCAI').AsInteger = 1,
                     qryCadPag.FieldByName('CTP_RCXCON').AsInteger,
                     qryCadPag.FieldByName('CTP_TIPDOC').AsString,
                     qryCadPag.FieldByName('CTP_VENDOR').AsFloat,
                     qryCadPag.FieldByName('CTP_VEIONF').AsString,
                     qryCadPag.FieldByName('CTP_NOTENT').AsString,
                     qryCadPag.FieldByName('CTP_NOTTIP').AsString,
                     qryCadPag.FieldByName('CTP_CTPCOM').AsString,
                     strAutInc,
                     qryCadPag.FieldByName('CTP_DOCTER').AsString,
                     qryCadPag.FieldByName('CTP_ESPTER').AsString,
                     qryCadPag.FieldByName('CTP_EMPTER').AsString,
                     qryCadPag.FieldByName('CTP_CLITER').AsString,
                     qryCadPag.FieldByName('CTP_USOCON').AsString,
                     qryCadPag.FieldByName('CTP_COMPET').AsString,
                     qryCadPag.FieldByName('CTP_USOCLI').AsString,
                     qryCadPag.FieldByName('CTP_USODOC').AsString,
                     qryCadPag.FieldByName('CTP_USOESP').AsString,
                     qryCadPag.FieldByName('CTP_USOEMP').AsString,
                     qryCadPag.FieldByName('CTP_DINHEI').AsFloat,
                     qryCadPag.FieldByName('CTP_CHQAVI').AsFloat,
                     qryCadPag.FieldByName('CTP_ORDPAG').AsFloat,
                     qryCadPag.FieldByName('CTP_REPCHQ').AsFloat,
                     qryCadPag.FieldByName('CTP_CODVEN').AsString,
                     qryCadPag.FieldByName('CTP_JURANT').AsFloat,
                     qryCadPag.FieldByName('CTP_DESANT').AsFloat,
                     qryCadPag.FieldByName('CTP_LINDIG').AsString,
                     qryCadPag.FieldByName('CTP_CODBAR').AsString,
                     strAutInc,
                     qryCadPag.FieldByName('CTP_NUMDDA').AsString,
                     '',
                     qryCadPag.FieldByName('CTP_Q_GUIA').AsString,
                     qryCadPag.FieldByName('CTP_CODREC').AsString,
                     qryCadPag.FieldByName('CTP_BCOFOR').AsString,
                     '',
                     qryCadPag.FieldByName('CTP_CODPRJ').AsString,
                     qryCadPag.FieldByName('CTP_PAGANT').AsString,
                     '',
                     '',
                     '',
                     '',
                     0,
                     '',
                     qryCadPag.FieldByName('CTP_MULSUJ').AsFloat,
                     qryCadPag.FieldByName('CTP_FORPIX').AsString,
                     qryCadPag.FieldByName('CTP_GRVORI').AsFloat);

      End;
      qryUpdate.SQL.Clear;
      qryUpdate.SQL.Add('UPDATE CADPAG SET CTP_PAGANT = "N", CTP_SEQCON = NULL  WHERE AUTOINCREM = :AUTINC');
      qryUpdate.ParamByName('AUTINC').AsString := ADup.strAutinc;
      qryUpdate.ExecSQL;

      qryUpdate.SQL.Clear;
      If strTabelaPgoAntecipado = 'PGOGER' then
        qryUpdate.SQL.Add('DELETE FROM ' + strTabelaPgoAntecipado + ' WHERE PGO_SEQPAG = :AUTINC')
      Else
        qryUpdate.SQL.Add('DELETE FROM ' + strTabelaPgoAntecipado + ' WHERE PGF_SEQPAG = :AUTINC');
      qryUpdate.ParamByName('AUTINC').AsString := ADup.strAutinc;
      qryUpdate.ExecSQL;

    Except On
      E:Exception Do
      Begin
        raise Exception.Create('[TEstornoPagar.pRelancaPagamentoAntecipado] Erro ao tentar relançar pagamento antecipado:' + #13 + E.Message);
      End;
    End;
  Finally
    FreeAndNil(qryPgoGer);
    FreeAndNil(qryCadPag);
    FreeAndNil(qryUpdate);
    FreeAndNil(qryCadPagOri);
  End;
end;

function TEstornoPagar.fTemPgoGer(ADup: TCadPag; var ATabelaPgoAntecipado: String): Boolean;
begin
  ATabelaPgoAntecipado := '';
  Result := Not fEmptyStr(fCampoTabela('AUTOINCREM', 'PGOGER', ['PGO_SEQPAG'], [ADup.strAutInc]));
  If not Result Then
  begin
    Result := Not fEmptyStr(fCampoTabela('AUTOINCREM', 'PGOFIS', ['PGF_SEQPAG'], [ADup.strAutInc]));
    If Result Then
      ATabelaPgoAntecipado := 'PGOFIS';
  End
  Else
    ATabelaPgoAntecipado := 'PGOGER'
end;

function TEstornoPagar.fSemMovimentoBancario(
  ADatasetEstorno: TDataset): Boolean;
  Var
    LValorPositivo,
    LValorNegativo: Double;
begin
  LValorPositivo := 0;
  LValorNegativo := 0;

  ADatasetEstorno.First;
  While Not ADatasetEstorno.Eof Do
  Begin
    If fFormataFloat(ADatasetEstorno.FieldByName('CTP_VALPAG').AsFloat, 2) < 0 Then
      LValorNegativo := LValorNegativo + ADatasetEstorno.FieldByName('CTP_VALPAG').AsFloat
    Else
      LValorPositivo := LValorPositivo + ADatasetEstorno.FieldByName('CTP_VALPAG').AsFloat;

    ADatasetEstorno.Next;
  End;

  If LValorNegativo < 0 Then
    LValorPositivo := RoundTo(LValorPositivo, -2) + RoundTo(LValorNegativo, -2);

  Result := fFormataFloat(LValorPositivo, 2) = 0.00;
end;

function TEstornoPagar.fSemVincularSeqCon(ADatasetEstorno: TDataset;
  blnRecalcularModalidade: Boolean): Boolean;
begin
  Result := False;

  blnModalidade := IIF(blnRecalcularModalidade,
                       fVerificaModalidadeBaixa(ADatasetEstorno),
                       blnModalidade);

  If blnModalidade Then
    Exit(False);

  If fFormataFloat(ADatasetEstorno.FieldByName('CTP_DINHEI').AsFloat, 2) <> 0 Then
    Result := fFormataFloat(ADatasetEstorno.FieldByName('CTP_ORDPAG').AsFloat, 2) = 0;

  If Not Result Then
  Begin
    If fFormataFloat(ADatasetEstorno.FieldByName('CTP_DINHEI').AsFloat, 2) = 0 Then
      Result := fFormataFloat(ADatasetEstorno.FieldByName('CTP_ORDPAG').AsFloat, 2) <> 0;
  End;

  If Not Result Then
    Exit;

  Result := fFormataFloat(ADatasetEstorno.FieldByName('CTP_CHQAVI').AsFloat +
                          ADatasetEstorno.FieldByName('CTP_REPCHQ').AsFloat, 2) = 0;
  If Result Then
    Result := Not FBaixaDesmembradaPorModalidadePagamento;
end;

procedure TEstornoPagar.pAtualizaCTRPAG(vstrAutInc,
                                        vstrNumDup,
                                        vstrParcel,
                                        vstrCodEmp,
                                        vstrCodFor,
                                        vstrSerie  : String;
                                        vintSeqBai : Integer);
var
  qryUpdate,
  qryCtrPag,
  qryCadPag: TUniQuery;
  AIntSeqBai : Integer;
begin
  qryCtrPag := fCriaQuery;
  qryCadPag := fCriaQuery;
  qryUpdate := fCriaQuery;
  Try
    Try

      // VERIFICA SE TEM REGISTRO REFERENTE A ESSA DUPLICATA NA CTRPAG
      qryCtrPag.SQL.Add(' SELECT        ');
      qryCtrPag.SQL.Add('   AUTOINCREM, ');
      qryCtrPag.SQL.Add('   PAG_AUTCTP  ');
      qryCtrPag.SQL.Add(' FROM CTRPAG   ');
      qryCtrPag.SQL.Add(' WHERE PAG_AUTCTP = :AUTPAG ');

      qryCtrPag.ParamByName('AUTPAG').AsString := vstrAutInc;
      qryCtrPag.Open;

      AIntSeqBai := vintSeqBai;

      If Not qryCtrPag.IsEmpty Then
      Begin

         If (AIntSeqBai > 0) Then
         Begin
            qryCadPag.SQL.Clear;
            qryCadPag.Sql.Add('SELECT AUTOINCREM FROM CADPAG');
            qryCadPag.Sql.Add(' WHERE CTP_NUMDUP = :NUMDUP');
            qryCadPag.Sql.Add('   AND CTP_PARCEL = :PARCEL');
            qryCadPag.Sql.Add('   AND CTP_CODEMP = :CODEMP');
            qryCadPag.Sql.Add('   AND CTP_CODFOR = :CODFOR');
            qryCadPag.Sql.Add('   AND CTP_SERIE_ = :SERIE_');
            qryCadPag.Sql.Add('   AND CTP_SEQBAI = :SEQBAI_ANT');

            qryCadPag.ParamByName('NUMDUP').ASString      := vstrNumDup;
            qryCadPag.ParamByName('PARCEL').ASString      := vstrParcel;
            qryCadPag.ParamByName('CODEMP').ASString      := vstrCodEmp;
            qryCadPag.ParamByName('CODFOR').ASString      := vstrCodFor;
            qryCadPag.ParamByName('SERIE_').ASString      := vstrSerie;
            qryCadPag.ParamByName('SEQBAI_ANT').ASInteger := (AIntSeqBai -1);

            qryCadPag.Open;

            If Not qryCadPag.IsEmpty Then
            Begin
               qryUpdate.SQL.Clear;
               qryUpdate.SQL.Add(' UPDATE CTRPAG SET PAG_AUTCTP = :AUTCTP ');
               qryUpdate.SQL.Add('  WHERE AUTOINCREM = :AUTINC');
               qryUpdate.ParamByName('AUTCTP').AsString := qryCadPag.FieldByName('AUTOINCREM').AsString;
               qryUpdate.ParamByName('AUTINC').AsString := qryCtrPag.FieldByName('AUTOINCREM').AsString;
               qryUpdate.ExecSQL;
            End;

         End;

      End;

    Except On
      E:Exception Do
      Begin
        pMensagensErro('Erro ao atualizar a tabela :' + #13 + E.Message, '[pAtualizaCTRPAG]');
      End;
    End;
  Finally
    FreeAndNil(qryCadPag);
    FreeAndNil(qryUpdate);
    FreeAndNil(qryCtrPag);
  End;
end;

end.
