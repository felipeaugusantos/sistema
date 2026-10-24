unit Contabilidade.Classes.TChamarDocOrigem;

interface

type
  IChamarDocOrigem = interface
    ['{5B25AD3E-6448-491C-8B29-17C07D144A05}']
    procedure Chamar;
  end;

  TChamarDocOrigem = class(TInterfacedObject, IChamarDocOrigem)
  private
    FTipLan : String;
    FChvDoc : String;
    FTabela : string;
    procedure ChamarLivroFiscal(strAutInc: String);
    procedure ChamarManutencaoDeCheques(strAutInc: string);
    procedure ChamarMovimentoBancario(strAutInc: string);
    procedure ChamarContasAReceber(strAutInc: String);
    procedure ChamarContasAPagar(strAutInc: string);
    procedure ChamarManutencaoDeCartoes(strAutInc: string);
  public
    constructor Create(strTipLan, strChvDoc, strTabela: String);
    class function New(strTipLan, strChvDoc, strTabela: String): IChamarDocOrigem;
    procedure Chamar;
  end;

implementation

uses untFuncoesSimples, Uni, SysUtils, StrUtils, untCadLivroFiscal,
  untCadCheques, untCadMovBancario, untCadCtaReceber, untCadCtaPagar,
  untCadMovCartoes, Contabilidade.Funcoes;

{ TChamarDocOrigem }

procedure TChamarDocOrigem.ChamarContasAPagar(strAutInc: string);
var
  frmCadCtaPagar: TfrmCadCtaPagar;
begin
  pCriarFormularios(TfrmCadCtaPagar, frmCadCtaPagar);
  try
    frmCadCtaPagar.strAutoIncrem := strAutInc;
    frmCadCtaPagar.ShowModal;
  finally
    pFreeAndNil(frmCadCtaPagar);
  end;
end;

procedure TChamarDocOrigem.ChamarContasAReceber(strAutInc: String);
var
  frmCadCtaReceber: TfrmCadCtaReceber;
begin
  pCriarFormularios(TfrmCadCtaReceber, frmCadCtaReceber);
  try
    frmCadCtaReceber.strAutoincrem := strAutInc;
    frmCadCtaReceber.ShowModal;
  finally
    pFreeAndNil(frmCadCtaReceber);
  end;
end;

procedure TChamarDocOrigem.ChamarLivroFiscal(strAutInc: String);

  function fRetornaAutoIncremCadFis(strNumDoc, strEspDoc, strCodEmp: string; strForCli: string = ''): string;
  begin
    if fEmptyStr(strForCli) then
    begin
      Result := fCampoTabela('AUTOINCREM', 'CADFIS', ['FIS_NUMDOC', 'FIS_ESPDOC', 'FIS_CODEMP'],
                                                     [strNumDoc, strEspDoc, strCodEmp]);
    end
    else
    begin
      Result := fCampoTabela('AUTOINCREM', 'CADFIS', ['FIS_NUMDOC', 'FIS_ESPDOC', 'FIS_CODEMP', 'FIS_FORCLI'],
                                                     [strNumDoc, strEspDoc, strCodEmp, strForCli]);
    end;
  end;

  var
    strDocume : string;

begin
  pCriarFormularios(TfrmCadLivroFiscal, frmCadLivroFiscal);
  try
    if Length(strAutInc) = 17 then
    begin
      strAutInc := fRetornaAutoIncremCadFis(LeftStr(strAutInc, 12), Copy(strAutInc, 13, 2), RightStr(strAutInc, 3));
    end
    else if (not fEmptyStr(FTabela)) and ((FTabela = 'MOVGER') or (FTabela = 'NOTGER')) then
    begin
      strDocume := fCampoTabela('CONCAT(GER_NUMDOC, GER_ESPDOC, GER_CODEMP, IFNULL(GER_CODCLI,""), IFNULL(GER_CODFOR,""))', FTabela, ['AUTOINCREM'], [strAutInc]);
      strAutInc := fRetornaAutoIncremCadFis(LeftStr(strDocume, 12), Copy(strDocume, 13, 2), Copy(strDocume, 15, 3), RightStr(strDocume, 8));
    end;

    frmCadLivroFiscal.strAutoincrem := strAutInc;
    frmCadLivroFiscal.ShowModal;
  finally
    pFreeAndNil(frmCadLivroFiscal);
  end;
end;

procedure TChamarDocOrigem.ChamarManutencaoDeCartoes(strAutInc: string);
  Var
    frmCadMovCartoes : TfrmCadMovCartoes;
begin
  pCriarFormularios(TfrmCadMovCartoes, frmCadMovCartoes);
  try
    if fSetouValorNaPropriedadeSeExiste(frmCadMovCartoes, 'strAutoincrem', strAutInc) then
      frmCadMovCartoes.ShowModal
    else
      fMensagem('','Recurso não implementado, [ChamarManutencaoDeCartoes()]!', ['&OK']);
  finally
    pFreeAndNil(frmCadMovCartoes);
  end;
end;

procedure TChamarDocOrigem.ChamarManutencaoDeCheques(strAutInc: string);
begin
  pCriarFormularios(TfrmCadCheques, frmCadCheques);
  try
    frmCadCheques.strAutIncCadChq := strAutInc;
    frmCadCheques.ShowModal;
  finally
    pFreeAndNil(frmCadCheques);
  end;
end;

procedure TChamarDocOrigem.ChamarMovimentoBancario(strAutInc: string);
begin
  pCriarFormularios(TfrmCadMovBancario, frmCadMovBancario);
  try
    frmCadMovBancario.strAutoIncremLoc := strAutInc;
    frmCadMovBancario.blnCarregaMovimento := True;
    frmCadMovBancario.ShowModal;
  finally
    pFreeAndNil(frmCadMovBancario);
  end;
end;

constructor TChamarDocOrigem.Create(strTipLan, strChvDoc, strTabela: String);
begin
  FTipLan := strTipLan;
  FChvDoc := strChvDoc;
  FTabela := strTabela;
end;

class function TChamarDocOrigem.New(strTipLan, strChvDoc, strTabela: String): IChamarDocOrigem;
begin
  Result := Self.Create(strTipLan, strChvDoc, strTabela);
end;

procedure TChamarDocOrigem.Chamar;
begin
  if (FTipLan = 'OUE') Or
     (FTipLan = 'ENT') Or
     (FTipLan = 'COE') Or
     (FTipLan = 'COS') Or
     (FTipLan = 'SAI') Or
     (FTipLan = 'SES') Or
     (FTipLan = 'SEE') then
    ChamarLivroFiscal(FChvDoc)
  else if (FTipLan = 'CHQ') then
    ChamarManutencaoDeCheques(FChvDoc)
  else if (FTipLan = 'BAN') then
    ChamarMovimentoBancario(FChvDoc)
  else if ((FTipLan = 'CTR') or (FTipLan = 'PCR') or (FTipLan = 'CRC')) then
    ChamarContasAReceber(FChvDoc)
  else if ((FTipLan = 'CTP') or (FTipLan = 'PCP')) then
    ChamarContasAPagar(FChvDoc)
  else if (FTipLan = 'CAR') then
    ChamarManutencaoDeCartoes(FChvDoc);
end;

end.
