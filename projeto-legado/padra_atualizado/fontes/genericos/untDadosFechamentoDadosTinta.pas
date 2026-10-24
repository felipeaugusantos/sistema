unit untDadosFechamentoDadosTinta;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls, Forms, Dialogs,
  untIDadosTintasComponentes,Uni, untIDadosTinta, UniClientDataSet;

type
  TDadosFechamentoDadosTinta = class(TInterfacedObject, IDadosTinta)
  private
    cdsDados: TUniClientDataSet;
    lstDadosTintasComponentes: IInterfaceList;
    procedure PreencheComponentes;
    procedure CriaCdsDados(const cdsVenda: TUniClientDataSet);
  public
    constructor Create(const cdsVenda: TUniClientDataSet);
    destructor Destroy; override;
    function GetAno: string;
    function GetBase: string;
    function GetComponentes(const Index: Integer): IDadosTintasComponentes;
    function GetComponentesCount: Integer;
    function GetDescontoEspecial: Double;
    function GetEmbalagem: string;
    function GetEmpresa: string;
    function GetEmpresaPrd : String;
    function GetFatorAcerto: Double;
    function GetIdePro: string;
    function GetIteTin: string;
    function GetLinha: string;
    function GetMontadora: string;
    function GetQuantidade: Double;
    function GetQuantidadeEmbalagem: Double;
    function GetTabelaPreco: string;
    function GetTipoPreco: string;
    function GetVolume: Double;
    function GetDescricao: string;
    function GetRecNo: Integer;
    function GetCatalisador: string;
    function GetPerfomanceAgent: String;
    property Ano: string read GetAno;
    property Base: string read GetBase;
    property Componentes[const Index: Integer]: IDadosTintasComponentes read
        GetComponentes;
    property ComponentesCount: Integer read GetComponentesCount;
    property DescontoEspecial: Double read GetDescontoEspecial;
    property Embalagem: string read GetEmbalagem;
    property Empresa: string read GetEmpresa;
    property EmpresaPrd: string read GetEmpresaPrd;
    property FatorAcerto: Double read GetFatorAcerto;
    property IdePro: string read GetIdePro;
    property IteTin: string read GetIteTin;
    property Linha: string read GetLinha;
    property Montadora: string read GetMontadora;
    property Quantidade: Double read GetQuantidade;
    property QuantidadeEmbalagem: Double read GetQuantidadeEmbalagem;
    property TabelaPreco: string read GetTabelaPreco;
    property TipoPreco: string read GetTipoPreco;
    property Volume: Double read GetVolume;
    property Catalisador: string read GetCatalisador;
    property PerformanceAgent: String read GetPerfomanceAgent;
  end;


implementation

uses  untFuncoesSimples, untFuncTinta, untGenericDadosTintasComponentes;

{
************************** TDadosFechamentoDadosTinta **************************
}
constructor TDadosFechamentoDadosTinta.Create(const cdsVenda: TUniClientDataSet);
begin
  inherited Create();
  CriaCdsDados(cdsVenda);
  Self.lstDadosTintasComponentes := TInterfaceList.Create;
  PreencheComponentes;
end;

procedure TDadosFechamentoDadosTinta.CriaCdsDados(const cdsVenda: TUniClientDataSet);
var
  intRecNo: Integer;
begin
  intRecNo := 0;
  Try
    Try
      intRecNo := cdsVenda.RecNo;
      cdsVenda.DisableConstraints;
      cdsVenda.DisableControls;

      Self.cdsDados := TUniClientDataSet.Create(nil);
      Self.cdsDados.Data := cdsVenda.Data;
      Self.cdsDados.Locate('AUTOINCREM',cdsVenda.FieldByName('AUTOINCREM').AsInteger, []);
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    cdsVenda.RecNo := intRecNo;
    cdsVenda.EnableConstraints;
    cdsVenda.EnableControls;
  End;

end;

destructor TDadosFechamentoDadosTinta.Destroy;
begin
  if Assigned(lstDadosTintasComponentes) then FreeAndNil(lstDadosTintasComponentes);
  if Assigned(cdsDados) then FreeAndNil(cdsDados);
  inherited;
end;

procedure TDadosFechamentoDadosTinta.PreencheComponentes;
var
  intCont: Integer;
  qryArqFor: TUniQuery;
  forMulTinDetArray: TForMulTinDetArray;
  baixaPigmentosArray: TBaixaPigmentosArray;
  stlItensTraMl: TStringList;
begin
  qryArqFor := nil;
  stlItensTraMl := nil;
  Try
    Try
      qryArqFor := fCriaQuery();
      stlItensTraMl := TStringList.Create;

      if not fGTinForGeral(cdsDados.FieldByName('ITE_IDEPRO').AsString,
        cdsDados.FieldByName('ITE_ITETIN').AsString,
        cdsDados.FieldByName('ITE_TIPPRE').AsString,
        cdsDados.FieldByName('ITE_LINTIN').AsString,
        cdsDados.FieldByName('ITE_CATALI').AsString,
        cdsDados.FieldByName('ITE_LAZQUA').AsInteger,
        cdsDados.FieldByName('ITE_QTDEMB').AsFloat,
        cdsDados.FieldByName('ITE_QTDITE').AsFloat,
        cdsDados.FieldByName('ITE_DESITE').AsString,
        qryArqFor,
        cdsDados.FieldByName('ITE_VOLPRO').AsFloat,
        forMulTinDetArray,
        baixaPigmentosArray,
        stlItensTraMl,
        cdsDados.FieldByName('ITE_CODDIL').AsString,
        cdsDados.FieldByName('ITE_PORDIL').AsFloat,
        cdsDados.FieldByName('ITE_DILCON').AsString,
        cdsDados.FieldByName('ITE_PORCAT').AsFloat,
        cdsDados.FieldByName('FOR_TIPCOR').AsString,
        cdsDados.FieldByName('FOR_TEXBAS').AsString,
        cdsDados.FieldByName('FOR_MODDIL').AsInteger,
        cdsDados.FieldByName('FOR_ITECOB').AsString,
        cdsDados.FieldByName('ITE_EMPPRD').AsString,
        cdsDados.FieldByName('ITE_PORPER').AsString) then
        Exit;

      For intCont := Low(forMulTinDetArray) To High(forMulTinDetArray) Do
      begin
        if fEmptyStr(forMulTinDetArray[intCont].strFormul) then
          Continue;

        if forMulTinDetArray[intCont].fltQtdbas <= 0 then
          Continue;

        lstDadosTintasComponentes.Add(TGenericDadosTintasComponentes.Create(forMulTinDetArray[intCont].strFormul,
          forMulTinDetArray[intCont].fltQtdbas * cdsDados.FieldByName('ITE_QTDITE').AsFloat));
      end;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryArqFor) then FreeAndNil(qryArqFor);
    if Assigned(stlItensTraMl) then FreeAndNil(stlItensTraMl);
  End;
end;

function TDadosFechamentoDadosTinta.GetAno: string;
begin
  Result := cdsDados.FieldByName('ITE_A_N_O_').AsString;
end;

function TDadosFechamentoDadosTinta.GetBase: string;
begin
  Result := cdsDados.FieldByName('ITE_CODITE').AsString;
end;

function TDadosFechamentoDadosTinta.GetCatalisador: string;
begin
  Result := cdsDados.FieldByName('ITE_CATALI').AsString;
end;

function TDadosFechamentoDadosTinta.GetComponentes(const Index: Integer):
    IDadosTintasComponentes;
begin
  Result := (lstDadosTintasComponentes[Index] as IDadosTintasComponentes)
end;

function TDadosFechamentoDadosTinta.GetComponentesCount: Integer;
begin
  Result := lstDadosTintasComponentes.Count;
end;

function TDadosFechamentoDadosTinta.GetDescontoEspecial: Double;
begin
  Result := cdsDados.FieldByName('ITE_DESESP').AsFloat;
end;

function TDadosFechamentoDadosTinta.GetDescricao: string;
begin
  Result := cdsDados.FieldByName('ITE_DESITE').AsString;
end;

function TDadosFechamentoDadosTinta.GetEmbalagem: string;
begin
  Result := cdsDados.FieldByName('ITE_ITEEMB').AsString;
end;

function TDadosFechamentoDadosTinta.GetEmpresa: string;
begin
  Result := VS_strCodEmp;
end;

function TDadosFechamentoDadosTinta.GetEmpresaPrd: String;
begin
  Result := cdsDados.FieldByName('ITE_EMPPRD').AsString;
end;

function TDadosFechamentoDadosTinta.GetFatorAcerto: Double;
begin
  Result := cdsDados.FieldByName('ITE_FATACE').AsFloat;
end;

function TDadosFechamentoDadosTinta.GetIdePro: string;
begin
  Result := cdsDados.FieldByName('ITE_IDEPRO').AsString;
end;

function TDadosFechamentoDadosTinta.GetIteTin: string;
begin
  Result := cdsDados.FieldByName('ITE_ITETIN').AsString
end;

function TDadosFechamentoDadosTinta.GetLinha: string;
begin
  Result := cdsDados.FieldByName('ITE_LINTIN').AsString;
end;

function TDadosFechamentoDadosTinta.GetMontadora: string;
begin
  Result := cdsDados.FieldByName('ITE_MONTAD').AsString;
end;

function TDadosFechamentoDadosTinta.GetPerfomanceAgent: String;
begin
  Result := cdsDados.FieldByName('ITE_PORPER').AsString;
end;

function TDadosFechamentoDadosTinta.GetQuantidade: Double;
begin
  Result := cdsDados.FieldByName('ITE_QTDITE').AsFloat;
end;

function TDadosFechamentoDadosTinta.GetQuantidadeEmbalagem: Double;
begin
  Result := cdsDados.FieldByName('ITE_QTDEMB').AsFloat;
end;

function TDadosFechamentoDadosTinta.GetRecNo: Integer;
begin
  Result := cdsDados.RecNo;
end;

function TDadosFechamentoDadosTinta.GetTabelaPreco: string;
begin
  Result := cdsDados.FieldByName('ITE_TABPRE').AsString;
end;

function TDadosFechamentoDadosTinta.GetTipoPreco: string;
begin
  Result := cdsDados.FieldByName('ITE_TIPPRE').AsString;
end;

function TDadosFechamentoDadosTinta.GetVolume: Double;
begin
  Result := cdsDados.FieldByName('ITE_VOLPRO').AsFloat;
end;

end.


