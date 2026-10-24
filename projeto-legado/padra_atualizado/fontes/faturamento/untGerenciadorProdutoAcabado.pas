unit untGerenciadorProdutoAcabado;

interface

uses
  Classes, untProdAcabado, untFuncFatTypes, Uni, SysUtils, untTipoTinta;

type
  TGerenciadorProdutoAcabado = class(TInterfacedObject)
  private
    lstProdutosAcabados: TStringList;
    function GetCount: Integer;
    function GetProdutoAcabado(const item: TDadosFechamento): TProdAcabado;
    function fRetornaPreVenProdAcabado(item: TDadosFechamento; const blnCliFil: Boolean;
      const strTabPre: string; const strTabTin: String): Double;
    procedure Limpar;
  public
    constructor Create();
    destructor Destroy; override;

    procedure Importar(const arrMatItens: TMatrizFechamento; const strOprFlj: string;
      const fatVendasCalculadorWrapper: TObject; const blnCliFil: Boolean;
      const strTabPre: string; const strTabTin: String; const strEspDoc: String);
    property Count: Integer read GetCount;
    property ProdutoAcabado[const item: TDadosFechamento]: TProdAcabado read GetProdutoAcabado;
  end;

implementation

uses
     untICalculadorFatVendas, untFuncoesSimples;

{ TGerenciadorProdutoAcabado }

procedure TGerenciadorProdutoAcabado.Importar(const arrMatItens: TMatrizFechamento;
  const strOprFlj: string; const fatVendasCalculadorWrapper: TObject;
  const blnCliFil: Boolean; const strTabPre: string; const strTabTin: String;
  const strEspDoc: String);
var
  objProdAcabado: TProdAcabado;
  intCont: Integer;
  arrBaixaPigmentos: TBaixaPigmentosArray;
  stlItensTraMl: TStringList;
  dicRetorno: TDicionario;
  qryTintaAux: TUniQuery;
begin
  dicRetorno := nil;
  stlItensTraMl := nil;
  qryTintaAux := nil;
  Try
    Try
      qryTintaAux := fCriaQuery();
      Limpar;
      for intCont := 0 to Length(arrMatItens) - 1 do
      begin
        if not ((arrMatItens[intCont].strIdePro <> 'NOR') and (arrMatItens[intCont].strProEmb <> 'S')) then
          Continue;

        objProdAcabado := TProdAcabado.Create(arrMatItens[intCont].fltPreCus,
                                              fRetornaPreVenProdAcabado(arrMatItens[intCont],
                                              blnCliFil,
                                              strTabPre,
                                              strTabTin));
        objProdAcabado.strDescri := arrMatItens[intCont].strDesIte;
        objProdAcabado.strIdePro := arrMatItens[intCont].strIdePro;
        objProdAcabado.strCodIte := arrMatItens[intCont].strCodIte;
        objProdAcabado.strOprFlj := strOprFlj;
        objProdAcabado.strEspDoc := strEspDoc;
        objProdAcabado.fltQtdPro := arrMatItens[intCont].fltQtdIte;
        objProdAcabado.strBrinde := arrMatItens[intCont].strBrinde;

        dicRetorno := TDicionario.Create;
        SetLength(arrBaixaPigmentos, 0);
        stlItensTraMl := TStringList.Create;

        dicRetorno['itebas'] := arrMatItens[intCont].strCodIte;
        dicRetorno['iteemb'] := arrMatItens[intCont].strIteEmb;
        dicRetorno['complementob'] := arrMatItens[intCont].recForTin.strCompB;
        dicRetorno['fatace'] := arrMatItens[intCont].fltFatAce;
        dicRetorno['iteemb'] := arrMatItens[intCont].strIteEmb;
        dicRetorno['descri'] := arrMatItens[intCont].strDesIte;

        dicRetorno['empite'] := arrMatItens[intCont].strEmpIte;
        if fEmptyStr(dicRetorno['empite']) then
          dicRetorno['empite'] := arrMatItens[intCont].strEmpPrd;
        if fEmptyStr(dicRetorno['empite']) then
          dicRetorno['empite'] := VS_strCodEmp;

        qryTintaAux := fCriaQuery();

        if Assigned(fatVendasCalculadorWrapper) then
        begin
          if Supports(fatVendasCalculadorWrapper, ICalculadorFatVendas) then
            dicRetorno.AdicionarObjeto('calculadorFatVendas', fatVendasCalculadorWrapper);
        end;

        dicRetorno['preve1'] := arrMatItens[intCont].fltPreVe1;
        dicRetorno['preve2'] := arrMatItens[intCont].fltPreVe2;
        dicRetorno['preve3'] := arrMatItens[intCont].fltPreVe3;
        dicRetorno['preve4'] := arrMatItens[intCont].fltPreVe4;
        dicRetorno['preve5'] := arrMatItens[intCont].fltPreVe5;
        dicRetorno['preve6'] := arrMatItens[intCont].fltPreVe6;
        dicRetorno['preve7'] := arrMatItens[intCont].fltPreVe7;
        dicRetorno['premed'] := arrMatItens[intCont].fltPreMed;
        dicRetorno['impult'] := arrMatItens[intCont].fltImpUlt;
        dicRetorno['preult'] := arrMatItens[intCont].fltTotUlt / arrMatItens[intCont].fltQtdIte;
        dicRetorno['outval'] := arrMatItens[intCont].fltOutVal;
        dicRetorno['icmsai'] := arrMatItens[intCont].fltICMSai * arrMatItens[intCont].fltUniOri / 100;
        dicRetorno['impfed'] := arrMatItens[intCont].fltImpFed * arrMatItens[intCont].fltUniOri / 100;
        dicRetorno['desope'] := arrMatItens[intCont].fltDesOpe * arrMatItens[intCont].fltUniOri / 100;
        dicRetorno['prctin'] := arrMatItens[intCont].fltPrcTin;

        objProdAcabado.pImportarTabelasPreco(dicRetorno);
        lstProdutosAcabados.AddObject(IntToStr(arrMatItens[intCont].intAutInc), objProdAcabado);
      end;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(dicRetorno) then FreeAndNil(dicRetorno);
    if Assigned(stlItensTraMl) then FreeAndNil(stlItensTraMl);
    if Assigned(qryTintaAux) then FreeAndNil(qryTintaAux);
  End;
end;

procedure TGerenciadorProdutoAcabado.Limpar;
var
  intCont: Integer;
begin
  for intCont := 0 to lstProdutosAcabados.Count - 1 do
  begin
    Try
      Try
        if Assigned(lstProdutosAcabados.Objects[intCont]) then
          lstProdutosAcabados.Objects[intCont].Free;
      Except
        on E: Exception do
        begin
        end;
      End;
    Finally
    End;    
  end;
  lstProdutosAcabados.Clear;
end;

constructor TGerenciadorProdutoAcabado.Create;
begin
  inherited Create;
  lstProdutosAcabados := TStringList.Create;
end;

destructor TGerenciadorProdutoAcabado.Destroy;
begin
  Limpar;
  if Assigned(lstProdutosAcabados) then FreeAndNil(lstProdutosAcabados);
  inherited;
end;

function TGerenciadorProdutoAcabado.fRetornaPreVenProdAcabado(item: TDadosFechamento;
  const blnCliFil: Boolean; const strTabPre: string; const strTabTin: String): Double;
  Var
    strTabela: String;
begin
  strTabela := strTabPre;

  If Not fEmptyStr(strTabTin) Then
    strTabela := strTabTin;

  If (blnCliFil) Then
  Begin
    If (strTabela = '1') Then
      Result := item.fltPreVe1
    Else If (strTabela = '2') Then
      Result := item.fltPreVe2
    Else If (strTabela = '3') Then
      Result := item.fltPreVe3
    Else If (strTabela = '4') Then
      Result := item.fltPreVe4
    Else If (strTabela = '5') Then
      Result := item.fltPreVe5
    Else If (strTabela = '6') Then
      Result := item.fltPreVe6
    Else If (strTabela = '7') Then
      Result := item.fltPreVe7
    Else
      Result := item.fltPreVe1;
  End
  Else
    Result := item.fltUniTar;
end;

function TGerenciadorProdutoAcabado.GetCount: Integer;
begin
  Result := lstProdutosAcabados.Count;
end;

function TGerenciadorProdutoAcabado.GetProdutoAcabado(const item: TDadosFechamento): TProdAcabado;
begin
  Result := lstProdutosAcabados.Objects[lstProdutosAcabados.IndexOf(IntToStr(item.intAutInc))] as TProdAcabado;
end;

end.
