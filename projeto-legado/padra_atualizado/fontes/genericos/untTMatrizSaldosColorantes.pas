unit untTMatrizSaldosColorantes;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
  Shared.Core,
  untFuncoesGenerica,
{$ELSE}
  untFuncoesSimples,
{$ENDIF}
  Uni, SysUtils, untIIdentificadorTinta, Classes, REST.Json;

{**************************************************}
{* INFORMACOES NECESSARIAS PARA TRAVA DE ESTOQUE  *}
{* DOS COLORANTES / BASES DAS TINTAS              *}
{***********************************************PH*}
Type
  TSaldosColorantes = Record
    intIDTinta:Integer;
    strDescTinta: String;
    strCodIte: String;
    strDesIte: String;
    strCodCol: String;
    fltQtdFormula: Double;
    fltQtdFormOri: Double;
    fltQtdFormAcu: Double;//Acumulado na Venda
    fltSaldoML: Double;
    strBasCol: String;
    strPesGra: String;
    fltEmbala: Double;
    strEmpPrd: String;
  End;
  TMatrizSaldosColorantes = Array of TSaldosColorantes;


  TClassMatrizSaldosColorantes = class
  private
    FmatrizSaldosColorantes: TMatrizSaldosColorantes;
    FstrCodEmp: String;
    function GetCount: Integer;
    function GetMatrizSaldosColorantes(index: Integer): TSaldosColorantes;
    function GetblnTemSaldo: Boolean;
    procedure SetstrCodEmp(const Value: String);
    function fGetQuantidadeTinta(): Double;

    function fSaldoMLLotePrincipalTinta(strCodIte, strNumPed: String; const fltSalMLAtual: Double): Double;//JDTINTAS

    function fSaldoMLLoteTinta(strCodIte,
                               strNumPed: String;
                               const fltSalMLAtual: Double;
                               strNumLot: String = ''): Double;

    function fRecalculaSaldosInterna(strCodEmp: String;
                                     fltQtdBas: Double;
                                     strNumPed: String = '';
                                     blnLotePrincipalTinta: Boolean = False;
                                     strNumLot: String = ''): Boolean;
  public
    constructor Create(matrizSaldosColorantes: TMatrizSaldosColorantes); overload;
    constructor Create(matrizSaldosColorantes: TClassMatrizSaldosColorantes); overload;
    constructor Create(); overload;

    function fAdicionar(saldosColorantes: TSaldosColorantes; strEmpPrd: String=''): TSaldosColorantes; overload;
    function fAdicionar(intIDTinta: Integer; saldosColorantes: TSaldosColorantes): TSaldosColorantes; overload;
    function fAdicionar(): TSaldosColorantes; overload;
    function fAdicionar(intIDTinta: Integer; strDescTinta, strCodIte, strDesIte, strCodCol: String; fltQtdFormula: Double; strBasCol: String; strPesGra: String; fltEmbala: Double): TSaldosColorantes; overload;

    function fGetIndiceSaldosColorantes(saldosColorantes: TSaldosColorantes): Integer;

    function fRecalculaSaldos(strCodEmp: String; strNumPed: String = ''): Boolean; overload;

    function fRecalculaSaldos(strCodEmp: String;
                              fltQtdBas: Double;
                              strNumPed: String = '';
                              blnLotePrincipalTinta: Boolean = False;
                              strNumLot: String = ''):Boolean; overload;

    function GetBaseColoranteTemSaldo(index: Integer): Boolean;
    procedure pAcumulaMatriz(var dicQtds: TDicionario; blnPorEmpPrd: Boolean=False; strEmpPrd: String='');
    function RecalcularAcumulados(const Formulacao: TClassMatrizSaldosColorantes; blnPorEmpPrd: Boolean=False): TClassMatrizSaldosColorantes;

    procedure pZerarQuantidadeFormulacao;
    procedure RecalcularFormulacao(const strCodEmpPrd: string; const identificador: IIdentificadorTinta);

    property Count: Integer read GetCount;
    property Items[index: Integer]: TSaldosColorantes read GetMatrizSaldosColorantes; default;
    property blnTemSaldo: Boolean read GetblnTemSaldo;
    property strCodEmp: String read FstrCodEmp write SetstrCodEmp;

    destructor Destroy; override;

    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TClassMatrizSaldosColorantes;
  End;

  Const
    BASE_AUTOMOTIVA: String = 'BA';
    EMBALAGEM: String = 'E';
    BASE_IMOBILIARIA: String = 'B';
    COLORANTE: String = 'C';
    CATALISADOR: String = 'CT';
  

implementation

uses DB, Math;

{ TClassMatrizSaldosColorantes }

constructor TClassMatrizSaldosColorantes.Create(
  matrizSaldosColorantes: TMatrizSaldosColorantes);
begin
  inherited Create();
  FmatrizSaldosColorantes := matrizSaldosColorantes;
end;

constructor TClassMatrizSaldosColorantes.Create();
begin
  inherited Create();
  SetLength(FmatrizSaldosColorantes, 0);
end;

constructor TClassMatrizSaldosColorantes.Create(matrizSaldosColorantes: TClassMatrizSaldosColorantes);
var
  intCont: Integer;
begin
  inherited Create();
  SetLength(FmatrizSaldosColorantes, 0);
  if Assigned(matrizSaldosColorantes) then
  begin
    For intCont := Low(matrizSaldosColorantes.FmatrizSaldosColorantes) To High(matrizSaldosColorantes.FmatrizSaldosColorantes) Do
    Begin
      fAdicionar(matrizSaldosColorantes[intCont]);
    End;
  end;
end;

destructor TClassMatrizSaldosColorantes.Destroy;
begin
  Try
    SetLength(FmatrizSaldosColorantes, 0);
  Except
  End;
  inherited;
end;

function TClassMatrizSaldosColorantes.fAdicionar(
  saldosColorantes: TSaldosColorantes; strEmpPrd: String=''): TSaldosColorantes;
begin
  SetLength(FmatrizSaldosColorantes, Length(FmatrizSaldosColorantes) + 1);
  FmatrizSaldosColorantes[Length(FmatrizSaldosColorantes) - 1] := saldosColorantes;
  FmatrizSaldosColorantes[Length(FmatrizSaldosColorantes) - 1].strEmpPrd := strEmpPrd;  
  Result := FmatrizSaldosColorantes[Length(FmatrizSaldosColorantes) - 1];
end;

function TClassMatrizSaldosColorantes.fAdicionar(intIDTinta: Integer;
  saldosColorantes: TSaldosColorantes): TSaldosColorantes;
begin
  SetLength(FmatrizSaldosColorantes, Length(FmatrizSaldosColorantes) + 1);
  FmatrizSaldosColorantes[Length(FmatrizSaldosColorantes) - 1] := saldosColorantes;
  FmatrizSaldosColorantes[Length(FmatrizSaldosColorantes) - 1].intIDTinta := intIDTinta;
  Result := FmatrizSaldosColorantes[Length(FmatrizSaldosColorantes) - 1];
end;

function TClassMatrizSaldosColorantes.fGetIndiceSaldosColorantes(saldosColorantes: TSaldosColorantes): Integer;
  Var
    intContador: Integer;
begin
  Result := -1;

  For intContador := Low(FmatrizSaldosColorantes) To High(FmatrizSaldosColorantes) Do
  Begin
    If (FmatrizSaldosColorantes[intContador].strCodIte = saldosColorantes.strCodIte) And
       (FmatrizSaldosColorantes[intContador].strBasCol = saldosColorantes.strBasCol) Then
    Begin
      Result := intContador;
      Break;
    End;
  End;
end;

function TClassMatrizSaldosColorantes.fAdicionar: TSaldosColorantes;
begin
  SetLength(FmatrizSaldosColorantes, Length(FmatrizSaldosColorantes) + 1);
  Result := FmatrizSaldosColorantes[Length(FmatrizSaldosColorantes) - 1];
end;

function TClassMatrizSaldosColorantes.GetBaseColoranteTemSaldo(index: Integer): Boolean;
var
  strTipTre: String;
  fltQtdVen: Double;
  saldoColorante: TSaldosColorantes;
begin
  strTipTre := fCfgSis('TIPTRE');
  Result := True;

  saldoColorante := FmatrizSaldosColorantes[index];

  If RoundTo(saldoColorante.fltQtdFormAcu, -6) > 0 Then
    fltQtdVen := RoundTo(saldoColorante.fltQtdFormAcu, -6)
  Else
    fltQtdVen := RoundTo(saldoColorante.fltQtdFormula, -6);

  {
    BA = BASE AUTOMOTIVA
    E = EMBALAGEM
    B = BASE IMOBILIARIA
    C = COLORANTE
    CT = CATALISADOR ADVANCE TINTOSYSTEM
  }

  {SE FOR CORANTE E O TIPO DA TRAVA FOR PARA CORANTES OU AMBOS, VER SALDO DO COMPONENTE}
  If (((saldoColorante.strBasCol = COLORANTE) Or
       (saldoColorante.strBasCol = CATALISADOR)) Or (saldoColorante.strBasCol = BASE_AUTOMOTIVA))
    And (Pos(strTipTre, '_C_A_') > 0) Then
  Begin
    if (fltQtdVen > 0) then
      Result := Result
        And (saldoColorante.fltSaldoML >= fltQtdVen);      
  End
  {CASO CONTRARIO, É BASE OU A EMBALAGEM, E SE O TIPO DA TRAVA FOR BASE/EMBALAGEM OU AMBOS, VERIFICAR SALDO}
  Else If (Pos(strTipTre, '_B_A_') > 0) Then
  Begin
    If (saldoColorante.strBasCol = BASE_IMOBILIARIA) Then
    Begin
      if (fltQtdVen > 0) then
        Result := Result And (saldoColorante.fltSaldoML >= fltQtdVen);
    End
    else If (saldoColorante.strBasCol = EMBALAGEM) Then
    Begin
      if (fltQtdVen > 0) then
        Result := Result And (saldoColorante.fltSaldoML >= fltQtdVen);
    End;
  End;
end;



function TClassMatrizSaldosColorantes.fRecalculaSaldos(strCodEmp: String; strNumPed: String = ''): Boolean;
begin
  Result := fRecalculaSaldos(strCodEmp, 0, strNumPed, false);
end;

function TClassMatrizSaldosColorantes.fGetQuantidadeTinta: Double;
  Var
    intCont: Integer;
begin
  Result := 0;
  For intCont := Low(FmatrizSaldosColorantes) To High(FmatrizSaldosColorantes) Do
  Begin
    If (FmatrizSaldosColorantes[intCont].strBasCol = BASE_IMOBILIARIA)
      Or (FmatrizSaldosColorantes[intCont].strBasCol = EMBALAGEM) Then
    Begin
      Result := FmatrizSaldosColorantes[intCont].fltQtdFormula;
      Exit;
    End;
  End;
end;

function TClassMatrizSaldosColorantes.fRecalculaSaldos(strCodEmp: String;
                                                       fltQtdBas: Double;
                                                       strNumPed: String = '';
                                                       blnLotePrincipalTinta: Boolean = False;
                                                       strNumLot: String = ''): Boolean;
begin
  Result := fRecalculaSaldosInterna(strCodEmp,
                                    fltQtdBas,
                                    strNumPed,
                                    blnLotePrincipalTinta,
                                    strNumLot);
end;

function TClassMatrizSaldosColorantes.fRecalculaSaldosInterna(strCodEmp: String;
                                                              fltQtdBas: Double;
                                                              strNumPed: String = '';
                                                              blnLotePrincipalTinta: Boolean = False;
                                                              strNumLot: String = ''): Boolean;
  Var
    intCont: Integer;
    fltQtdTinta: Double;
begin
  Try
    Result := True;
    Try
      If Not fEmptyStr(strCodEmp) Then
        FstrCodEmp := strCodEmp;

      fltQtdTinta := IfThen(fltQtdBas > 0, fltQtdBas, fGetQuantidadeTinta());

      For intCont := Low(FmatrizSaldosColorantes) To High(FmatrizSaldosColorantes) Do
      Begin
        If (FmatrizSaldosColorantes[intCont].strBasCol = BASE_IMOBILIARIA) Or
           (FmatrizSaldosColorantes[intCont].strBasCol = EMBALAGEM) Then
        Begin
          FmatrizSaldosColorantes[intCont].fltQtdFormula := fltQtdTinta;
        End
        Else If (FmatrizSaldosColorantes[intCont].strBasCol <> BASE_IMOBILIARIA)
          And (FmatrizSaldosColorantes[intCont].strBasCol <> EMBALAGEM) Then
        Begin
          FmatrizSaldosColorantes[intCont].fltQtdFormula :=
              FmatrizSaldosColorantes[intCont].fltQtdFormOri * fltQtdTinta;
        End;
      End;

      For intCont := Low(FmatrizSaldosColorantes) To High(FmatrizSaldosColorantes) Do
        FmatrizSaldosColorantes[intCont].fltSaldoML := fRetornaSaldoDisponivel(
          FmatrizSaldosColorantes[intCont].strCodIte, True, True, '', True, FstrCodEmp, strNumPed);

      {*************************************************************************************}
      {* >>> JDTintas <<<                                                                  *}
      {* Recalcula o estoque do lote principal para tinta de maquina (Laboratorio/Fabrica) *}
      {* Deve validar o estoque na expedicao antes de faturar o pedido                     *}
      {**********************************************************************************JC*}
      If (fUsaRotinaWMS And blnLotePrincipalTinta) Or (fCfgSis('TMQLOT', varBoolean)) Or (fCfgSis('LOTBAS', varBoolean)) Then
      Begin

        For intCont := Low(FmatrizSaldosColorantes) To High(FmatrizSaldosColorantes) Do
        Begin

          If (Not fEmptyStr(strNumLot))      And
             (fCfgSis('LOTBAS', varBoolean)) And
             (FmatrizSaldosColorantes[intCont].strBasCol = BASE_IMOBILIARIA) Then
          Begin
            With FmatrizSaldosColorantes[intCont] Do
              fltSaldoML := fSaldoMLLoteTinta(strCodIte, strNumPed, fltSaldoML, strNumLot);
          End
          Else
          Begin
            With FmatrizSaldosColorantes[intCont] Do
              fltSaldoML := fSaldoMLLotePrincipalTinta(strCodIte, strNumPed, fltSaldoML);
          End;

        End;

      End;

    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally

  End;

end;

class function TClassMatrizSaldosColorantes.FromJsonString(
  AJsonString: string): TClassMatrizSaldosColorantes;
begin
  Result := TJson.JsonToObject<TClassMatrizSaldosColorantes>(AJsonString);
end;

function TClassMatrizSaldosColorantes.fSaldoMLLotePrincipalTinta(
  strCodIte, strNumPed: String; const fltSalMLAtual: Double): Double;
  Var
    strNumLot: String;
begin
  strNumLot := fCampoTabela('LOT_NUMLOT', 'CADLOT',
    ['LOT_CODITE', 'LOT_CODEMP', 'LOT_PRITIN'], [strCodIte, FstrCodEmp, 'S']);

  If strNumLot.IsEmpty Then
    Exit(fltSalMLAtual);

  Result := fRetornaSaldoDisponivel(strCodIte, True, True, strNumLot, True, FstrCodEmp, strNumPed);
end;

function TClassMatrizSaldosColorantes.fSaldoMLLoteTinta(strCodIte,
                                                        strNumPed: String;
                                                        const fltSalMLAtual: Double;
                                                        strNumLot: String = ''): Double;
begin

  If strNumLot.IsEmpty Then
    Exit(fltSalMLAtual);

  Result := fRetornaSaldoDisponivel(strCodIte, True, True, strNumLot, True, FstrCodEmp, strNumPed);

end;

function TClassMatrizSaldosColorantes.GetblnTemSaldo: Boolean;
  Var
    intCont: Integer;
begin
  Result := True;
  For intCont := 0 to Count -1 Do
    Result := Result And GetBaseColoranteTemSaldo(intCont);
end;

function TClassMatrizSaldosColorantes.GetCount: Integer;
begin
  Try
    Result := Length(FmatrizSaldosColorantes);
  Except
    Result := 0;
  End;
end;

function TClassMatrizSaldosColorantes.GetMatrizSaldosColorantes(
  index: Integer): TSaldosColorantes;
begin
  Result := FmatrizSaldosColorantes[index];
end;

procedure TClassMatrizSaldosColorantes.pZerarQuantidadeFormulacao;
  Var
    intContador: Integer;
begin

  For intContador := Low(FmatrizSaldosColorantes) To High(FmatrizSaldosColorantes) Do
  Begin
    FmatrizSaldosColorantes[intContador].fltQtdFormula := 0.00;
  End;

end;

procedure TClassMatrizSaldosColorantes.SetstrCodEmp(const Value: String);
begin
  FstrCodEmp := Value;
end;

function TClassMatrizSaldosColorantes.ToJsonString: string;
begin
  Result := TJson.ObjectToJsonString(Self);
end;

function TClassMatrizSaldosColorantes.fAdicionar(intIDTinta: Integer;
  strDescTinta, strCodIte, strDesIte, strCodCol: String;
  fltQtdFormula: Double; strBasCol: String; strPesGra: String; fltEmbala: Double): TSaldosColorantes;
begin
  SetLength(FmatrizSaldosColorantes, Length(FmatrizSaldosColorantes) + 1);
  FmatrizSaldosColorantes[Length(FmatrizSaldosColorantes) - 1].intIDTinta := intIDTinta;
  FmatrizSaldosColorantes[Length(FmatrizSaldosColorantes) - 1].strDescTinta := strDescTinta;
  FmatrizSaldosColorantes[Length(FmatrizSaldosColorantes) - 1].strCodIte := strCodIte;
  FmatrizSaldosColorantes[Length(FmatrizSaldosColorantes) - 1].strDesIte := strDesIte;
  FmatrizSaldosColorantes[Length(FmatrizSaldosColorantes) - 1].strCodCol := strCodCol;
  FmatrizSaldosColorantes[Length(FmatrizSaldosColorantes) - 1].fltQtdFormula := fltQtdFormula;
  FmatrizSaldosColorantes[Length(FmatrizSaldosColorantes) - 1].fltQtdFormOri := fltQtdFormula;
  FmatrizSaldosColorantes[Length(FmatrizSaldosColorantes) - 1].strBasCol := strBasCol;
  FmatrizSaldosColorantes[Length(FmatrizSaldosColorantes) - 1].strPesGra := strPesGra;
  FmatrizSaldosColorantes[Length(FmatrizSaldosColorantes) - 1].fltEmbala := fltEmbala;    
  Result := FmatrizSaldosColorantes[Length(FmatrizSaldosColorantes) - 1];
end;

procedure TClassMatrizSaldosColorantes.RecalcularFormulacao(const strCodEmpPrd: string;
  const identificador: IIdentificadorTinta);
var
  qryGen: TUniQuery;
  arrFormul: TForMulTinDetArray;
  arrBaixaPigmentos: TBaixaPigmentosArray;
  stlItensTraMl: TStringList;
  intCont: Integer;
  intIndexMatriz: Integer;
begin
  qryGen := nil;
  stlItensTraMl := nil;
  Try
    Try
      if ((fCfgSis('EMPBDU', varBoolean)) And Assigned(identificador) And (identificador.IdePro = 'DUP'))
       Or ((fCfgSis('EMPBDX', varBoolean)) And Assigned(identificador) And (identificador.IdePro = 'DUX'))
       Or ((fCfgSis('EMPBD2', varBoolean)) And Assigned(identificador) And (identificador.IdePro = 'DU2')) Then
      begin
        qryGen := fCriaQuery();
        stlItensTraMl := TStringList.Create;
        if identificador.fGTinForGeral(
            identificador.IdePro,
            identificador.IteTin,
            identificador.TipPre,
            identificador.LinTin,
            identificador.Catalize,
            identificador.LazQua,
            identificador.QtdEmb,
            identificador.QtdIte,
            identificador.Descri,
            qryGen,
            identificador.VolPro,
            arrFormul,
            arrBaixaPigmentos,
            stlItensTraMl,
            identificador.CodDil,
            identificador.PorDil,
            identificador.DilCon,
            identificador.PorCat,
            identificador.TipCor,
            identificador.TextBase,
            identificador.Acao,
            identificador.IteCob,
            strCodEmpPrd) then
        begin
          for intCont := Low(arrBaixaPigmentos) to High(arrBaixaPigmentos) do
          begin
            if fEmptyStr(arrBaixaPigmentos[intCont].strFormul) then
              Break;
            
            for intIndexMatriz := 0 to Length(FmatrizSaldosColorantes) - 1 do
            begin
              if FmatrizSaldosColorantes[intIndexMatriz].strCodCol = arrBaixaPigmentos[intCont].strFormul then
              begin
                FmatrizSaldosColorantes[intIndexMatriz].strCodIte := arrBaixaPigmentos[intCont].strCodIte;
                FmatrizSaldosColorantes[intIndexMatriz].strDesIte := fRetDescricao(arrBaixaPigmentos[intCont].strCodIte, 'CADITE', 'ITE_CODITE', 'ITE_DESITE');
                FmatrizSaldosColorantes[intIndexMatriz].fltQtdFormula := arrBaixaPigmentos[intCont].fltQtdBaixa * identificador.QtdEmb;
                FmatrizSaldosColorantes[intIndexMatriz].fltQtdFormOri := arrBaixaPigmentos[intCont].fltQtdBaixa;
                Break;
              end;
            end;

          end;

        end;
      end;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryGen) then FreeAndNil(qryGen);
    if Assigned(stlItensTraMl) then FreeAndNil(stlItensTraMl);
  End;
end;

procedure TClassMatrizSaldosColorantes.pAcumulaMatriz(var dicQtds: TDicionario; blnPorEmpPrd: Boolean=False; strEmpPrd: String='');
  Var 
    intCont: Integer;
Begin
  for intCont := 0 to Length(FmatrizSaldosColorantes) - 1 do
  begin
    If blnPorEmpPrd Then
      If strEmpPrd <> FmatrizSaldosColorantes[intCont].strEmpPrd Then
        Continue;

    dicQtds[FmatrizSaldosColorantes[intCont].strCodIte] := IfNull(dicQtds[FmatrizSaldosColorantes[intCont].strCodIte], 0) +
      FmatrizSaldosColorantes[intCont].fltQtdFormula;
  end;

  for intCont := 0 to Length(FmatrizSaldosColorantes) - 1 do
  begin
    If blnPorEmpPrd Then
      If strEmpPrd <> FmatrizSaldosColorantes[intCont].strEmpPrd Then
        Continue;

    FmatrizSaldosColorantes[intCont].fltQtdFormAcu := dicQtds[FmatrizSaldosColorantes[intCont].strCodIte];
  end;
End;

function TClassMatrizSaldosColorantes.RecalcularAcumulados(const Formulacao: TClassMatrizSaldosColorantes; blnPorEmpPrd: Boolean=False): TClassMatrizSaldosColorantes;
var
  intIdx : Integer;
  intCont: Integer;
  dicQtds: TDicionario;
  stlEmpPrd: TStringList;
begin
  Result  := Self;
  dicQtds := nil;
  stlEmpPrd := TStringList.Create;
  Try

    Try
      dicQtds := TDicionario.Create;

      If blnPorEmpPrd Then
      Begin
        for intCont := 0 to Length(FmatrizSaldosColorantes) - 1 do
        begin
          If stlEmpPrd.IndexOf(FmatrizSaldosColorantes[intCont].strEmpPrd) = -1 Then
            stlEmpPrd.Add(FmatrizSaldosColorantes[intCont].strEmpPrd);
        end;
      End;

      If (stlEmpPrd.Count > 1) Then
      Begin
        for intIdx := 0 to stlEmpPrd.Count - 1 do
        Begin
          dicQtds.Limpar;
          pAcumulaMatriz(dicQtds, blnPorEmpPrd, stlEmpPrd[intIdx]);
        End;
      End
      Else
      Begin
        pAcumulaMatriz(dicQtds);
      End;

      if Assigned(Formulacao) then
      begin
        for intCont := 0 to Length(Formulacao.FmatrizSaldosColorantes) - 1 do
        begin
          Formulacao.FmatrizSaldosColorantes[intCont].fltQtdFormAcu := dicQtds[Formulacao.FmatrizSaldosColorantes[intCont].strCodIte];
        end;
      end;  
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(dicQtds) then FreeAndNil(dicQtds);
    if Assigned(stlEmpPrd) then FreeAndNil(stlEmpPrd);
  End;
    
end;


end.
