unit untImpDadosGarantia;

interface

uses Classes,
     SysUtils,
     Uni,
     StrUtils,
     untImpGerencial,
     untFiscal;

type
  TImpDadosGarantia = class(TComponent)
    private
      FImpGerencial: TImprimeGerencial;

      function fCarregaItens(strNumDoc,strEspDoc,strCodEmp,strCodCli: String): Boolean;

    public
      qryItens: TUniQuery;      

      constructor Create(AOwner: TComponent; FEcfFiscalAberto: TUntFiscal = Nil); reintroduce;
      destructor Destroy; override;

      function fImprimirGarantia(strNumDoc,strEspDoc,strCodEmp,strCodCli: String): Boolean;
    end;

Const
  INT_CARAC_NOR = 48;
  INT_CARAC_EXP = 24;    

implementation

uses untFuncoesSimples, Data.DB;

{ TCarnePagamento }

constructor TImpDadosGarantia.Create(AOwner: TComponent; FEcfFiscalAberto: TUntFiscal = Nil);
begin
  FImpGerencial := TImprimeGerencial.Create(Self, FEcfFiscalAberto);
end;

function TImpDadosGarantia.fCarregaItens(strNumDoc,strEspDoc,strCodEmp,strCodCli: String): Boolean;
begin
  If Not Assigned(qryItens) Then
    qryItens := fCriaQuery(Self);

  With qryItens, SQL Do
  Begin
    Add('SELECT ');
    Add('  CONCAT(D.DET_CODITE,"-",D.DET_DESCRI) AS DESITE, ');
    Add('  IF(IFNULL(D.DET_TMPGAR,0) > 0, CONCAT("Garantia de ", D.DET_TMPGAR, " meses.", " ", I.ITE_INFGAR), "") AS INFGAR ');
    Add('FROM ');
    Add('  MOVDET D ');
    Add('  INNER JOIN CADITE I ON D.DET_CODITE = I.ITE_CODITE ');
    Add('WHERE ');
    Add('  D.DET_NUMDOC = :NUMDOC AND ');
    Add('  D.DET_ESPDOC = :ESPDOC AND ');
    Add('  D.DET_CODCLI = :CODCLI AND ');
    Add('  D.DET_CODEMP = :CODEMP     ');
    Add(' GROUP BY D.DET_CODITE, D.DET_DESCRI, D.DET_TMPGAR ');
    Add(' ORDER BY D.DET_CODITE ');
    ParamByName('NUMDOC').AsString := strNumDoc;
    ParamByName('ESPDOC').AsString := strEspDoc;
    ParamByName('CODCLI').AsString := strCodCli;
    ParamByName('CODEMP').AsString := strCodEmp;
    Open;

    Result := Not IsEmpty;
  End;
end;

destructor TImpDadosGarantia.Destroy;
begin
  If Assigned(qryItens) Then
    FreeAndNil(qryItens);

  If Assigned(FImpGerencial) Then
    FreeAndNil(FImpGerencial);

  inherited;
end;

function TImpDadosGarantia.fImprimirGarantia(strNumDoc,strEspDoc,strCodEmp,strCodCli: String): Boolean;
  Var
    stlImpressao: TStringList;
    intDuplicata: Integer;
    blnExpandido: Boolean;

  procedure pAddLinha(strTexto: String; blnCentralizar: Boolean = False);
  begin
    If blnExpandido Then
      stlImpressao.Add(strTexto)
    Else If blnCentralizar Then
      stlImpressao.Add(fPadC(strTexto, INT_CARAC_NOR))
    Else
      stlImpressao.Add(fPadR(strTexto, INT_CARAC_NOR));
  end;

begin
  Result := False;

  If Not FImpGerencial.blnPodeImprimir Then
    Exit;

  stlImpressao := TStringList.Create;

  With FImpGerencial Do
  Begin

    blnExpandido := Not SameText(EmptyStr, fFormatarTextoImp(EmptyStr, [fiExpandido]));

    If fCarregaItens(strNumDoc,strEspDoc,strCodEmp,strCodCli) Then
    Begin
      pAddLinha(fReplicatorStr('-', INT_CARAC_NOR));
      pAddLinha(fFormatarTextoImp(fPadC('ITENS EM GARANTIA', INT_CARAC_EXP), [fiNegrito, fiExpandido]), True);
      pAddLinha(fReplicatorStr('-', INT_CARAC_NOR));

      With qryItens Do
      Begin
        First;
        While Not EOF do
        Begin
          pAddLinha('Produto: ' + fPadR(FieldByName('DESITE').AsString, INT_CARAC_NOR - 9));
          pAddLinha('         ' + fPadR(Copy(FieldByName('INFGAR').AsString,1,41), INT_CARAC_NOR - 9));

          If Not fEmptyStr(Copy(FieldByName('INFGAR').AsString,42,41)) Then
            pAddLinha('         ' + fPadR(Copy(FieldByName('INFGAR').AsString,42,41), INT_CARAC_NOR - 9));

          Next;
        End;
      End;

      pAddLinha(fReplicatorStr('-', INT_CARAC_NOR));

      If fAbreRelatorioGerencial Then
      Begin
        Result := True;

        For intDuplicata := 0 To stlImpressao.Count -1 Do
          Result := Result And fRelatorioGerencial(stlImpressao[intDuplicata]);

        fFechaRelatorioGerencial(True);
      End;

    End;
  End;

  FreeAndNil(stlImpressao);    
end;

end.
