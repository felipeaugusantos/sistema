unit untTefCitelTransacaoSitefExpUtils;

interface

uses
  System.SysUtils, System.Generics.Collections;

type
  TSitefExpCredencial = class
  private
    FstrUrl: string;
    FstrCod: string;
    FstrUsr: string;
    FstrPwd: string;

  public
    property Url: string read FstrUrl;
    property Cod: string read FstrCod;
    property Usr: string read FstrUsr;
    property Pwd: string read FstrPwd;

    function AsString: string;

    constructor Create(const AUrl, ACod, AUsr, APwd: string);
  end;

  TSitefExpCredencialLastUtil = class
  public
    class function Carregar: string;
    class procedure Gravar(ACredencial: TSitefExpCredencial);
  end;

  TSitefExpCredencialController = class
  private
    //lista de todas a credenciais cadastradas para a empresa logada
    FCredenciais: TObjectList<TSitefExpCredencial>;
    //posição corrente na lista, usada durante o fluxo de tentativas
    FSeqCredencialAtual: Integer;
    //posição na lista da última credencial que obteve sucesso
    FSeqUltimaCredencialSucesso: Integer;
    //auxiliar para evitar que a "ultima credencial que obteve sucesso"
    //seja tentada mais de uma vez, caso falhe na primeira tentativa
    FJaTentouUltimaCredencialSucesso: Boolean;

    procedure pCarregarCredenciais;
    procedure pGravarUltimaCredencialSucesso;
  public
    procedure pNovaTentativa;
    procedure pSucesso;
    function fProximaCredencial: TSitefExpCredencial;

    function fCountCredenciais: Integer;

    constructor Create();
    destructor Destroy; override;
  end;

implementation

uses
  Data.DB, Uni, untFuncoesSimples, untTCfgCredenciaisSitefExp;

{ TSitefExpCredencialLastUtil }

class function TSitefExpCredencialLastUtil.Carregar: string;
begin
  Result := fCampoTabela('SIE_CREDEN', 'SIEULT', ['SIE_CODEMP'], [VS_strCodEmp]);
end;

class procedure TSitefExpCredencialLastUtil.Gravar(ACredencial: TSitefExpCredencial);
var
  qryCre: TUniQuery;
begin
  qryCre := fCriaQuery(Nil);
  try
    qryCre.SQL.Text := 'REPLACE INTO SIEULT (SIE_CODEMP, SIE_CREDEN) VALUES (:CODEMP, :CREDEN)';
    qryCre.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryCre.ParamByName('CREDEN').AsString := ACredencial.AsString;
    qryCre.ExecSQL;
  finally
    FreeAndNil(qryCre);
  end;

end;

{ TSitefExpCredencialController }

constructor TSitefExpCredencialController.Create;
begin
  FCredenciais := TObjectList<TSitefExpCredencial>.Create();

  pCarregarCredenciais;
  pNovaTentativa;
end;

destructor TSitefExpCredencialController.Destroy;
begin
  try
    pGravarUltimaCredencialSucesso;
  except
  end;
  FreeAndNil(FCredenciais);
  inherited;
end;

function TSitefExpCredencialController.fCountCredenciais: Integer;
begin
  Result := FCredenciais.Count;
end;

function TSitefExpCredencialController.fProximaCredencial: TSitefExpCredencial;
begin
  //antes de tentar as demais credenciais, tenta com a última credecial que obteve sucesso
  if (not FJaTentouUltimaCredencialSucesso) then
  begin
    FJaTentouUltimaCredencialSucesso := True;

    if (FSeqUltimaCredencialSucesso <> -1) and (FSeqUltimaCredencialSucesso <= (FCredenciais.Count - 1)) then
    begin
      Result := FCredenciais.Items[FSeqUltimaCredencialSucesso];
      Exit;
    end;
  end;

  //fluxo padrao, tentando com todas as credenciais da lista,
  //pulando a "última credecial que obteve sucesso" caso ela já tenha sido tentada e falhou
  Result := nil;

  FSeqCredencialAtual := FSeqCredencialAtual + 1;

  if FJaTentouUltimaCredencialSucesso and (FSeqCredencialAtual = FSeqUltimaCredencialSucesso) then
    FSeqCredencialAtual := FSeqCredencialAtual + 1;

  if FSeqCredencialAtual > (FCredenciais.Count - 1) then
    Exit;

  Result := FCredenciais.Items[FSeqCredencialAtual];
end;

procedure TSitefExpCredencialController.pCarregarCredenciais;
var
  LcfgCred: TCfgCredenciaisSitefExp;
  LdsCred: TDataSet;
  LultCred: string;
  Lcred: TSitefExpCredencial;
begin
  FSeqUltimaCredencialSucesso := -1;
  FCredenciais.Clear;

  LultCred := TSitefExpCredencialLastUtil.Carregar;

  LcfgCred := TCfgCredenciaisSitefExp.Create;
  try
    LdsCred := LCfgCred.fGetDataset;
    LdsCred.First;
    while not LdsCred.Eof do
    begin
      Lcred := TSitefExpCredencial.Create(
        LdsCred.FieldByName('URLAPI').AsString,
        LdsCred.FieldByName('CODCLI').AsString,
        LdsCred.FieldByName('USRAUT').AsString,
        LdsCred.FieldByName('PWDAUT').AsString
      );

      FCredenciais.Add(Lcred);

      if Lcred.AsString = LultCred then
        FSeqUltimaCredencialSucesso := FCredenciais.Count -1;

      LdsCred.Next;
    end;
  finally
    FreeandNil(LcfgCred);
  end;
end;

procedure TSitefExpCredencialController.pGravarUltimaCredencialSucesso;
begin
  if FCredenciais.Count = 0 then
    Exit;

  if FSeqUltimaCredencialSucesso = -1 then
    Exit;

  if FSeqUltimaCredencialSucesso > FCredenciais.Count then
    Exit;

  TSitefExpCredencialLastUtil.Gravar(FCredenciais.Items[FSeqUltimaCredencialSucesso]);
end;

procedure TSitefExpCredencialController.pNovaTentativa;
begin
  FSeqCredencialAtual := -1;
  FJaTentouUltimaCredencialSucesso := False;
end;

procedure TSitefExpCredencialController.pSucesso;
begin
  if FCredenciais.Count = 0 then
    Exit;

  if FSeqCredencialAtual > (FCredenciais.Count - 1) then
    Exit;

  if (FSeqCredencialAtual <> -1) then
    FSeqUltimaCredencialSucesso := FSeqCredencialAtual;
end;

{ TSitefExpCredencial }

function TSitefExpCredencial.AsString: string;
begin
  Result := FstrUrl + '|' + FstrCod;
end;

constructor TSitefExpCredencial.Create(const AUrl, ACod, AUsr, APwd: string);
begin
  FstrUrl := AUrl;
  FstrCod := ACod;
  FstrUsr := AUsr;
  FstrPwd := APwd;
end;

end.
