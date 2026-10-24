unit untFatRomaneio.Recuperacao.Gravar;

interface

uses
  untRomGer, Romaneio.Types;

type
  TRomaneioRecuperacaoGravar = class
  private
    var FIdRestauracao: String;
    FNumRom: String;
    FDadosFiltro: TDadosFiltro;
    FDadosDet: TDadosDet;
    FSimplificado : Boolean;

    function VerificaBranco(AValue: string): Variant; overload;
    function VerificaBranco(AValue: TDateTime): Variant; overload;

    procedure GravaCapa;
    procedure GravaDet;
    procedure GravaFiltro;
    procedure GravaDetParcial(ACodDet: String);

    procedure GravarInternal(var AIdRestauracao: String; ANumRom: String; ADadosFiltro: TDadosFiltro; ADadosDet: TDadosDet);
  public
    class procedure Gravar(var AIdRestauracao: String; ANumRom: String; ADadosFiltro: TDadosFiltro; ADadosDet: TDadosDet; AEhSimplificado :Boolean = false);
  end;

implementation

uses
  System.SysUtils, System.Variants, Data.DB, Uni, untFuncoesSimples;

{ TRomaneioRecuperacaoGravar }

class procedure TRomaneioRecuperacaoGravar.Gravar(var AIdRestauracao: String;
  ANumRom: String; ADadosFiltro: TDadosFiltro; ADadosDet: TDadosDet; AEhSimplificado :Boolean);
var
  LGravar: TRomaneioRecuperacaoGravar;
begin
  LGravar := TRomaneioRecuperacaoGravar.Create;
  LGravar.FSimplificado := AEhSimplificado;
  try
    LGravar.GravarInternal(AIdRestauracao, ANumRom, ADadosFiltro, ADadosDet);
    AIdRestauracao := LGravar.FIdRestauracao;
  finally
    LGravar.Free;
  end;
end;

procedure TRomaneioRecuperacaoGravar.GravarInternal(var AIdRestauracao: String;
  ANumRom: String; ADadosFiltro: TDadosFiltro; ADadosDet: TDadosDet);
begin
  FIdRestauracao := AIdRestauracao;
  FNumRom := ANumRom;
  FDadosFiltro := ADadosFiltro;
  FDadosDet := ADadosDet;

  GravaCapa;
  GravaFiltro;
  GravaDet;
end;

function TRomaneioRecuperacaoGravar.VerificaBranco(AValue: string): Variant;
begin
  if fEmptyStr(AValue) then
    Result := Null
  else
    Result := AValue;
end;

function TRomaneioRecuperacaoGravar.VerificaBranco(AValue: TDateTime): Variant;
begin
  if AValue = 0 then
    Result := Null
  else
    Result := AValue;
end;

procedure TRomaneioRecuperacaoGravar.GravaCapa;
var
  LSqlQry: TUniQuery;
begin
  LSqlQry := fCriaQuery(Nil);
  try
    LSqlQry.SQL.Add('SELECT * FROM ROMGER_RES ');
    LSqlQry.SQL.Add('WHERE GER_CODGER = :CODGER');
    LSqlQry.ParamByName('CODGER').AsString := FIdRestauracao;

    LSqlQry.Open;

    if LSqlQry.IsEmpty then
    begin
      FIdRestauracao := fAtualizaProCod('ROMGER_RES', 'GER_CODGER');

      LSqlQry.Insert;
      LSqlQry.FieldByName('AUTOINCREM').AsString   := fRetAutoIncrem('ROMGER_RES', VS_strCodEmp);
      LSqlQry.FieldByName('GER_CODGER').AsString   := FIdRestauracao;
      LSqlQry.FieldByName('GER_CODOPE').AsString   := strLoginUsuarioLogado;
      LSqlQry.FieldByName('GER_CODEMP').AsString   := VS_strCodEmp;
      LSqlQry.FieldByName('GER_NUMROM').Value      := VerificaBranco(FNumRom);
      LSqlQry.FieldByName('GER_DTACAD').AsDateTime := VS_Date;
      LSqlQry.FieldByName('GER_HORCAD').AsDateTime := fRetHoraServidor;
      LSqlQry.Post;
    end;
  finally
    FreeAndNil(LSqlQry);
  end;
end;

procedure TRomaneioRecuperacaoGravar.GravaFiltro;
var
  LSqlQry: TUniQuery;
begin
  LSqlQry := fCriaQuery(Nil);
  try
    LSqlQry.SQL.Add('SELECT * FROM ROMFIL_RES');
    LSqlQry.SQL.Add('WHERE FIL_SEQGER <=> :SEQGER');
    if not FSimplificado then
    begin
      LSqlQry.SQL.Add('  AND FIL_PERIOD <=> :PERIOD');
      LSqlQry.SQL.Add('  AND FIL_DTAINI <=> :DTAINI');
      LSqlQry.SQL.Add('  AND FIL_DTAFIM <=> :DTAFIM');
      LSqlQry.SQL.Add('  AND FIL_DIAROM <=> :DIAROM');
      LSqlQry.SQL.Add('  AND FIL_CODCID <=> :CODCID');
      LSqlQry.SQL.Add('  AND FIL_CODREG <=> :CODREG');
      LSqlQry.SQL.Add('  AND FIL_CODCLI <=> :CODCLI');
      LSqlQry.SQL.Add('  AND FIL_CODITE <=> :CODITE');
      LSqlQry.SQL.Add('  AND FIL_CODTRA <=> :CODTRA');
      LSqlQry.SQL.Add('  AND FIL_CODROT <=> :CODROT');
      LSqlQry.SQL.Add('  AND FIL_TRAFAT <=> :TRAFAT');
      LSqlQry.SQL.Add('  AND FIL_CODVEN <=> :CODVEN');
      LSqlQry.SQL.Add('  AND FIL_CODDEP <=> :CODDEP');
      LSqlQry.SQL.Add('  AND FIL_LINGRU <=> :LINGRU');
      LSqlQry.SQL.Add('  AND FIL_CODLOT <=> :CODLOT');
      LSqlQry.SQL.Add('  AND FIL_TURNO_ <=> :TURNO_');

      LSqlQry.ParamByName('PERIOD').AsInteger := FDadosFiltro.Periodo;
      LSqlQry.ParamByName('DTAINI').Value     := VerificaBranco(FDadosFiltro.DataInicial);
      LSqlQry.ParamByName('DTAFIM').Value     := VerificaBranco(FDadosFiltro.DataFinal);
      LSqlQry.ParamByName('DIAROM').AsInteger := FDadosFiltro.Dias;
      LSqlQry.ParamByName('CODCID').Value     := VerificaBranco(FDadosFiltro.CodCidade);
      LSqlQry.ParamByName('CODREG').Value     := VerificaBranco(FDadosFiltro.CodRegiao);
      LSqlQry.ParamByName('CODCLI').Value     := VerificaBranco(FDadosFiltro.CodCliente);
      LSqlQry.ParamByName('CODITE').Value     := VerificaBranco(FDadosFiltro.CodProduto);
      LSqlQry.ParamByName('CODTRA').Value     := VerificaBranco(FDadosFiltro.CodTransportadora);
      LSqlQry.ParamByName('CODROT').Value     := VerificaBranco(FDadosFiltro.CodRota);
      LSqlQry.ParamByName('TRAFAT').Value     := VerificaBranco(FDadosFiltro.CodTransFat);
      LSqlQry.ParamByName('CODVEN').Value     := VerificaBranco(FDadosFiltro.CodVendedor);
      LSqlQry.ParamByName('CODDEP').Value     := VerificaBranco(FDadosFiltro.CodDepartamento);
      LSqlQry.ParamByName('LINGRU').Value     := VerificaBranco(FDadosFiltro.CodLinhaGrupo);
      LSqlQry.ParamByName('CODLOT').Value     := VerificaBranco(FDadosFiltro.CodLote);
      LSqlQry.ParamByName('TURNO_').AsInteger := FDadosFiltro.Turno;
      //    Comparação com "<=>" por causa da comparação com NULL
    end
    else
    begin
      LSqlQry.SQL.Add('  AND FIL_CODBAR <=> :CODBAR');

      LSqlQry.ParamByName('CODBAR').Value  := VerificaBranco(FDadosFiltro.CodigoBarras);
    end;

    LSqlQry.ParamByName('SEQGER').AsString  := FIdRestauracao;



    LSqlQry.Open;

    if (LSqlQry.IsEmpty) Or (FSimplificado) then
    begin
      LSqlQry.Insert;
      LSqlQry.FieldByName('AUTOINCREM').AsString  := fRetAutoIncrem('ROMFIL_RES', VS_strCodEmp);
      LSqlQry.FieldByName('FIL_CODFIL').AsString  := fAtualizaProCod('ROMFIL_RES', 'FIL_CODFIL');
      LSqlQry.FieldByName('FIL_SEQGER').AsString  := FIdRestauracao;

      if not FSimplificado then
      begin
        LSqlQry.FieldByName('FIL_PERIOD').AsInteger := FDadosFiltro.Periodo;
        LSqlQry.FieldByName('FIL_DTAINI').Value     := VerificaBranco(FDadosFiltro.DataInicial);
        LSqlQry.FieldByName('FIL_DTAFIM').Value     := VerificaBranco(FDadosFiltro.DataFinal);
        LSqlQry.FieldByName('FIL_DIAROM').AsInteger := FDadosFiltro.Dias;
        LSqlQry.FieldByName('FIL_CODCID').Value     := VerificaBranco(FDadosFiltro.CodCidade);
        LSqlQry.FieldByName('FIL_CODREG').Value     := VerificaBranco(FDadosFiltro.CodRegiao);
        LSqlQry.FieldByName('FIL_CODCLI').Value     := VerificaBranco(FDadosFiltro.CodCliente);
        LSqlQry.FieldByName('FIL_CODITE').Value     := VerificaBranco(FDadosFiltro.CodProduto);
        LSqlQry.FieldByName('FIL_CODTRA').Value     := VerificaBranco(FDadosFiltro.CodTransportadora);
        LSqlQry.FieldByName('FIL_CODROT').Value     := VerificaBranco(FDadosFiltro.CodRota);
        LSqlQry.FieldByName('FIL_TRAFAT').Value     := VerificaBranco(FDadosFiltro.CodTransFat);
        LSqlQry.FieldByName('FIL_CODVEN').Value     := VerificaBranco(FDadosFiltro.CodVendedor);
        LSqlQry.FieldByName('FIL_CODDEP').Value     := VerificaBranco(FDadosFiltro.CodDepartamento);
        LSqlQry.FieldByName('FIL_LINGRU').Value     := VerificaBranco(FDadosFiltro.CodLinhaGrupo);
        LSqlQry.FieldByName('FIL_CODLOT').Value     := VerificaBranco(FDadosFiltro.CodLote);
        LSqlQry.FieldByName('FIL_TURNO_').AsInteger := FDadosFiltro.Turno;
      end
      else
        LSqlQry.FieldByName('FIL_CODBAR').Value  := VerificaBranco(FDadosFiltro.CodigoBarras);
      LSqlQry.Post;
    end;
  finally
    FreeAndNil(LSqlQry);
  end;
end;

procedure TRomaneioRecuperacaoGravar.GravaDet;
var
  LSqlQry: TUniQuery;
  LCodDet: String;
begin
  LSqlQry := fCriaQuery(Nil);
  try
    LSqlQry.SQL.Add('SELECT * FROM ROMDET_RES ');
    LSqlQry.SQL.Add('WHERE DET_SEQGER = :SEQGER');
    LSqlQry.SQL.Add('  AND DET_NUMDOC = :NUMDOC');
    LSqlQry.SQL.Add('  AND DET_ESPDOC = :ESPDOC');
    LSqlQry.SQL.Add('  AND DET_CODEMP = :CODEMP');
    LSqlQry.SQL.Add('  AND DET_CODCLI = :CODCLI');
    LSqlQry.SQL.Add('  AND DET_TIP_FC = :TIP_FC');

    LSqlQry.ParamByName('SEQGER').AsString := FIdRestauracao;
    LSqlQry.ParamByName('NUMDOC').AsString := FDadosDet.NumeroDocumento;
    LSqlQry.ParamByName('ESPDOC').AsString := FDadosDet.EspecieDocumento;
    LSqlQry.ParamByName('CODEMP').AsString := FDadosDet.CodEmpresa;
    LSqlQry.ParamByName('CODCLI').AsString := FDadosDet.CodCliente;
    LSqlQry.ParamByName('TIP_FC').AsString := FDadosDet.Tip_FC;

    LSqlQry.Open;
    if LSqlQry.IsEmpty then
    begin
      LCodDet := fAtualizaProCod('ROMDET_RES', 'DET_CODDET');
      LSqlQry.Insert;
      LSqlQry.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('ROMDET_RES', VS_strCodEmp);
      LSqlQry.FieldByName('DET_CODDET').AsString := LCodDet;
      LSqlQry.FieldByName('DET_SEQGER').AsString := FIdRestauracao;
      LSqlQry.FieldByName('DET_NUMDOC').AsString := FDadosDet.NumeroDocumento;
      LSqlQry.FieldByName('DET_ESPDOC').AsString := FDadosDet.EspecieDocumento;
      LSqlQry.FieldByName('DET_CODEMP').AsString := FDadosDet.CodEmpresa;
      LSqlQry.FieldByName('DET_CODCLI').AsString := FDadosDet.CodCliente;
      LSqlQry.FieldByName('DET_TIP_FC').AsString := FDadosDet.Tip_FC;
    end
    else
    begin
      LCodDet := LSqlQry.FieldByName('DET_CODDET').AsString;
      LSqlQry.Edit;
    end;

    LSqlQry.FieldByName('DET_VEICUL').Value     := VerificaBranco(FDadosDet.Veicul);
    LSqlQry.FieldByName('DET_MARDES').AsString  := FDadosDet.MarDes;
    LSqlQry.FieldByName('DET_PALET_').Value     := VerificaBranco(FDadosDet.Palet);
    LSqlQry.FieldByName('DET_VALSEL').AsFloat   := FDadosDet.ValorSelecionado;
    LSqlQry.FieldByName('DET_ORDIMP').AsInteger := FDadosDet.OrdemImpressao;
    if FSimplificado then
      LSqlQry.FieldByName('DET_VOLBIP').AsInteger := FDadosDet.VolumeBipado;

    LSqlQry.Post;

    if FDadosDet.MarDes = 'P' then
      GravaDetParcial(LCodDet);
  finally
    FreeAndNil(LSqlQry);
  end;
end;

procedure TRomaneioRecuperacaoGravar.GravaDetParcial(ACodDet: String);
var
  LSqlQry: TUniQuery;
begin
  LSqlQry := fCriaQuery(Nil);
  try
    FDadosDet.cdsRomDet.Filtered := False;
    FDadosDet.cdsRomDet.Filter :=                              'DET_NUMDOC = ' + FDadosDet.NumeroDocumento.QuotedString  + ' AND ';
    FDadosDet.cdsRomDet.Filter := FDadosDet.cdsRomDet.Filter + 'DET_ESPDOC = ' + FDadosDet.EspecieDocumento.QuotedString + ' AND ';
    FDadosDet.cdsRomDet.Filter := FDadosDet.cdsRomDet.Filter + 'DET_CODEMP = ' + FDadosDet.CodEmpresa.QuotedString       + ' AND ';
    FDadosDet.cdsRomDet.Filter := FDadosDet.cdsRomDet.Filter + 'DET_CODCLI = ' + FDadosDet.CodCliente.QuotedString       + ' AND ';
    FDadosDet.cdsRomDet.Filter := FDadosDet.cdsRomDet.Filter + 'DET_TIP_FC = ' + FDadosDet.Tip_FC.QuotedString;
    FDadosDet.cdsRomDet.Filtered := True;

    LSqlQry.Close;
    LSqlQry.SQL.Clear;
    LSqlQry.SQL.Add('SELECT * FROM ROMPAR_RES ');
    LSqlQry.SQL.Add('WHERE PAR_CODDET = :CODDET');
    LSqlQry.SQL.Add('  AND PAR_CODITE = :CODITE');


    FDadosDet.cdsRomDet.First;
    while not FDadosDet.cdsRomDet.Eof do
    begin
      LSqlQry.Close;
      LSqlQry.ParamByName('CODDET').AsString := ACodDet;
      LSqlQry.ParamByName('CODITE').AsString := FDadosDet.cdsRomDet.FieldByName('DET_CODITE').Value;
      LSqlQry.Open;

      if LSqlQry.IsEmpty then
      begin
        LSqlQry.Insert;
        LSqlQry.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('ROMPAR_RES', VS_strCodEmp);
        LSqlQry.FieldByName('PAR_CODPAR').AsString := fAtualizaProCod('ROMPAR_RES', 'PAR_CODPAR');
        LSqlQry.FieldByName('PAR_CODDET').AsString := ACodDet;
        LSqlQry.FieldByName('PAR_CODITE').Value    := FDadosDet.cdsRomDet.FieldByName('DET_CODITE').Value;
      end
      else
        LSqlQry.Edit;

      LSqlQry.FieldByName('PAR_DESITE').Value := FDadosDet.cdsRomDet.FieldByName('DET_DESITE').Value;
      LSqlQry.FieldByName('PAR_NUMLOT').Value := FDadosDet.cdsRomDet.FieldByName('DET_NUMLOT').Value;
      LSqlQry.FieldByName('PAR_QTDBAI').Value := FDadosDet.cdsRomDet.FieldByName('DET_QTDBAI').Value;
      LSqlQry.FieldByName('PAR_INFITE').Value := FDadosDet.cdsRomDet.FieldByName('DET_INFITE').Value;
      LSqlQry.Post;

      FDadosDet.cdsRomDet.Next;
    end;
    FDadosDet.cdsRomDet.Filtered := False;
  finally
    FreeAndNil(LSqlQry);
  end;
end;

end.
