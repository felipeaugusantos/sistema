unit untTLeitorRetornoCustodiaDB;

interface

uses
  System.Classes, Generics.Collections, System.SysUtils, System.Generics.Defaults,
  untTProcessaRetornoCustodia;

type
  TLeitorRetornoCustodiaDB = class(TLeitorRetornoCustodia)
  private
    procedure pVerificaExisteAmbos(lstChqDB, lstChqArq: TList<TChequeCustodia>; fncComp: TComparison<TChequeCustodia>);
    function fIndexOf(lstChq: TList<TChequeCustodia>; objChq: TChequeCustodia; fncComp: TComparison<TChequeCustodia>): Integer;
  public
    function fLerArquivo(strNomeArquivo: String; objProcessador: TProcessaRetornoCustodia): Boolean; override;
  end;

implementation

{ TLeitorRetornoCustodiaDB }

uses untTCadChq, untTCadChqRepository, untFuncoesSimples;

function TLeitorRetornoCustodiaDB.fIndexOf(lstChq: TList<TChequeCustodia>;
  objChq: TChequeCustodia; fncComp: TComparison<TChequeCustodia>): Integer;
var
  intIndex: Integer;
begin
  If TArray.BinarySearch<TChequeCustodia>(lstChq.ToArray, objChq, intIndex,
    TComparer<TChequeCustodia>.Construct(fncComp)) Then
    Result := intIndex
  Else
    Result := -1;
end;

function TLeitorRetornoCustodiaDB.fLerArquivo(strNomeArquivo: String;
  objProcessador: TProcessaRetornoCustodia): Boolean;
  Var
    lstCheques: TList<TCadChq>;
    lstChqNaoArquivo: TList<TChequeCustodia>;
    objCadChq: TCadChq;
    objChqCus: TChequeCustodia;
    repCheques: TCadChqRepository;
begin
  repCheques := TCadChqRepository.Create;
  lstCheques := repCheques.fRetornaChequesEmCustodia();
  lstChqNaoArquivo := TList<TChequeCustodia>.Create;
  Try
    For objCadChq In lstCheques Do
    Begin
      objChqCus := TChequeCustodia.Create();

      objChqCus.intStatus         := SOMENTE_NO_BD;
      objChqCus.strChave          := fPadR(Trim(objCadChq.AUTOINCREM), 20);
      If objCadChq.CHQ_CODCMC.HasValue Then
        objChqCus.strCmc7           := objCadChq.CHQ_CODCMC;
      objChqCus.fltValor          := objCadChq.CHQ_VALCHQ;
      objChqCus.dtaCadastro       := objCadChq.CHQ_DTACAD;
      objChqCus.dtaVencimento     := objCadChq.CHQ_DTAVEN;
      If objCadChq.CHQ_LOTCUS.HasValue Then
        objChqCus.strLote           := objCadChq.CHQ_LOTCUS;
      objChqCus.strBanco          := objCadChq.CHQ_CODBCO;
      objChqCus.strAgencia        := objCadChq.CHQ_NUMAGE;
      objChqCus.strNumConta       := objCadChq.CHQ_CONCOR;
      objChqCus.strNumCheque      := objCadChq.CHQ_NUMCHQ;
      objChqCus.strEmitente       := objCadChq.CHQ_NOMEMI;

      lstChqNaoArquivo.Add(objChqCus);
    End;

    pVerificaExisteAmbos(lstChqNaoArquivo, objProcessador.lstCheques,
      function (const objChq1, objChq2: TChequeCustodia): Integer
      Begin
        Result := TComparer<String>.Default.Compare(objChq1.strChave, objChq2.strChave);
      End
    );

    pVerificaExisteAmbos(lstChqNaoArquivo, objProcessador.lstCheques,
      function (const objChq1, objChq2: TChequeCustodia): Integer
      Begin
        Result := TComparer<String>.Default.Compare(objChq1.strNumCheque, objChq2.strNumCheque);
        if Result = 0 Then
          Result := TComparer<String>.Default.Compare(objChq1.strNumConta, objChq2.strNumConta);
        if Result = 0 Then
          Result := TComparer<String>.Default.Compare(objChq1.strAgencia, objChq2.strAgencia);
        if Result = 0 Then
          Result := TComparer<String>.Default.Compare(objChq1.strBanco, objChq2.strBanco);
      End
    );

    objProcessador.lstCheques.AddRange(lstChqNaoArquivo.ToArray);

    Result := True;
  Finally
    FreeAndNil(repCheques);
    FreeAndNil(lstCheques);
    FreeAndNil(lstChqNaoArquivo);
  End;
end;

procedure TLeitorRetornoCustodiaDB.pVerificaExisteAmbos(lstChqDB, lstChqArq: TList<TChequeCustodia>;
  fncComp: TComparison<TChequeCustodia>);
Var
  objChqDb, objChqArq: TChequeCustodia;
  intIndexCheque: Integer;
begin
  lstChqDB.Sort(TComparer<TChequeCustodia>.Construct(fncComp));

  For objChqArq In lstChqArq Do
  Begin
    intIndexCheque := fIndexOf(lstChqDB, objChqArq, fncComp);

    If (intIndexCheque >= 0) And (intIndexCheque < lstChqDB.Count) Then
    Begin
      objChqDb := lstChqDB[intIndexCheque];

      objChqArq.intStatus    := PRESENTE_EM_AMBOS;
      objChqArq.strLote      := objChqDb.strLote;
      objChqArq.strBanco     := objChqDb.strBanco;
      objChqArq.strAgencia   := objChqDb.strAgencia;
      objChqArq.strNumConta  := objChqDb.strNumConta;
      objChqArq.strNumCheque := objChqDb.strNumCheque;
      objChqArq.strEmitente  := objChqDb.strEmitente;

      lstChqDB.Remove(objChqDb);
      FreeAndNil(objChqDb);
    End;

  End;
end;

initialization

  RegisterClass(TLeitorRetornoCustodiaDB);

end.
