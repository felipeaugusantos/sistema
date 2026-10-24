unit untControleChavesGarantia;

interface

type
  TItemGerado = Record
    strIncGad: String;
    strIncDet: String;
    fltQtdIte: Double;
  end;
  TArrItensGerados = Array of TItemGerado;
  TRecChavesGarantia = Record
    strIncGad,
    strIncOri: String;
    fltQtdIte: Double;
  end;
  TarrChaves = Array of TRecChavesGarantia;

  TRecMovDet = Record
    fltQtdIte: Double;
    fltQtdGer: Double;
    strIncDet: String;
  end;
  TArrMovDet = Array of TRecMovDet;

  TControleChavesGarantiaItens = record
    arrItensGerados: TArrItensGerados;
    arrChaves: TarrChaves;
    arrMovDet: TArrMovDet;
    CodigoItem: String;
    index: integer;
    procedure pOrdenarChavesGarantia;
    procedure pOrdenarMovDet;
    procedure pAdd(AChave, AIncOri: String; AQtdIte: Double);
    procedure pAddMovDet(const AChave: String; const AQtdIte: Double);
    procedure pAddItemGerado(const pstrIncGad, pstrIncDet: String; const pfltQtdIte: Double);
    function fSaldoChave(const pstrIncGad: String): Double;
    function fSaldoMovDet(const pstrIncDet: String): Double;
    function fTotalQtdMovDet: Double;
    function fTotalQtdMovGad: Double;
    function fTotalGeradoChave(const pstrIncGad: String): Double;
    function fTotalGeradoMovDet(const pstrIncDet: String): Double;
    function fTemSaldoPendente: Boolean;
    procedure pReinicializar;
    procedure pInicializarArrays;
  End;
  TPTControleChavesGarantiaItens = ^TControleChavesGarantiaItens;
  TArrControleChavesGarantiaItens = array of TControleChavesGarantiaItens;

  TControleChavesGarantia = class
  private
    class var arrControleChavesGarantiaItens: TArrControleChavesGarantiaItens;
    class function fCriarControleChave(const pstrCodIte: String): Integer;
    class procedure pLimpaArray;
    class function fGetArrChavesItensIndex(ACodIte: String): Integer;
    class function fControleChavesGarantiaItens(const Index: Integer): TPTControleChavesGarantiaItens;
  public
    class var strOpcDoc: String;
    class var strTipMod: String;
    class procedure pAdicionarChaveGarantia(ACodIte, AChave, AIncOri: String; AQtdIte: Double);
    class procedure pInserirMovDet(const pstrCodIte, pstrAutInc: String; const pfltQtdIte: Double);
    class function fGerarVinculosMOVGRC: Boolean;
    class procedure pInicializar;
    class procedure pReiniciarProcessoGarantia;
  end;

implementation

uses
  untGarant,
  System.SysUtils,
  untFuncoesSimples;

{ TControleChavesGarantia }
class procedure TControleChavesGarantia.pAdicionarChaveGarantia(ACodIte, AChave, AIncOri: String; AQtdIte: Double);
var lIndex: integer;
begin
  lIndex := TControleChavesGarantia.fGetArrChavesItensIndex(ACodIte);
  If lIndex = -1 then
  begin
    SetLength(TControleChavesGarantia.arrControleChavesGarantiaItens, succ(Length(TControleChavesGarantia.arrControleChavesGarantiaItens)));
    lIndex := High(TControleChavesGarantia.arrControleChavesGarantiaItens);
    TControleChavesGarantia.arrControleChavesGarantiaItens[lIndex].index := lIndex;
    TControleChavesGarantia.arrControleChavesGarantiaItens[lIndex].CodigoItem := ACodIte;
  end;
  TControleChavesGarantia.arrControleChavesGarantiaItens[lIndex].pAdd(AChave, AIncOri, AQtdIte);
end;

class function TControleChavesGarantia.fGetArrChavesItensIndex(ACodIte: String): Integer;
var   lControleChavesGarantiaItens: TControleChavesGarantiaItens;
begin
  Result := -1;
  For lControleChavesGarantiaItens in  TControleChavesGarantia.arrControleChavesGarantiaItens do
  begin
    if lControleChavesGarantiaItens.CodigoItem = ACodIte then
      Result := lControleChavesGarantiaItens.index;
  end;
end;

class function TControleChavesGarantia.fCriarControleChave(const pstrCodIte: String): Integer;
Var
  lIndex: Integer;
begin
  lIndex := TControleChavesGarantia.fGetArrChavesItensIndex(pstrCodIte);
  if lIndex = -1 then
  begin
    SetLength(TControleChavesGarantia.arrControleChavesGarantiaItens, succ(Length(TControleChavesGarantia.arrControleChavesGarantiaItens)));
    lIndex := High(TControleChavesGarantia.arrControleChavesGarantiaItens);
    TControleChavesGarantia.arrControleChavesGarantiaItens[lIndex].index := lIndex;
    TControleChavesGarantia.arrControleChavesGarantiaItens[lIndex].CodigoItem := pstrCodIte;
    TControleChavesGarantia.arrControleChavesGarantiaItens[lIndex].pInicializarArrays;
  end;
  Result := lIndex;
end;

class function TControleChavesGarantia.fGerarVinculosMOVGRC: Boolean;
type
  TValidacaoBaixa = (vbQuantidade,     //MOVGAD 1|-|1 MOVDET
                     vbGadNDet,  //MOVGAD 1|-|N MOVDET
                     vbDetNGad); //MOVGAD N|-|1 MOVDET
Var
  lPControleChavesGarantiaItens: TPTControleChavesGarantiaItens;
  i, j, k: Integer;
  lValidacaoBaixa: TValidacaoBaixa;
  lfltQtdIte,
  lfltSalDet,
  lfltSalGad,
  lfltDiferenca: Double;
begin
  //percorrendo o conjunto de TControleChavesGarantiaItens
  Result := True;
  Try
    for i := low(TControleChavesGarantia.arrControleChavesGarantiaItens) to
               high(TControleChavesGarantia.arrControleChavesGarantiaItens) do
    begin
      lPControleChavesGarantiaItens := @TControleChavesGarantia.arrControleChavesGarantiaItens[i];
      lPControleChavesGarantiaItens^.pOrdenarChavesGarantia;
      lPControleChavesGarantiaItens^.pOrdenarMovDet;
      if lPControleChavesGarantiaItens^.fTotalQtdMovDet <> lPControleChavesGarantiaItens^.fTotalQtdMovGad then
        raise Exception.Create('Foi encontrada uma inconsistência de dados na geração da MOVGRC. Contate a Citel');

      if (Length(lPControleChavesGarantiaItens^.arrChaves) > 1) And
           (Length(lPControleChavesGarantiaItens^.arrMovDet) = Length(lPControleChavesGarantiaItens^.arrChaves)) then
        lValidacaoBaixa := vbQuantidade
      else if (Length(lPControleChavesGarantiaItens^.arrChaves) = 1) And
                (Length(lPControleChavesGarantiaItens^.arrMovDet) > 1) then
        lValidacaoBaixa := vbGadNDet
      else if (Length(lPControleChavesGarantiaItens^.arrMovDet) = 1) And
                (Length(lPControleChavesGarantiaItens^.arrChaves) > 1) then
        lValidacaoBaixa := vbDetNGad
      else
        lValidacaoBaixa := vbDetNGad;

      //percorrendo registros movdet
      for j := low(lPControleChavesGarantiaItens^.arrChaves) to
                 high(lPControleChavesGarantiaItens^.arrChaves) do
      begin
        for k := low(lPControleChavesGarantiaItens^.arrMovDet) to
                   high(lPControleChavesGarantiaItens^.arrMovDet) do
        begin
          lfltSalDet := lPControleChavesGarantiaItens^.fSaldoMovDet( lPControleChavesGarantiaItens^.arrMovDet[k].strIncDet);
          if lfltSalDet <= 0 then
            Continue;
          lfltSalGad := lPControleChavesGarantiaItens^.fSaldoChave(lPControleChavesGarantiaItens^.arrChaves[j].strIncGad);
          if lfltSalGad <= 0 then
            Continue;
          if (lValidacaoBaixa = vbQuantidade) And
               Not (lPControleChavesGarantiaItens.arrChaves[j].fltQtdIte =
                     lPControleChavesGarantiaItens.arrMovDet[k].fltQtdIte) then
            Continue;
          case lValidacaoBaixa of
            vbDetNGad:
            begin
              lfltQtdIte := lPControleChavesGarantiaItens^.arrChaves[j].fltQtdIte;
              lfltDiferenca := lfltSalDet - lfltQtdIte;
            end
          else
            begin
              lfltQtdIte := lPControleChavesGarantiaItens^.arrMovDet[k].fltQtdIte;
              lfltDiferenca := lfltSalGad - lfltQtdIte;
            end;
          end;
          if lfltDiferenca < 0 then
            raise Exception.Create('Foi encontrada uma inconsistência de dados na geração da MOVGRC. Contate a Citel');
          if TMovGag.fInsereMovGrc(lPControleChavesGarantiaItens^.arrChaves[j].strIncGad,
                                   lPControleChavesGarantiaItens^.arrMovDet[k].strIncDet,
                                   TControleChavesGarantia.strOpcDoc,
                                   TControleChavesGarantia.strTipMod,
                                   lPControleChavesGarantiaItens^.arrChaves[j].strIncOri) Then
          begin
            lPControleChavesGarantiaItens^
              .pAddItemGerado(lPControleChavesGarantiaItens^.arrChaves[j].strIncGad,
                              lPControleChavesGarantiaItens^.arrMovDet[k].strIncDet,
                              lfltQtdIte);
          end;
          if lValidacaoBaixa = vbQuantidade then
            Break;
        end;
      end;
      if lPControleChavesGarantiaItens^.fTemSaldoPendente then
        raise Exception.Create('Foi encontrada uma inconsistência de dados na geração da MOVGRC. Contate a Citel');
    end;
  Except
    On E: Exception do
    begin
      Result := False;
      fMensagem('Atenção!', e.Message, ['&Ok']);
    end;
  End;
end;

class procedure TControleChavesGarantia.pInicializar;
begin
  pLimpaArray;
  SetLength(TControleChavesGarantia.arrControleChavesGarantiaItens, 0);
  TControleChavesGarantia.strOpcDoc := '';
  TControleChavesGarantia.strTipMod := '';
end;

class procedure TControleChavesGarantia.pInserirMovDet(const pstrCodIte,
                                                             pstrAutInc: String;
                                                       const pfltQtdIte: Double);
Var
  lIndex: Integer;
  lControleChavesGarantiaItens: TPTControleChavesGarantiaItens;
begin
  lIndex := TControleChavesGarantia.fGetArrChavesItensIndex(pstrCodIte);
  if lIndex = -1 then
    lIndex := TControleChavesGarantia.fCriarControleChave(pstrCodIte);
  lControleChavesGarantiaItens := TControleChavesGarantia.fControleChavesGarantiaItens(lIndex);
  lControleChavesGarantiaItens^.pAddMovDet(pstrAutInc, pfltQtdIte);
end;

class function TControleChavesGarantia.fControleChavesGarantiaItens(const Index: Integer): TPTControleChavesGarantiaItens;
Var
  i: Integer;
  lblnEncontrou: Boolean;
begin
  Result := Nil;
  lblnEncontrou := False;
  for i := Low(TControleChavesGarantia.arrControleChavesGarantiaItens) To High(TControleChavesGarantia.arrControleChavesGarantiaItens) do
  begin
    if TControleChavesGarantia.arrControleChavesGarantiaItens[i].index = Index then
    begin
      lblnEncontrou := True;
      Result := @TControleChavesGarantia.arrControleChavesGarantiaItens[i];
      Break;
    end;
  end;
  if Not lblnEncontrou then
    raise Exception.Create('Controlde de chaves de garantia não encontrado.');
end;

class procedure TControleChavesGarantia.pLimpaArray;
begin
  if Length(TControleChavesGarantia.arrControleChavesGarantiaItens) > 0 then
    Finalize(TControleChavesGarantia.arrControleChavesGarantiaItens);
end;

class procedure TControleChavesGarantia.pReiniciarProcessoGarantia;
Var
  i: Integer;
  lPTControleChavesGarantiaItens: TPTControleChavesGarantiaItens;
begin
  for i := low(TControleChavesGarantia.arrControleChavesGarantiaItens) to
             high(TControleChavesGarantia.arrControleChavesGarantiaItens) do
  begin
    lPTControleChavesGarantiaItens := TControleChavesGarantia.fControleChavesGarantiaItens(i);
    lPTControleChavesGarantiaItens^.pReinicializar;
  end;
end;
{ TControleChavesGarantiaItens }

function TControleChavesGarantiaItens.fSaldoChave(
  const pstrIncGad: String): Double;
Var
  i: integer;
begin
  Result := 0;
  for i := Low(Self.arrChaves) to high(Self.arrChaves) do
  begin
    if Self.arrChaves[i].strIncGad = pstrIncGad then
    begin
      Result := Self.arrChaves[i].fltQtdIte -
        fTotalGeradoChave(pstrIncGad);
      Break;
    end;
  end;
end;

function TControleChavesGarantiaItens.fSaldoMovDet(
  const pstrIncDet: String): Double;
Var
  i: integer;
begin
  Result := 0;
  for i := Low(Self.arrMovDet) to high(Self.arrMovDet) do
  begin
    if Self.arrMovDet[i].strIncDet = pstrIncDet then
    begin
      Result := Self.arrMovDet[i].fltQtdIte -
        fTotalGeradoMovDet(pstrIncDet);
      Break;
    end;
  end;
end;

function TControleChavesGarantiaItens.fTemSaldoPendente: Boolean;
Var
  i: integer;
begin
  Result := False;
  for i := low(Self.arrChaves) to high(Self.arrChaves) do
  begin
    if fSaldoChave(Self.arrChaves[i].strIncGad) > 0 then
    begin
      Result := True;
      Break;
    end;
  end;
  if Result then
    Exit;
  for i := low(Self.arrMovDet) to high(Self.arrMovDet) do
  begin
    if fSaldoMovDet(Self.arrMovDet[i].strIncDet) > 0 then
    begin
      Result := True;
      Break;
    end;
  end;
end;

function TControleChavesGarantiaItens.fTotalGeradoChave(
  const pstrIncGad: String): Double;
Var
  i: integer;
begin
  Result := 0;
  for i := Low(Self.arrItensGerados) to high(Self.arrItensGerados) do
  begin
    if Self.arrItensGerados[i].strIncGad = pstrIncGad then
      Result := Result + Self.arrItensGerados[i].fltQtdIte;
  end;
end;

function TControleChavesGarantiaItens.fTotalGeradoMovDet(
  const pstrIncDet: String): Double;
Var
  i: integer;
begin
  Result := 0;
  for i := Low(Self.arrItensGerados) to high(Self.arrItensGerados) do
  begin
    if Self.arrItensGerados[i].strIncDet = pstrIncDet then
      Result := Result + Self.arrItensGerados[i].fltQtdIte;
  end;
end;

function TControleChavesGarantiaItens.fTotalQtdMovDet: Double;
Var
  i: integer;
begin
  Result := 0;
  for i := 0 to Length(arrMovDet) -1 do
  begin
    Result := Result + arrMovDet[i].fltQtdIte;
  end;
end;

function TControleChavesGarantiaItens.fTotalQtdMovGad: Double;
Var
  i: integer;
begin
  Result := 0;
  for i := 0 to Length(arrChaves) -1 do
  begin
    Result := Result + arrChaves[i].fltQtdIte;
  end;
end;

procedure TControleChavesGarantiaItens.pAdd(AChave, AIncOri: String; AQtdIte: Double);
begin
  Setlength(arrChaves, Length(arrChaves)+1);
  arrChaves[High(arrChaves)].strIncGad := AChave;
  arrChaves[High(arrChaves)].strIncOri := AIncOri;
  arrChaves[High(arrChaves)].fltQtdIte := AQtdIte;
end;

procedure TControleChavesGarantiaItens.pAddItemGerado(const pstrIncGad,
  pstrIncDet: String; const pfltQtdIte: Double);
Var
  i: Integer;
  lblnCriar: Boolean;
begin
  lblnCriar := True;
  for i := low(Self.arrItensGerados) to high(Self.arrItensGerados) do
  begin
    if (Self.arrItensGerados[i].strIncGad = pstrIncGad) And
         (Self.arrItensGerados[i].strIncDet = pstrIncDet) then
    begin
      lblnCriar := False;
      Break;
    end;
  end;
  if Not lblnCriar then
    Exit;
  SetLength(Self.arrItensGerados, length(Self.arrItensGerados)+1);
  i := High(Self.arrItensGerados);
  Self.arrItensGerados[i].strIncGad := pstrIncGad;
  Self.arrItensGerados[i].strIncDet := pstrIncDet;
  Self.arrItensGerados[i].fltQtdIte := pfltQtdIte;
end;

procedure TControleChavesGarantiaItens.pAddMovDet(const AChave: String;
  const AQtdIte: Double);
var
  i: integer;
  lblnIncluir: Boolean;
begin
  lblnIncluir := True;
  if length(arrMovDet) > 0 then
  begin
    for i := low(arrMovDet) to high(arrMovDet) do
    begin
      if arrMovDet[i].strIncDet = AChave then
      begin
        lblnIncluir := False;
        Break;
      end;
    end;

    if Not lblnIncluir then
      Exit;
  end;

  SetLength(arrMovDet, length(arrMovDet)+1);
  arrMovDet[high(arrMovDet)].strIncDet := AChave;
  arrMovDet[high(arrMovDet)].fltQtdIte := AQtdIte;
  arrMovDet[high(arrMovDet)].fltQtdGer := 0;
end;

procedure TControleChavesGarantiaItens.pInicializarArrays;
begin
  Setlength(Self.arrChaves, 0);
  Setlength(Self.arrMovDet, 0);
  Setlength(Self.arrItensGerados, 0);
end;

procedure TControleChavesGarantiaItens.pOrdenarChavesGarantia;
Var
  i, j: Integer;
  lChave: TRecChavesGarantia;
begin
  for i := 0 to Length(arrChaves)-2 do
  begin
    for j := i+1 to Length(arrChaves)-1 do
    begin
      if arrChaves[i].fltQtdIte > arrChaves[j].fltQtdIte then
      begin
        lChave := arrChaves[i];
        arrChaves[i] := arrChaves[j];
        arrChaves[j] := lChave;
      end;
    end;
  end;
end;

procedure TControleChavesGarantiaItens.pOrdenarMovDet;
Var
  i, j: Integer;
  lRecMovDet: TRecMovDet;
begin
  for i := 0 to Length(arrMovDet)-2 do
  begin
    for j := i+1 to Length(arrMovDet)-1 do
    begin
      if arrMovDet[i].fltQtdIte > arrMovDet[j].fltQtdIte then
      begin
        lRecMovDet := arrMovDet[i];
        arrMovDet[i] := arrMovDet[j];
        arrMovDet[j] := lRecMovDet;
      end;
    end;
  end;

end;

procedure TControleChavesGarantiaItens.pReinicializar;
begin
  if Length(arrItensGerados) > 0 then
  begin
    Finalize(arrItensGerados);
    SetLength(arrItensGerados,0);
  end;

  if Length(arrMovDet) > 0 then
  begin
    Finalize(arrMovDet);
    SetLength(arrMovDet, 0);
  end;
end;

{ TRecMovDet }


end.



