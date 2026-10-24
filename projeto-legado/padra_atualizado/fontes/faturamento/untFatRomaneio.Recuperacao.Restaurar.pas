unit untFatRomaneio.Recuperacao.Restaurar;

interface

uses
  UniClientDataSet, cxProgressBar, Uni, untFatRomaneio, untTypesSistema, Romaneio.Types;

type
  TFunctionPodeMarcarDocumento = function (var blnDeletaRegistro: Boolean): Boolean of object;

  TParametrosRestaurar = record
    IdRestauracao: String;
    blnEhSimplificado : Boolean;
    FrmFatRomaneio: TfrmFatRomaneio;
    FunctionTravaRomaneio: TGenericFunctionWithoutParam;
    ProcedureConsulta: TFunctionFormGravando;
    ProcedureVerificaDuplicados: TGenericProcedure;
    FunctionPodeMarcarDocumento: TFunctionPodeMarcarDocumento;
    ProcedureAdicionaDadosRomDet: TGenericProcedure;
  end;

  TRomaneioRecuperacaoRestaurar = class
  private
    FParametros: TParametrosRestaurar;
    procedure RestaurarInternal(AParametros: TParametrosRestaurar);

    function fRetornaDataStr(AdtaMsk: TDateTime): String;
    procedure MontarGrid;
    procedure SelecionarItensGrid;

    procedure RestauraInformacoes(ASqlQry: TUniQuery);
    procedure RestauraInformacoesParcial(ASqlQry: TUniQuery);

    function Alimentar(pgbStatus: TcxProgressBar) : Boolean;
    function Selecionar(pgbStatus: TcxProgressBar): Boolean;
  public
    class procedure Restaurar(AParametros: TParametrosRestaurar);
  end;

implementation

uses
  Variants, System.SysUtils, Vcl.Forms, untFuncoesSimples, untGravando;

function TRomaneioRecuperacaoRestaurar.fRetornaDataStr(AdtaMsk: TDateTime): String;
begin
  Result := '';
  if (AdtaMsk > 0) then
    Result := DateToStr(AdtaMsk);
end;

procedure TRomaneioRecuperacaoRestaurar.MontarGrid;
var
  LfrmGravando : TfrmGravando;
begin
  Try
    FParametros.FrmFatRomaneio.Manter := tmTodos;
    Try
      pCriarFormularios(TfrmGravando, LfrmGravando);
      LfrmGravando.lblGravando.Caption := 'Aguarde... Carregando.';
      LfrmGravando.fExecutarAcao := Alimentar;
      LfrmGravando.ShowModal;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message,'[TRomaneioRecuperacaoRestaurar.MontarGrid]');
      End;
    End;
  finally
    FParametros.FrmFatRomaneio.Manter := tmNenhum;
    pFreeAndNil(LfrmGravando);
  end;
end;

procedure TRomaneioRecuperacaoRestaurar.RestauraInformacoes(ASqlQry: TUniQuery);
begin
  if ASqlQry.FieldByName('DET_MARDES').AsString = 'M' then
    FParametros.FrmFatRomaneio.QtdSel := FParametros.FrmFatRomaneio.QtdSel + 1;

  FParametros.FrmFatRomaneio.DsTmpDoc.Edit;
  FParametros.FrmFatRomaneio.DsTmpDoc.FieldByName('GER_VEICUL').Value := ASqlQry.FieldByName('DET_VEICUL').AsString;
  FParametros.FrmFatRomaneio.DsTmpDoc.FieldByName('GER_MARDES').Value := ASqlQry.FieldByName('DET_MARDES').AsString;
  FParametros.FrmFatRomaneio.DsTmpDoc.FieldByName('GER_PALET_').Value := ASqlQry.FieldByName('DET_PALET_').AsString;
  FParametros.FrmFatRomaneio.DsTmpDoc.FieldByName('GER_VALSEL').Value := ASqlQry.FieldByName('DET_VALSEL').AsString;
  FParametros.FrmFatRomaneio.DsTmpDoc.FieldByName('GER_ORDIMP').Value := ASqlQry.FieldByName('DET_ORDIMP').AsString;
  FParametros.FrmFatRomaneio.DsTmpDoc.FieldByName('GER_VOLBIP').Value := ASqlQry.FieldByName('DET_VOLBIP').AsInteger;

  FParametros.FrmFatRomaneio.DsTmpDoc.Post;

  if ASqlQry.FieldByName('DET_MARDES').AsString = 'P' then
    RestauraInformacoesParcial(ASqlQry)
  else
  If (FParametros.FrmFatRomaneio.DsTmpDoc.FieldByName('GER_ALTERA').AsString <> 'S') Then
    FParametros.ProcedureAdicionaDadosRomDet;

  FParametros.FrmFatRomaneio.TotSel := FParametros.FrmFatRomaneio.TotSel + fFormataFloat(FParametros.FrmFatRomaneio.DsTmpDoc.FieldByName('GER_VALSEL').AsFloat, 2);
end;

procedure TRomaneioRecuperacaoRestaurar.RestauraInformacoesParcial(
  ASqlQry: TUniQuery);
var
  LQryParcial: TUniQuery;
begin
  FParametros.ProcedureAdicionaDadosRomDet();
  LQryParcial := fCriaQuery(Nil);
  try
    LQryParcial.SQL.Add('SELECT * FROM ROMPAR_RES');
    LQryParcial.SQL.Add('WHERE PAR_CODDET = :CODDET');
    LQryParcial.ParamByName('CODDET').AsString := ASqlQry.FieldByName('DET_CODDET').AsString;
    LQryParcial.Open;

    while not LQryParcial.Eof do
    begin
      if FParametros.FrmFatRomaneio.DSRomDet.Locate(
        'DET_CODITE;DET_DESITE;DET_NUMLOT',
        VarArrayOf([LQryParcial.FieldByName('PAR_CODITE').AsString, LQryParcial.FieldByName('PAR_DESITE').AsString,LQryParcial.FieldByName('PAR_NUMLOT').AsString]),
        []) then
      begin
        FParametros.FrmFatRomaneio.DSRomDet.Edit;
        FParametros.FrmFatRomaneio.DSRomDet.FieldByName('DET_QTDBAI').Value := LQryParcial.FieldByName('PAR_QTDBAI').Value;
        FParametros.FrmFatRomaneio.DSRomDet.FieldByName('DET_INFITE').Value := LQryParcial.FieldByName('PAR_INFITE').Value;
        FParametros.FrmFatRomaneio.DSRomDet.Post;
      end;

      LQryParcial.Next;
    end;

  finally
    FreeAndNil(LQryParcial);
  end;
end;

class procedure TRomaneioRecuperacaoRestaurar.Restaurar(
  AParametros: TParametrosRestaurar);
var
  LRestaurar: TRomaneioRecuperacaoRestaurar;
begin
  LRestaurar := TRomaneioRecuperacaoRestaurar.Create;
  try
    LRestaurar.RestaurarInternal(AParametros);
  finally
    LRestaurar.Free;
  end;
end;

procedure TRomaneioRecuperacaoRestaurar.RestaurarInternal(AParametros: TParametrosRestaurar);
begin
  FParametros := AParametros;

  MontarGrid();
  SelecionarItensGrid();
end;

function TRomaneioRecuperacaoRestaurar.Alimentar(pgbStatus: TcxProgressBar) : Boolean;
var
  LSqlQry: TUniQuery;
  LfrmGravando : TfrmGravando;
begin
  pgbStatus.Position := 0;

  LSqlQry := fCriaQuery(Nil);
  try
    LSqlQry.Close;
    LSqlQry.SQL.Clear;
    LSqlQry.SQL.Add('SELECT F.*, G.GER_NUMROM FROM ROMFIL_RES F');
    LSqlQry.SQL.Add('  INNER JOIN ROMGER_RES G ON G.GER_CODGER = F.FIL_SEQGER');
    LSqlQry.SQL.Add('WHERE F.FIL_SEQGER = :SEQGER');

    LSqlQry.ParamByName('SEQGER').AsString := FParametros.IdRestauracao;

    LSqlQry.Open;

    pgbStatus.Properties.Max := LSqlQry.RecordCount;

    while not LSqlQry.Eof do
    begin
      FParametros.FrmFatRomaneio.edtNumRom.Text     := LSqlQry.FieldByName('GER_NUMROM').AsString;

      if not FParametros.blnEhSimplificado then
      begin
        If (Not FParametros.FunctionTravaRomaneio) Then
          Exit(False);

        if LSqlQry.FieldByName('FIL_PERIOD').AsInteger = 1 then
          FParametros.FrmFatRomaneio.rdbEntrada.Checked := True
        else
        if LSqlQry.FieldByName('FIL_PERIOD').AsInteger = 2 then
          FParametros.FrmFatRomaneio.rdbEntrega.Checked := True;

        FParametros.FrmFatRomaneio.mskDtaIni.Text := fRetornaDataStr(LSqlQry.FieldByName('FIL_DTAINI').AsDateTime);
        FParametros.FrmFatRomaneio.mskDtaFin.Text := fRetornaDataStr(LSqlQry.FieldByName('FIL_DTAFIM').AsDateTime);

        FParametros.FrmFatRomaneio.edtDiaRom.Text     := IntToStr(LSqlQry.FieldByName('FIL_DIAROM').AsInteger);
        FParametros.FrmFatRomaneio.edtCodCid.Text     := LSqlQry.FieldByName('FIL_CODCID').AsString;
        FParametros.FrmFatRomaneio.edtCodReg.Text     := LSqlQry.FieldByName('FIL_CODREG').AsString;
        FParametros.FrmFatRomaneio.edtCodCliente.Text := LSqlQry.FieldByName('FIL_CODCLI').AsString;
        FParametros.FrmFatRomaneio.edtCodProduto.Text := LSqlQry.FieldByName('FIL_CODITE').AsString;
        FParametros.FrmFatRomaneio.edtCodTra.Text     := LSqlQry.FieldByName('FIL_CODTRA').AsString;
        FParametros.FrmFatRomaneio.edtCodRot.Text     := LSqlQry.FieldByName('FIL_CODROT').AsString;
        FParametros.FrmFatRomaneio.edtTraFat.Text     := LSqlQry.FieldByName('FIL_TRAFAT').AsString;
        FParametros.FrmFatRomaneio.edtCodVen.Text     := LSqlQry.FieldByName('FIL_CODVEN').AsString;
        FParametros.FrmFatRomaneio.edtCodDep.Text     := LSqlQry.FieldByName('FIL_CODDEP').AsString;
        FParametros.FrmFatRomaneio.edtLinGru.Text     := LSqlQry.FieldByName('FIL_LINGRU').AsString;
        FParametros.FrmFatRomaneio.edtCodLot.Text     := LSqlQry.FieldByName('FIL_CODLOT').AsString;
        FParametros.FrmFatRomaneio.rdgTurno.ItemIndex := LSqlQry.FieldByName('FIL_TURNO_').AsInteger;
      end
      else
        FParametros.FrmFatRomaneio.edtCodBar.Text     := LSqlQry.FieldByName('FIL_CODBAR').AsString;

      Try
        pCriarFormularios(TfrmGravando,LfrmGravando);
        LfrmGravando.lblGravando.Caption := 'Aguarde... Carregando.';
        LfrmGravando.strChave := 'PEDCOM';
        LfrmGravando.fExecutarAcao := FParametros.ProcedureConsulta;
        LfrmGravando.ShowModal;
      finally
        pFreeAndNil(LfrmGravando);
      end;

      LSqlQry.Next;

      pgbStatus.Position := pgbStatus.Position + 1;
      Application.ProcessMessages;
    end;

    FParametros.ProcedureVerificaDuplicados;
    Result := True;
  finally
    FreeAndNil(LSqlQry);
  end;
end;

function TRomaneioRecuperacaoRestaurar.Selecionar(pgbStatus: TcxProgressBar) : Boolean;
var
  prcScroll: TprcScroll;
  blnDeletaRegistro : Boolean;
var
  LSqlQry: TUniQuery;
begin
  pgbStatus.Position := 0;

  LSqlQry := fCriaQuery(Nil);
  try
    LSqlQry.Close;
    LSqlQry.SQL.Clear;
    LSqlQry.SQL.Add('SELECT * FROM ROMDET_RES');
    LSqlQry.SQL.Add('WHERE DET_SEQGER = :SEQGER');

    LSqlQry.ParamByName('SEQGER').AsString := FParametros.IdRestauracao;

    LSqlQry.Open;
    pgbStatus.Properties.Max := LSqlQry.RecordCount;
    pDisableControls(FParametros.FrmFatRomaneio.DsTmpDoc, prcScroll);

    while not LSqlQry.Eof do
    begin
      if FParametros.FrmFatRomaneio.DsTmpDoc.Locate(
        'GER_DOCORI;GER_ESPDOC;GER_CODCLI;GER_CODEMP;GER_TIP_FC',
        VarArrayOf([LSqlQry.FieldByName('DET_NUMDOC').AsString, LSqlQry.FieldByName('DET_ESPDOC').AsString, LSqlQry.FieldByName('DET_CODCLI').AsString, LSqlQry.FieldByName('DET_CODEMP').AsString, LSqlQry.FieldByName('DET_TIP_FC').AsString]),
        []) then
      begin
        If (Not FParametros.FunctionPodeMarcarDocumento(blnDeletaRegistro)) Then
        Begin
          If (blnDeletaRegistro) Then
            FParametros.FrmFatRomaneio.DsTmpDoc.Delete;
        End
        else
          RestauraInformacoes(LSqlQry);

      end;

      LSqlQry.Next;

      pgbStatus.Position := pgbStatus.Position + 1;
      Application.ProcessMessages;
    end;
    FParametros.FrmFatRomaneio.DsTmpDoc.Filtered := False;
    pEnableControls(FParametros.FrmFatRomaneio.DsTmpDoc, prcScroll);

    Result := True;
  finally
    FreeAndNil(LSqlQry);
  end;
end;

procedure TRomaneioRecuperacaoRestaurar.SelecionarItensGrid;
var
  LfrmGravando : TfrmGravando;
begin
  Try
    Try
      pCriarFormularios(TfrmGravando, LfrmGravando);
      LfrmGravando.lblGravando.Caption := 'Aguarde... Selecionando itens.';
      LfrmGravando.fExecutarAcao := Selecionar;
      LfrmGravando.ShowModal;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message,'[TRomaneioRecuperacaoRestaurar.SelecionarItensGrid]');
      End;
    End;
  finally
    pFreeAndNil(LfrmGravando);
  end;
end;

end.
