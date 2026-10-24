unit untImpGerencial;

interface

uses Classes,
     untFiscal;

type
  TImprimeGerencial = class(TComponent)
    private
      FPatIni: String;
      FCodEcf: String;
      FModEcf: String;
      FPorta : String;
      FCodErr: String;
      FEcfFiscal: TUntFiscal;
      FPodeImprir: Boolean;
      FCriouECF : Boolean;
    public
      constructor Create(AOwner: TComponent; FEcfFiscalAberto: TUntFiscal = Nil);reintroduce;
      destructor Destroy;reintroduce;

      function fFormatarTextoImp(strTexto: String; FonteEstilos: TFontesImpFiscal): String;
      function fImprimirCodigoBarras( cbTipo: TCodigoBarras; strCodigo, strLargura,
        strAltura: String; strOrientacao: string = 'h'; strImpTexto: String = '1'; strTextoLivre: String = '   '): Boolean;
      function fAbreRelatorioGerencial(blnMostrarErro: Boolean = True): Boolean;
      function fRelatorioGerencial(strTexto: String): Boolean;
      function fFechaRelatorioGerencial(blnVerErro: Boolean = True): Boolean;

      property blnPodeImprimir: Boolean read FPodeImprir;
  end;

implementation

uses untFuncoesSimples;

{ TImprimeGerencial }

constructor TImprimeGerencial.Create(AOwner: TComponent; FEcfFiscalAberto: TUntFiscal = Nil);
begin
  FCriouECF   := False;
  FPodeImprir := Assigned(FEcfFiscalAberto);
  If FPodeImprir Then
    FEcfFiscal  := FEcfFiscalAberto
  Else
  Begin
    FEcfFiscal  := nil;
    FPodeImprir := Assigned(VS_objFiscal);

    If Not FPodeImprir Then
    Begin
      FPatIni := fCfgSis('DIRINI');
      FCodEcf := fArqIniLocal(0, 'IMPRESSORA_FISCAL', 'IMPRESSORA'   , '', FPatIni + '/opcoes_fiscal.ini' );
      FModEcf := fArqIniLocal(0, 'IMPRESSORA_FISCAL', 'MODELO'       , '', FPatIni + '/opcoes_fiscal.ini' );
      FPorta  := fArqIniLocal(0, 'IMPRESSORA_FISCAL', 'PORTA'        , '', FPatIni + '/opcoes_fiscal.ini' );

      FEcfFiscal := TUntFiscal.Create;

      FCriouECF  := True;      

      FPodeImprir := FEcfFiscal.pSetModEcf(FModEcf) And
                     FEcfFiscal.fIniciaEcf(FCodErr, FPatIni, FPorta) And
                     FEcfFiscal.fRetImpLigada(FCodErr);
    End;
  End;
end;

destructor TImprimeGerencial.Destroy;
begin
  If Assigned(FEcfFiscal) And FCriouECF Then
  Begin
    FEcfFiscal.fFinalizaEcf(FCodErr);
    FEcfFiscal.Free;
  End;
end;

function TImprimeGerencial.fAbreRelatorioGerencial(
  blnMostrarErro: Boolean): Boolean;
begin
  Result := False;

  If Assigned(VS_objFiscal) Then
    Result := VS_objFiscal.fAbreRelatorioGerencial(blnMostrarErro)

  Else If Assigned(FEcfFiscal) Then
    Result := FEcfFiscal.fAbreRelatorioGerencial(blnMostrarErro);
end;

function TImprimeGerencial.fRelatorioGerencial(strTexto: String): Boolean;
begin
  Result := False;

  If Assigned(VS_objFiscal) Then
    Result := VS_objFiscal.fRelatorioGerencial(strTexto)

  Else If Assigned(FEcfFiscal) Then
    Result := FEcfFiscal.fRelatorioGerencial(strTexto);
end;

function TImprimeGerencial.fFechaRelatorioGerencial(
  blnVerErro: Boolean): Boolean;
begin
  Result := False;

  If Assigned(VS_objFiscal) Then
    Result := VS_objFiscal.fFechaRelatorioGerencial(blnVerErro)

  Else If Assigned(FEcfFiscal) Then
    Result := FEcfFiscal.fFechaRelatorioGerencial(blnVerErro);
end;

function TImprimeGerencial.fFormatarTextoImp(strTexto: String;
  FonteEstilos: TFontesImpFiscal): String;
begin
  Result := strTexto;

  If Assigned(VS_objFiscal) Then
    Result := VS_objFiscal.fFormatarTextoImp(strTexto, FonteEstilos)

  Else If Assigned(FEcfFiscal) Then
    Result := FEcfFiscal.fFormatarTextoImp(strTexto, FonteEstilos);
end;

function TImprimeGerencial.fImprimirCodigoBarras( cbTipo: TCodigoBarras; strCodigo, strLargura,
  strAltura: String; strOrientacao: string = 'h'; strImpTexto: String = '1'; strTextoLivre: String = '   '): Boolean;
begin
  Result := True;

  If Assigned(VS_objFiscal) Then
    Result := VS_objFiscal.fImprimirCodigoBarras(cbTipo, strCodigo, strLargura, strAltura, strOrientacao, strImpTexto, strTextoLivre)

  Else If Assigned(FEcfFiscal) Then
    Result := FEcfFiscal.fImprimirCodigoBarras(cbTipo, strCodigo, strLargura, strAltura, strOrientacao, strImpTexto, strTextoLivre);
end;

end.
