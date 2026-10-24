unit untTRestauraDuplicataMercantil;

interface

uses Classes, SysUtils, StrUtils, System.Generics.Collections, Aurelius.Bind.Dataset,
  untTCadRec, untTCadRecRepository, Aurelius.Types.Nullable,
  DB, untFuncAutBan;

Type
  TRestauraDuplicataMercantil = Class(TComponent)
  Private
    FCodigoCliente: String;
    FCodigoEmpresa: String;
    FEmpresaAcesso: String;
    FEspecie      : String;
    FDataEscolhida: TTipoData;
    FDataInicio   : TDateTime;
    FDataFinal    : TDateTime;
    FTotalMarcado : Double;

    lstCadRec: TList<TCadRec>;
    lstCtrMar: TList<TCadRec>;
    qryCadRec: TAureliusDataset;

    repCadRec: TCadRecRepository;

    function getTotalDuplicata: Double;

  Public
    objFiltro: TList<TCadRec>;

    constructor Create(Owner: TComponent); Reintroduce;
    destructor Destroy; Override;

    procedure DesmarcarTodos;
    procedure MarcarTodos;

    procedure DeleteSelecion;
    procedure InsertSelecion;

    procedure CarregaDados;
    procedure LimparDados;
    procedure RestauraDuplicatas;

    property ACodigoCliente: String    Read FCodigoCliente Write FCodigoCliente;
    property ACodigoEmpresa: String    Read FCodigoEmpresa Write FCodigoEmpresa;
    property AEspecie      : String    Read FEspecie       Write FEspecie;
    property ADataEscolhida: TTipoData Read FDataEscolhida Write FDataEscolhida;
    property ADataInicio   : TDateTime Read FDataInicio    Write FDataInicio;
    property ADataFinal    : TDateTime Read FDataFinal     Write FDataFinal;
    property AEmpresaAcesso: String    Read FEmpresaAcesso Write FEmpresaAcesso;

    property ATotalDuplicata: Double Read getTotalDuplicata;
    property ATotalMarcado  : Double Read FTotalMarcado;

    property CtrMar: TList<TCadRec>   Read lstCtrMar;
    property CadRec: TList<TCadRec>   Read lstCadRec Write lstCadRec;
    property qryRec: TAureliusDataset Read qryCadRec Write qryCadRec;
  End;

implementation

uses untFuncoesSimples, untConstantes, untUtilRepository, untLogCtr,
  untTypesSistema;

{ TRestauraDuplicataMercantil }

procedure TRestauraDuplicataMercantil.CarregaDados;
begin
  lstCadRec := repCadRec.RetornaDuplicatasComMercantil(FCodigoCliente, FCodigoEmpresa, FEspecie, FDataInicio, FDataFinal, FDataEscolhida, FEmpresaAcesso);

  qryCadRec.Close;
  qryCadRec.SetSourceList(lstCadRec);
  qryCadRec.Open;

  TFloatField(qryCadRec.FieldByName('CTR_VALDUP')).DisplayFormat := '#,##0.00';
end;

constructor TRestauraDuplicataMercantil.Create(Owner: TComponent);
begin
  inherited Create(Owner);

  FDataInicio   := 0;
  FDataFinal    := 0;
  FTotalMarcado := 0;

  lstCtrMar := TList<TCadRec>.Create;
  qryCadRec := TAureliusDataset.Create(Owner);

  repCadRec := TCadRecRepository.Create;
end;

procedure TRestauraDuplicataMercantil.DeleteSelecion;
begin
  FTotalMarcado := (FTotalMarcado - qryCadRec.Current<TCadRec>.CTR_VALDUP.Value);
  lstCtrMar.Remove(qryCadRec.Current<TCadRec>);
end;

procedure TRestauraDuplicataMercantil.DesmarcarTodos;
begin
  FTotalMarcado := 0;
  lstCtrMar.Clear;
end;

destructor TRestauraDuplicataMercantil.Destroy;
begin
  FreeAndNil(repCadRec);

  inherited;
end;

function TRestauraDuplicataMercantil.getTotalDuplicata: Double;
  Var
    AValorRetornado: Double;
begin
  AValorRetornado := 0;
  If (Not Assigned(lstCadRec)) Or (lstCadRec.Count <= 0) Then
    AValorRetornado := 0
  Else repCadRec.fRetSomaDuplicatasComRemessaMercantil(FCodigoCliente, FCodigoEmpresa, FEspecie, FDataInicio, FDataFinal, FDataEscolhida, AValorRetornado, FEmpresaAcesso);

  Result := AValorRetornado;
end;

procedure TRestauraDuplicataMercantil.InsertSelecion;
begin
  FTotalMarcado := (FTotalMarcado + qryCadRec.Current<TCadRec>.CTR_VALDUP.Value);
  lstCtrMar.Add(qryCadRec.Current<TCadRec>);
end;

procedure TRestauraDuplicataMercantil.LimparDados;
begin
  FCodigoCliente := '';
  FCodigoEmpresa := '';
  FEspecie       := '';
  FDataEscolhida := tdEnvio;
  FDataInicio    := 0;
  FDataFinal     := 0;
  FTotalMarcado  := 0;

  If qryCadRec.Active Then
    qryCadRec.Close;

  If Assigned(lstCadRec) Then
    lstCadRec.Clear;

  lstCtrMar.Clear;
end;

procedure TRestauraDuplicataMercantil.MarcarTodos;
Var
  I: Integer;
begin
  lstCtrMar.Clear;
  For I := 0 To lstCadRec.Count -1 Do
    lstCtrMar.Add(lstCadRec[I]);

  FTotalMarcado := ATotalDuplicata;
end;

procedure TRestauraDuplicataMercantil.RestauraDuplicatas;
Var
  objDuplicata: TCadRec;
Begin

  Try
    fStartTransaction;

    For objDuplicata In lstCtrMar Do
    Begin
      objDuplicata.CTR_BCOBOL := SNull;
      objDuplicata.CTR_DTABOL := SNull;

      If Not fEmptyStr(fCfgSis('PORMER')) Then
        objDuplicata.CTR_CODPOR := SNull;

      repCadRec.pAtualizar;
      untLogCtr.GravaLogCtr(objDuplicata.AUTOINCREM, 'RESTAURAÇÃO DE DUPLICATA MERCANTIL', 'frmRestauraDuplicataMercantil');
    End;

    If fCommit Then
      pMensagemOk('Restauração efetuada com sucesso!');
  Except
    On E: ExceptionAutcom Do
    Begin
      fRollBack;
      pMensagemOk(E.Message);
    End;

    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro('Erro ao tentar restaurar duplicata(s):' + #13 + E.Message, '[untTRestauraDuplicataMercantil.RestauraDuplicatas]');
    End;
  End;

end;

end.
