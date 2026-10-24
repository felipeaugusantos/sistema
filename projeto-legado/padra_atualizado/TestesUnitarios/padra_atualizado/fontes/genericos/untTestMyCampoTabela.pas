unit untTestMyCampoTabela;

interface

uses System.Classes, System.Contnrs, System.SysUtils, System.Variants,
  Shared.Functions.DataSet, untTestObjMyCampoTabela;

Type
  TObjectVariant = Class(TObject)
  private
    FValor: Variant;
  public
    Constructor Create(AValor: Variant);
  End;

type
  TTestMyCampoTabela = class(TInterfacedObject, IMyCampoTabela, IMyCampoTabelaAdd)
  private
    FChaves: TStringList;
    FValores: TObjectList;

    function BuscaChave(const AFieldName: String): Integer;
  public
    procedure Add(AName: string; AValue: Variant);

    function FieldByName(const AFieldName: String): TMyCampoTabelaValue;
    function Fields(const AFieldIndex: Integer): TMyCampoTabelaValue;
    function Count: TMyCampoTabelaValue;
    function HasField(const AFieldName: String): Boolean;

    constructor Create;
    destructor Destroy; override;
  end;

type
  TMyCampoTabelaDefault = class
  public
    class procedure IniciarCamposDefault;
  end;

type
  ECampoTabelaNaoEncontrado = class(Exception);

implementation

{ TTestMyCampoTabela }

procedure TTestMyCampoTabela.Add(AName: string; AValue: Variant);
var
  intChave: Integer;
  obj: TObject;
begin
  intChave := BuscaChave(AName);

  If intChave = -1 Then
  Begin
    FChaves.Add(AName);
    FValores.Add(TObjectVariant.Create(AValue));
    Exit;
  End;

  obj := FValores[intChave];
  FreeAndNil(obj);
  FValores[intChave] := TObjectVariant.Create(AValue);
end;

function TTestMyCampoTabela.BuscaChave(const AFieldName: String): Integer;
  Var
    intContador: Integer;
begin
  Result := -1;

  For intContador := 0 To FChaves.Count -1 Do
  Begin
    If (FChaves[intContador] = AFieldName) Then
    Begin
      Result := intContador;
      Break;
    End;
  End;
end;

function TTestMyCampoTabela.Count: TMyCampoTabelaValue;
begin
  Result := FChaves.Count;
end;

constructor TTestMyCampoTabela.Create;
begin
  inherited Create;

  FChaves  := TStringList.Create;
  FValores := TObjectList.Create(False);
end;

destructor TTestMyCampoTabela.Destroy;
  Var
    intCont: Integer;
    obj: TObject;
begin
  For intCont := 0 To FValores.Count -1 Do
  Begin
    If Assigned(FValores[intCont]) And
      (FValores[intCont] Is TObjectVariant) Then
    Begin
      obj := FValores[intCont];
      FreeAndNil(obj);
    End;
  End;

  FChaves.Clear;
  FValores.Clear;
  FreeAndNil(FChaves);
  FreeAndNil(FValores);

  inherited;
end;

function TTestMyCampoTabela.FieldByName(const AFieldName: String): TMyCampoTabelaValue;
  Var
    intPos: Integer;
begin
  Result := Null;
  intPos := BuscaChave(AFieldName);

  If intPos > -1 Then
    Result := TObjectVariant(FValores[intPos]).FValor;

  If intPos = -1 Then
    raise ECampoTabelaNaoEncontrado.Create('O Campo "' + AFieldName +
      '" não existe ou não foi informado no dicionário do fCampoTabela!');
end;

function TTestMyCampoTabela.Fields(
  const AFieldIndex: Integer): TMyCampoTabelaValue;
begin
 //
end;

function TTestMyCampoTabela.HasField(const AFieldName: String): Boolean;
begin
  Result := BuscaChave(AFieldName) <> -1;
end;

{ TObjectVariant }

constructor TObjectVariant.Create(AValor: Variant);
begin
  FValor := AValor;
end;

procedure pIniciarModelCamposDefault;
begin
  //Cliente
  objMyCampoTabelaAdd.Add('CLI_SITIPI', 'T');
  objMyCampoTabelaAdd.Add('CLI_ZONFRA', 'N');
  objMyCampoTabelaAdd.Add('CLI_SUFRAM', 'N');
  objMyCampoTabelaAdd.Add('CLI_DESZON', 'N');
  objMyCampoTabelaAdd.Add('CLI_ORGPUB', 'N');
  objMyCampoTabelaAdd.Add('ClI_ESTADO', 'SP');
  objMyCampoTabelaAdd.Add('CLI_CONSUM', 'N');
  objMyCampoTabelaAdd.Add('CLI_CODATI', '002');

  objMyCampoTabelaAdd.Add('CLI_REGFIS', '1');
  objMyCampoTabelaAdd.Add('CLI_I_E_S_', '105006071117');
  objMyCampoTabelaAdd.Add('CLI_MICEMP', 'N');
  objMyCampoTabelaAdd.Add('CLI_CALICM', 'N');
  objMyCampoTabelaAdd.Add('CLI_INDCOM', 'C');
  objMyCampoTabelaAdd.Add('CLI_IVAESP', 0);
  objMyCampoTabelaAdd.Add('CLI_IVASIM', 0);
  objMyCampoTabelaAdd.Add('CLI_IVANAC', 0);



  objMyCampoTabelaAdd.Add('CLI_CGCCPF', 1);
  objMyCampoTabelaAdd.Add('FOR_CGCCPF', 1);

  objMyCampoTabelaAdd.Add('ENT_ESTADO', 'SP');
  objMyCampoTabelaAdd.Add('ENT_COIBGE', '3543402');

  objMyCampoTabelaAdd.Add('CLI_SIBICM', 'N');
  objMyCampoTabelaAdd.Add('CLI_STREES', 'N');
  objMyCampoTabelaAdd.Add('CLI_REDICM', 0);
  objMyCampoTabelaAdd.Add('CLI_DIF_ST', 'N');
  objMyCampoTabelaAdd.Add('CLI_ORPURD', 'N');

  objMyCampoTabelaAdd.Add('CLI_C_G_C_','350.354.854.15');
  objMyCampoTabelaAdd.Add('CLI_ALQIRF',10);
  objMyCampoTabelaAdd.Add('CLI_ALQPIS',10);
  objMyCampoTabelaAdd.Add('CLI_ALQCOF',10);
  objMyCampoTabelaAdd.Add('CLI_ALQCSL',10);
  objMyCampoTabelaAdd.Add('CLI_RETIRF',10);
  objMyCampoTabelaAdd.Add('CLI_RETPCO',10);

  objMyCampoTabelaAdd.Add('CLI_CEDESP',0);
  objMyCampoTabelaAdd.Add('CLI_CEDSIM',0);
  objMyCampoTabelaAdd.Add('CLI_CEDNAC',0);
  objMyCampoTabelaAdd.Add('CED_NCMITE','');

  objMyCampoTabelaAdd.Add('CLI_DESPIS', 'N');
  objMyCampoTabelaAdd.Add('CLI_BENREI', 'N');
  objMyCampoTabelaAdd.Add('CLI_ICMREI', 'N');

  objMyCampoTabelaAdd.Add('CLI_PRORUR', '');
  objMyCampoTabelaAdd.Add('CLI_IESUNI', '');
  objMyCampoTabelaAdd.Add('CLI_ORPUDF', 'N');
  objMyCampoTabelaAdd.Add('CLI_ATODDF', 'N');
  objMyCampoTabelaAdd.Add('CLI_RECALI', 'N');

  //Empresa
  objMyCampoTabelaAdd.Add('EMP_ESTADO', 'SP');
  objMyCampoTabelaAdd.Add('EMP_COIBGE', '3543402');

  //Fornecedor
  objMyCampoTabelaAdd.Add('FOR_MATREV', 'D');
  objMyCampoTabelaAdd.Add('FOR_ESTADO', 'SP');
  objMyCampoTabelaAdd.Add('FOR_I_E_S_', '');
  objMyCampoTabelaAdd.Add('SIMPAU', 'N');
  objMyCampoTabelaAdd.Add('TIPFOR', 'A');

  //Produto
  objMyCampoTabelaAdd.Add('ITE_IPISAI', 0);
  objMyCampoTabelaAdd.Add('ITE_ITECCR', 'N');
  objMyCampoTabelaAdd.Add('ITEGER_CODABF', '004');
  objMyCampoTabelaAdd.Add('CADITE_CODABF', '002');
  objMyCampoTabelaAdd.Add('ITEGER_IMPDIR', 'N');
  objMyCampoTabelaAdd.Add('CADITE_IMPDIR', 'N');
  objMyCampoTabelaAdd.Add('ITE_CODFOR', '00000001');
  objMyCampoTabelaAdd.Add('ITE_IPIENT', 0);
  objMyCampoTabelaAdd.Add('ITE_FREENT', 0);
  objMyCampoTabelaAdd.Add('CADITE_INDREV', 'I');
  objMyCampoTabelaAdd.Add('ITEGER_INDREV', 'I');
  objMyCampoTabelaAdd.Add('ITE_ATODDF', 'N');

  //Abreviacao de icms
  objMyCampoTabelaAdd.Add('ABF_RICMPR_SAI_CNC', 'N');
  objMyCampoTabelaAdd.Add('ABF_RICMPR_SAI_NCO', 'N');
  objMyCampoTabelaAdd.Add('ABF_RICMPR_ENT_PEF', 'N');
  objMyCampoTabelaAdd.Add('ABF_RICMPR_SAI_CTA', 'N');
  objMyCampoTabelaAdd.Add('ABF_RICMPR_ENT_PEJ', 'N');
  objMyCampoTabelaAdd.Add('ABF_RICMPR_SAI_SNA', 'N');
  objMyCampoTabelaAdd.Add('ABF_ALQRIC_SAI_SNA', 0);
  objMyCampoTabelaAdd.Add('ABF_ALQRIC_SAI_NCO', 0);
  objMyCampoTabelaAdd.Add('ABF_ALQRED_ENT_PEF', 0);
  objMyCampoTabelaAdd.Add('ABF_ALQRED_ENT_PEJ', 0);
  objMyCampoTabelaAdd.Add('ABF_ALQRED_ENT_PER', 0);
  objMyCampoTabelaAdd.Add('ABF_ALQRED_SAI_NCO', 0);
  objMyCampoTabelaAdd.Add('ABF_ALQRED_SAI_CNC', 0);
  objMyCampoTabelaAdd.Add('ABF_ALQRED_SAI_CTA', 0);
  objMyCampoTabelaAdd.Add('ABF_ALQRED_SAI_PRU', 0);
  objMyCampoTabelaAdd.Add('ABF_ALQRED_SAI_IND', 0);
  objMyCampoTabelaAdd.Add('ABF_ALQRED_SAI_TRS', 0);
  objMyCampoTabelaAdd.Add('ABF_ALQRED_ENT_PES', 0);
  objMyCampoTabelaAdd.Add('ABF_ALQRED_ENT_PSI', 0);
  objMyCampoTabelaAdd.Add('ABF_ALQRED_ENT_PII', 0);
  objMyCampoTabelaAdd.Add('ABF_ALQRED_SAI_SNA', 0);
  objMyCampoTabelaAdd.Add('ABF_ALQRED_SAI_CCO', 0);

  // Preco de Custo -> Pegar a cotação da moeda

  objMyCampoTabelaAdd.Add('MOE_DTAMOE','2019-12-13');
  objMyCampoTabelaAdd.Add('MOE_DOLCOM',1.20);
  objMyCampoTabelaAdd.Add('MOE_DOLVEN',1.10);
  objMyCampoTabelaAdd.Add('MOE_REACOM',0);
  objMyCampoTabelaAdd.Add('MOE_REAVEN',0);
  objMyCampoTabelaAdd.Add('MOE_PARCOM',0.069000);
  objMyCampoTabelaAdd.Add('MOE_PARVEN',0.069000);
  objMyCampoTabelaAdd.Add('MOE_EURCOM',4.560000);
  objMyCampoTabelaAdd.Add('MOE_EURVEN',4.560000);
  objMyCampoTabelaAdd.Add('MOE_GUACOM',0.000640);
  objMyCampoTabelaAdd.Add('MOE_GUAVEN',0.000640);
  objMyCampoTabelaAdd.Add('MOE_CODEMP','012');
  objMyCampoTabelaAdd.Add('AUTOINCREM','02500000000000789012');

  objMyCampoTabelaAdd.Add('ABF_CODSIT_ENT_PES', 'N');
  objMyCampoTabelaAdd.Add('ABF_BASICM_ENT_PES', 'N');
  objMyCampoTabelaAdd.Add('ABF_ALQICM_ENT_PES', 'N');
  objMyCampoTabelaAdd.Add('ABF_BASRET_ENT_PES', 'N');
  objMyCampoTabelaAdd.Add('ABF_ALQRET_ENT_PES', 'N');
  objMyCampoTabelaAdd.Add('ABF_IVA_ST_ENT_PES', 'N');
  objMyCampoTabelaAdd.Add('ABF_ALQEFO_ENT_PES', 'N');
  objMyCampoTabelaAdd.Add('ABF_ALQFCP_ENT_PES', 'N');
  objMyCampoTabelaAdd.Add('ABF_BASDOR_ENT_PES', 'N');
  objMyCampoTabelaAdd.Add('ABF_BASDDS_ENT_PES', 'N');
  objMyCampoTabelaAdd.Add('ABF_ALQIED_ENT_PES', 'N');
  objMyCampoTabelaAdd.Add('ABF_CODBEN_ENT_PES', 'N');
  objMyCampoTabelaAdd.Add('ABF_RICMPR_ENT_PES', 'N');

  objMyCampoTabelaAdd.Add('ABF_CODSIT_ENT_PSI', 'N');
  objMyCampoTabelaAdd.Add('ABF_BASICM_ENT_PSI', 'N');
  objMyCampoTabelaAdd.Add('ABF_ALQICM_ENT_PSI', 'N');
  objMyCampoTabelaAdd.Add('ABF_BASRET_ENT_PSI', 'N');
  objMyCampoTabelaAdd.Add('ABF_ALQRET_ENT_PSI', 'N');
  objMyCampoTabelaAdd.Add('ABF_IVA_ST_ENT_PSI', 'N');
  objMyCampoTabelaAdd.Add('ABF_ALQEFO_ENT_PSI', 'N');
  objMyCampoTabelaAdd.Add('ABF_ALQFCP_ENT_PSI', 'N');
  objMyCampoTabelaAdd.Add('ABF_BASDOR_ENT_PSI', 'N');
  objMyCampoTabelaAdd.Add('ABF_BASDDS_ENT_PSI', 'N');
  objMyCampoTabelaAdd.Add('ABF_ALQIED_ENT_PSI', 'N');
  objMyCampoTabelaAdd.Add('ABF_CODBEN_ENT_PSI', 'N');
  objMyCampoTabelaAdd.Add('ABF_RICMPR_ENT_PSI', 'N');
  
  objMyCampoTabelaAdd.Add('ABF_CODSIT_ENT_PII', 'N');
  objMyCampoTabelaAdd.Add('ABF_BASICM_ENT_PII', 'N');
  objMyCampoTabelaAdd.Add('ABF_ALQICM_ENT_PII', 'N');
  objMyCampoTabelaAdd.Add('ABF_BASRET_ENT_PII', 'N');
  objMyCampoTabelaAdd.Add('ABF_ALQRET_ENT_PII', 'N');
  objMyCampoTabelaAdd.Add('ABF_IVA_ST_ENT_PII', 'N');
  objMyCampoTabelaAdd.Add('ABF_ALQEFO_ENT_PII', 'N');
  objMyCampoTabelaAdd.Add('ABF_ALQFCP_ENT_PII', 'N');
  objMyCampoTabelaAdd.Add('ABF_BASDOR_ENT_PII', 'N');
  objMyCampoTabelaAdd.Add('ABF_BASDDS_ENT_PII', 'N');
  objMyCampoTabelaAdd.Add('ABF_ALQIED_ENT_PII', 'N');
  objMyCampoTabelaAdd.Add('ABF_CODBEN_ENT_PII', 'N');
  objMyCampoTabelaAdd.Add('ABF_RICMPR_ENT_PII', 'N');  

end;

{ TMyCampoTabelaDefault }

class procedure TMyCampoTabelaDefault.IniciarCamposDefault;
begin
  pIniciarModelCamposDefault;
end;

initialization

SetarObjMyCampoTabela(TTestMyCampoTabela.Create);

pIniciarModelCamposDefault;

end.
