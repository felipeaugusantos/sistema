unit untLoteIndividual;

interface

uses StrUtils, SysUtils, Uni, Db, Classes, Forms, Variants, Controls, untTypesSistema,
     UniClientDataSet, math;

  type
    TLoteIndividual = Class(TObject)
    private
      FcdsLotInd    : TUniClientDataSet;
      FcdsLotIndAux : TUniClientDataSet;
      FQtdPro       : Real;
      FCodIte       : String;

    public
      property cdsLotInd    : TUniClientDataSet read FcdsLotInd    write FcdsLotInd ;
      property cdsLotIndAux : TUniClientDataSet read FcdsLotIndAux                  ;
      property fltQtdPro    : Real              read FQtdPro       write FQtdPro    ;
      property strCodIte    : String            read FCodIte       write FCodIte    ;

      function fValidaLotesIndividuais: boolean;
      procedure pDigLoteIndividual;
      procedure pGeraLotesIndividuais;
      procedure Clear;

      constructor Create;
      Destructor  Destroy; Override;
    end;


implementation

uses untFuncoesSimples, untDigLoteIndividual, untDigLoteIndividualInicial;

{ TLoteIndividual }

constructor TLoteIndividual.Create;

  procedure pConfigCdsLotInd(cdsLote : TUniClientDataSet);
  begin
    cdsLote.FieldDefs.add('ITEM',ftInteger);
    cdsLote.FieldDefs.add('QTD',ftFloat);
    cdsLote.FieldDefs.add('NUMLOT',ftString,255);

    cdsLote.IndexFieldNames := 'ITEM';
    cdsLote.CreateDataSet;

    TFloatField(cdsLote.FieldByName('QTD')).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));
  end;

begin
  FcdsLotInd    := TUniClientDataSet.Create(nil);
  FcdsLotIndAux := TUniClientDataSet.Create(nil);

  pConfigCdsLotInd(FcdsLotInd);
  pConfigCdsLotInd(FcdsLotIndAux);

  Clear;
end;

destructor TLoteIndividual.Destroy;
begin
  FreeAndNil(FcdsLotInd);
  FreeAndNil(FcdsLotIndAux);
  inherited;
end;

function TLoteIndividual.fValidaLotesIndividuais : boolean;
begin
  Result := True;

  if FcdsLotIndAux.IsEmpty then
    exit;


  if (FcdsLotIndAux.RecordCount <> Ceil(FQtdPro)) then
  begin
    pMensagemOk('A quantidade de Lotes individuais é diferente da quantidade produzida!');
    Result := False;
    exit;
  end;

  FcdsLotIndAux.DisableControls;
  try
    FcdsLotIndAux.First;
    while not FcdsLotIndAux.Eof do
    begin
      if fEmptyStr(FcdsLotIndAux.FieldByName('NUMLOT').AsString) then
      begin
        pMensagemOk('É necessário informar todos os lotes individuais!');
        Result := False;
        break;
      end;
      FcdsLotIndAux.Next;
    end;
  finally
    FcdsLotIndAux.First;
    FcdsLotIndAux.EnableControls;
  end;
end;

procedure TLoteIndividual.Clear;
begin
  FQtdPro := 0;
  FCodIte := '';
  cdsLotInd.EmptyDataSet;
  cdsLotIndAux.EmptyDataSet;
end;

procedure TLoteIndividual.pGeraLotesIndividuais;
var
  strLot     : String;
  strPrefixo : String;
  strSufixo  : String;
begin

  try
    pCriarFormularios(TfrmDigLoteIndividualInicial, frmDigLoteIndividualInicial);
    frmDigLoteIndividualInicial.ShowModal;
    if frmDigLoteIndividualInicial.ModalResult = mrOk then
    begin
      strLot     := Trim(frmDigLoteIndividualInicial.edtSequencial.Text);
      strPrefixo := Trim(frmDigLoteIndividualInicial.edtPrefixo.Text);
      strSufixo  := Trim(frmDigLoteIndividualInicial.edtSufixo.Text);

      FcdsLotIndAux.DisableControls;
      FcdsLotIndAux.First;
      while not FcdsLotIndAux.Eof do
      begin
        FcdsLotIndAux.Edit;
        FcdsLotIndAux.FieldByName('NUMLOT').AsString := strPrefixo + strLot + strSufixo;
        FcdsLotIndAux.Post;

        strLot := fIncAlfaNumerico(strLot);

        FcdsLotIndAux.Next;
      end;
    end;
  finally
    FreeAndNil(frmDigLoteIndividualInicial);
    FcdsLotIndAux.First;
    FcdsLotIndAux.EnableControls;
  end;
end;

procedure TLoteIndividual.pDigLoteIndividual;
var
  i           : integer;
  intQtdLot   : integer;
  intDecimais : integer;

  procedure pClonaCdsLot(cdsOrigem, cdsDestino : TUniClientDataSet);
  begin
    cdsDestino.EmptyDataSet;
    cdsOrigem.First;
    while not cdsOrigem.Eof do
    begin
      cdsDestino.Insert;
      cdsDestino.FieldByName('ITEM').AsInteger  := cdsOrigem.FieldByName('ITEM').AsInteger;
      cdsDestino.FieldByName('QTD').AsFloat     := cdsOrigem.FieldByName('QTD').AsFloat;
      cdsDestino.FieldByName('NUMLOT').AsString := cdsOrigem.FieldByName('NUMLOT').AsString;
      cdsDestino.Post;

      cdsOrigem.Next;
    end;

    cdsOrigem.First;
    cdsDestino.First;
  end;

begin
  try
    FcdsLotInd.DisableControls;
    FcdsLotIndAux.DisableControls;
    pClonaCdsLot(FcdsLotInd, FcdsLotIndAux);

    intQtdLot := Ceil(FQtdPro);
    intDecimais := fCfgSis('DECUNI', varInteger);

    if  FcdsLotIndAux.isEmpty or
       (    (FcdsLotIndAux.RecordCount <> intQtdLot)
        and (fMensagem('', 'A quantidade foi alterada, deseja gerar os lotes novamente?', ['','']) = 1)
       )
    then
    begin
      FcdsLotIndAux.EmptyDataSet;
      for i := 1 to intQtdLot do
      begin
        FcdsLotIndAux.Insert;
        FcdsLotIndAux.FieldByName('ITEM').AsInteger := i;
        if (FQtdPro <> intQtdLot) and (i = intQtdLot) then
          FcdsLotIndAux.FieldByName('QTD').AsFloat := RoundTo(Frac(FQtdPro), -1*intDecimais)
        else
          FcdsLotIndAux.FieldByName('QTD').AsInteger := 1;
        FcdsLotIndAux.Post;
      end;
    end;

    FcdsLotIndAux.First;
    FcdsLotIndAux.EnableControls;
    pCriarFormularios(TfrmDigLoteIndividual, frmDigLoteIndividual);
    frmDigLoteIndividual.objLotInd := Self;
    frmDigLoteIndividual.ShowModal;

    if frmDigLoteIndividual.ModalResult = mrOk then
      pClonaCdsLot(FcdsLotIndAux, FcdsLotInd);

    FreeAndNil(frmDigLoteIndividual);
  finally
    cdsLotInd.EnableControls;
    cdsLotIndAux.EnableControls;
    cdsLotIndAux.EmptyDataSet;
  end;
end;

end.
