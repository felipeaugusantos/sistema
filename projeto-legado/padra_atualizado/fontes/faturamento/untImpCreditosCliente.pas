unit untImpCreditosCliente;

interface

uses Classes,
     SysUtils,
     Uni,
     StrUtils,
     untImpGerencial,
     untFiscal;

type
  TImpCreditosCliente = class(TComponent)
    private
      FImpGerencial: TImprimeGerencial;
    public
      constructor Create(AOwner: TComponent; FEcfFiscalAberto: TUntFiscal = Nil); reintroduce;
      destructor Destroy; override;
      function fImprimirCreditos(strCodCli: String; fltCredUtilizados: Double): Boolean;
    end;

Const
  INT_CARAC_NOR = 48;
  INT_CARAC_EXP = 24;    

implementation

uses untFuncoesSimples,untFuncoes;

{ TImpCreditosCliente }

constructor TImpCreditosCliente.Create(AOwner: TComponent; FEcfFiscalAberto: TUntFiscal = Nil);
begin
  FImpGerencial := TImprimeGerencial.Create(Self, FEcfFiscalAberto);
end;

destructor TImpCreditosCliente.Destroy;
begin
  If Assigned(FImpGerencial) Then
    FreeAndNil(FImpGerencial);
  inherited;
end;

function TImpCreditosCliente.fImprimirCreditos(strCodCli: String; fltCredUtilizados: Double): Boolean;
  Var
    stlImpressao: TStringList;
    intDuplicata: Integer;
    blnExpandido: Boolean;
    strTextoCli : String;
    fltTotCreCli : Double;

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

  fltTotCreCli := fGetTotalCreditosCliente(strCodCli);

  If (fFormataFloat(fltTotCreCli + fltCredUtilizados, 2) = 0.00) Then
    Exit;

  stlImpressao := TStringList.Create;

  With FImpGerencial Do
  Begin

    blnExpandido := Not SameText(EmptyStr, fFormatarTextoImp(EmptyStr, [fiExpandido]));

    pAddLinha(fReplicatorStr('-', INT_CARAC_NOR));
    pAddLinha(fFormatarTextoImp(fPadC('CRÉDITOS DO CLIENTE', INT_CARAC_EXP), [fiNegrito, fiExpandido]), True);
    pAddLinha(fReplicatorStr('-', INT_CARAC_NOR));

    strTextoCli := 'Cliente: ' + strCodCli + ' - ' + fRetNomCliente(strCodCli);
    pAddLinha(Copy(strTextoCli + fReplicatorStr(' ', INT_CARAC_NOR), 1, INT_CARAC_NOR));

    If Length(strTextoCli) > INT_CARAC_NOR Then
    Begin
      strTextoCli := Copy(strTextoCli, INT_CARAC_NOR+1, Length(strTextoCli));
      pAddLinha(Copy(strTextoCli + fReplicatorStr(' ', INT_CARAC_NOR), 1, INT_CARAC_NOR));
    End;

    pAddLinha(fReplicatorStr('-', INT_CARAC_NOR));
    pAddLinha('Total de Créditos: ' + FloatToStrF(fltTotCreCli + fltCredUtilizados , ffFixed, 12, 2));
    pAddLinha('Total Utilizado..: ' + FloatToStrF(fltCredUtilizados, ffFixed, 12, 2));
    pAddLinha('Total Restante...: ' + FloatToStrF(fltTotCreCli, ffFixed, 12, 2));
    pAddLinha(fReplicatorStr('-', INT_CARAC_NOR));

    If fAbreRelatorioGerencial Then
    Begin
      Result := True;

      For intDuplicata := 0 To stlImpressao.Count -1 Do
        Result := Result And fRelatorioGerencial(stlImpressao[intDuplicata]);

      fFechaRelatorioGerencial(True);
    End;

  End;

  FreeAndNil(stlImpressao);    
end;

end.
