unit untConfiguraConsultaOperadores;

interface

uses Windows, Classes, StrUtils, SysUtils, Controls, Uni, UniClientDataSet,
  UniDataSetProvider, DB, Forms, Variants, StdCtrls,
  untGravando, cxProgressBar, untTypesSistema;


Type
  TConfiguraConsultaOperadores = Class
  private
    qryGeneri: TUniQuery;
    qryCadOpe: TUniQuery;
    qryCadGpo: TUniQuery;
    cdsCadOpe: TUniClientDataSet;
    cdsCadGpo: TUniClientDataSet;
    dspCadOpe: TUniDataSetProvider;
    dspCadGpo: TUniDataSetProvider;

    blnMarcar: Boolean;

    FSeqCfgCon : String;
    FTabCfgCon : String;
    FTabCfgEmp : String;
    FOperadores: TStringList;

    procedure  pPreparaComponentes;
    procedure  pDestroiComponentes;
    procedure  pPreparaDados;

    procedure  pListarOperadoresSelecionados;
    procedure  pListarOperadoresNosGruposSelecionados;

    function   fGetSQLOperador: String;
    function   fGetSQLGrupo: String;

    function   fMarcaDesmarcaTotalOperador(pgbProgresso: TcxProgressBar): Boolean;
    function   fMarcaDesmarcaTotalGrupo(pgbProgresso: TcxProgressBar): Boolean;

    function   fOperadorSelecionado: Boolean;
    function   fGrupoSelecionado: Boolean;

    function   fReplicarConfiguracaoConsulta: Boolean;
    function   fReplicarConfiguracaoConsultaInterna(pgbProgresso: TcxProgressBar): Boolean;

  public
    function getCdsOpe: TDataSet;
    function getCdsGpo: TDataSet;

    function getMarcarOpe: Boolean;
    function getMarcarGpo: Boolean;

    function fTemRegistroSelecionado: Boolean;

    procedure pMarcaDesmarcaOperador(blnMarcar: Boolean);
    procedure pMarcaDesmarcaGrupo(blnMarcar: Boolean);

    procedure pMarcaDesmarcaTotalOperador(blnMarcar: Boolean);
    procedure pMarcaDesmarcaTotalGrupo(blnMarcar: Boolean);

    function fReplicarConfigConsultaParaOperadores(strTabCfgCon, strSeqCfgCon: String): Boolean;
    function fReplicarConfigConsultaParaOperador(strTabCfgCon, strSeqCfgCon, strOperador: String): Boolean;

    Constructor Create();
    Destructor  Destroy; override;
  End;

implementation

uses
  untFuncoesGen;

{ TConfiguraConsultaOperadores }

constructor TConfiguraConsultaOperadores.Create();
begin
  inherited create();
  pPreparaComponentes;
  pPreparaDados;
end;

destructor TConfiguraConsultaOperadores.Destroy;
begin
  pDestroiComponentes;
  inherited destroy;
end;

function TConfiguraConsultaOperadores.fGetSQLGrupo: String;
begin
  Result := '';
  Result := Result + 'SELECT              ';
  Result := Result + '  GPO_CODGPO,       ';
  Result := Result + '  GPO_DESCRI,       ';
  Result := Result + '  "N" AS GPO_MARDES ';
  Result := Result + 'FROM                ';
  Result := Result + '  CADGPO            ';
  Result := Result + 'ORDER BY            ';
  Result := Result + '  GPO_DESCRI        ';
end;

function TConfiguraConsultaOperadores.fGetSQLOperador: String;
begin
  Result := '';
  Result := Result + 'SELECT              ';
  Result := Result + '  OPE_CODOPE,       ';
  Result := Result + '  OPE_NOMOPE,       ';
  Result := Result + '  "N" AS OPE_MARDES ';
  Result := Result + 'FROM                ';
  Result := Result + '  CADOPE            ';
  Result := Result + 'WHERE               ';
  Result := Result + '  OPE_STATUS <> "I" AND ';
  Result := Result + '  OPE_CODOPE <> "' + strUsuarioLogado + '" ';
  Result := Result + 'ORDER BY            ';
  Result := Result + '  OPE_NOMOPE        ';
end;

function TConfiguraConsultaOperadores.fReplicarConfigConsultaParaOperador(
  strTabCfgCon, strSeqCfgCon, strOperador: String): Boolean;
begin
  Self.FTabCfgCon := strTabCfgCon;
  Self.FSeqCfgCon := strSeqCfgCon;

  FTabCfgEmp := 'CFGEMP';

  If FTabCfgCon = 'SELCON' Then
    FTabCfgEmp := 'SELEMP';

  Self.FOperadores.Text := strOperador;

  Result := fReplicarConfiguracaoConsulta;
end;

function TConfiguraConsultaOperadores.fReplicarConfigConsultaParaOperadores(strTabCfgCon, strSeqCfgCon: String): Boolean;
begin
  Self.FTabCfgCon := strTabCfgCon;
  Self.FSeqCfgCon := strSeqCfgCon;

  FTabCfgEmp := 'CFGEMP';

  If FTabCfgCon = 'SELCON' Then
    FTabCfgEmp := 'SELEMP';

  Self.FOperadores.Clear;

  pListarOperadoresSelecionados;
  pListarOperadoresNosGruposSelecionados;

  Result := fReplicarConfiguracaoConsulta;
end;

function TConfiguraConsultaOperadores.fReplicarConfiguracaoConsulta: Boolean;
Var
  frmGravando: TfrmGravando;
begin

  Result := False;

  If (FOperadores.Count > 0) Then
  Begin
    Try

      pCriarFormularios(TfrmGravando, frmGravando);
      frmGravando. fExecutarAcao := fReplicarConfiguracaoConsultaInterna;
      frmGravando.showModal;
      Result := frmGravando.blnConfirma;

    Except
      On E: Exception Do
        pMensagensErro(e.Message, '[TConfiguraConsultaOperadores.fReplicarConfiguracaoConsulta]');
    End;

    pFreeAndNil(frmGravando);
  End
  Else
    Result := True;

end;

function TConfiguraConsultaOperadores.fReplicarConfiguracaoConsultaInterna(
  pgbProgresso: TcxProgressBar): Boolean;
Var
  strOperador: String;

  qryCfgCon  : TUniQuery;
  qryCfgEmp  : TUniQuery;
  qryCfgCam  : TUniQuery;

  qryCfgConAux: TUniQuery;
  qryCfgEmpAux: TUniQuery;
  qryCfgCamAux: TUniQuery;

  procedure pCriarComponentesQuery;
  begin
    qryCfgCon := fCriaQuery(nil);
    qryCfgEmp := fCriaQuery(nil);

    If FTabCfgCon = 'SELCON' Then
      qryCfgCam := fCriaQuery(nil);

    qryCfgConAux := fCriaQuery(nil);
    qryCfgEmpAux := fCriaQuery(nil);

    If FTabCfgCon = 'SELCON' Then
      qryCfgCamAux := fCriaQuery(nil);
  end;

  procedure pDestruirComponentesQuery;
  begin
    FreeAndNil(qryCfgCon);
    FreeAndNil(qryCfgEmp);

    If FTabCfgCon = 'SELCON' Then
      FreeAndNil(qryCfgCam);
  end;

  procedure pCarregarTabelasPrincipais;
  begin
    qryCfgCon.Close;
    qryCfgCon.SQL.Text := 'SELECT * FROM ' + FTabCfgCon + ' WHERE AUTOINCREM = ' + FSeqCfgCon.QuotedString;
    qryCfgCon.Open;

    qryCfgEmp.Close;
    qryCfgEmp.SQL.Text := 'SELECT * FROM ' + FTabCfgEmp + ' WHERE CFG_SEQGER = ' + FSeqCfgCon.QuotedString;
    qryCfgEmp.Open;

    If FTabCfgCon = 'SELCON' Then
    Begin
      qryCfgCam.Close;
      qryCfgCam.SQL.Text := 'SELECT * FROM SELCAM WHERE CAM_SEQGER = ' + FSeqCfgCon.QuotedString;
      qryCfgCam.Open;
    End;
  end;

  procedure pCarregarTabelasAuxiliares;
  begin
    qryCfgConAux.Close;
    qryCfgConAux.SQL.Text := 'SELECT * FROM ' + FTabCfgCon +
      ' WHERE AUTOINCREM <> ' + FSeqCfgCon.QuotedString +
      ' AND CFG_CODOPE = ' + strOperador.QuotedString +
      ' AND CFG_CHAVE_ = ' + qryCfgCon.FieldByName('CFG_CHAVE_').AsString.QuotedString;
    qryCfgConAux.Open;

    qryCfgEmpAux.Close;
    qryCfgEmpAux.SQL.Text := 'SELECT * FROM ' + FTabCfgEmp +
      ' WHERE CFG_SEQGER = ' + qryCfgConAux.FieldByName('AUTOINCREM').AsString.QuotedString;
    qryCfgEmpAux.Open;

    If FTabCfgCon = 'SELCON' Then
    Begin
      qryCfgCamAux.Close;
      qryCfgCamAux.SQL.Text := 'SELECT * FROM SELCAM ' +
        'WHERE CAM_SEQGER = ' + qryCfgConAux.FieldByName('AUTOINCREM').AsString.QuotedString;
      qryCfgCamAux.Open;
    End;
  end;

  procedure pCopiarRegistro(qryOrigem, qryDestino: TUniQuery);
    Var
      intField: Integer;
  begin
    For intField := 0 To qryOrigem.FieldCount -1 Do
      If (qryOrigem.Fields[intField].FieldName <> 'AUTOINCREM') And
         (qryOrigem.Fields[intField].FieldName <> 'CFG_SEQGER') And
         (qryOrigem.Fields[intField].FieldName <> 'CAM_SEQGER') And
         (qryOrigem.Fields[intField].FieldName <> 'CFG_CODOPE') Then
        qryDestino.Fields[intField].Value := qryOrigem.Fields[intField].Value;
  end;

  procedure pReplicarTabelaConfiguracao;
  begin
    If qryCfgConAux.IsEmpty Then
    Begin
      qryCfgConAux.Append;
      qryCfgConAux.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem(FTabCfgCon, VS_strCodEmp);
      qryCfgConAux.FieldByName('CFG_CODOPE').AsString := strOperador;
    End
    Else
      qryCfgConAux.Edit;

    pCopiarRegistro(qryCfgCon, qryCfgConAux);
    qryCfgConAux.Post;
  end;

  procedure pReplicarTabelaEmpresas;
  begin
    qryCfgEmp.First;
    While Not qryCfgEmp.Eof Do
    Begin
      qryCfgEmpAux.Filtered := False;
      qryCfgEmpAux.Filter   := 'CFG_CODEMP = ' + QuotedStr(qryCfgEmp.FieldByName('CFG_CODEMP').AsString);
      qryCfgEmpAux.Filtered := True;

      If qryCfgEmpAux.IsEmpty Then
      Begin
        qryCfgEmpAux.Append;
        qryCfgEmpAux.FieldByName('CFG_SEQGER').AsString := qryCfgConAux.FieldByName('AUTOINCREM').AsString;
      End
      Else
        qryCfgEmpAux.Edit;

      pCopiarRegistro(qryCfgEmp, qryCfgEmpAux);
      qryCfgEmpAux.Post;
      qryCfgEmp.Next;
    End;
  end;




  procedure pReplicarTabelaCampos;
  begin
    If FTabCfgCon <> 'SELCON' Then
      Exit;

    //VERIFICA SE o Alias existe na origem se não remove, para não deixar sujeira anterior.
    qryCfgCamAux.First;
    while not qryCfgCamAux.Eof Do
    Begin
      qryCfgCam.Filtered := False;
      qryCfgCam.Filter   := 'CAM_ALIAS_ = ' + QuotedStr(qryCfgCamAux.FieldByName('CAM_ALIAS_').AsString);
      qryCfgCam.Filtered := True;
      If qryCfgCam.IsEmpty Then
        qryCfgCamAux.Delete
      Else
        qryCfgCamAux.Next;
    End;

    qryCfgCam.Filtered := False;

    qryCfgCam.First;



    While Not qryCfgCam.Eof Do
    Begin


      qryCfgCamAux.Filtered := False;
      qryCfgCamAux.Filter   := 'CAM_ALIAS_ = ' + QuotedStr(qryCfgCam.FieldByName('CAM_ALIAS_').AsString);
      qryCfgCamAux.Filtered := True;

      If qryCfgCamAux.IsEmpty Then
      Begin
        qryCfgCamAux.Append;
        qryCfgCamAux.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('SELCAM', VS_strCodEmp);
        qryCfgCamAux.FieldByName('CAM_SEQGER').AsString := qryCfgConAux.FieldByName('AUTOINCREM').AsString;
      End
      Else
        qryCfgCamAux.Edit;

      pCopiarRegistro(qryCfgCam, qryCfgCamAux);
      qryCfgCamAux.Post;
      qryCfgCam.Next;
    End;
  end;

begin
  Result := True;

  pCriarComponentesQuery;

  Try
    pgbProgresso.Properties.Max := FOperadores.Count;
    pgbProgresso.Position := 0;

    pCarregarTabelasPrincipais;

    For strOperador In FOperadores Do
    Begin
      pStepStatusGravacao(pgbProgresso,
        'Aguarde... Gravando configurações do Operador: ' + strOperador);

      If strOperador = qryCfgCon.FieldByName('CFG_CODOPE').AsString Then
        Continue;

      pCarregarTabelasAuxiliares;
      pReplicarTabelaConfiguracao;
      pReplicarTabelaEmpresas;
      pReplicarTabelaCampos;
    End;

  FinallY
    pDestruirComponentesQuery;
  End;
end;

function TConfiguraConsultaOperadores.fGrupoSelecionado: Boolean;
Var
  cdsTmp: TUniClientDataSet;
begin
  Result := False;

  Try
    cdsTmp := TUniClientDataSet.Create(Nil);
    cdsTmp.Data     := cdsCadGpo.Data;
    cdsTmp.Filter   := 'GPO_MARDES = ' + QuotedStr('S');
    cdsTmp.Filtered := True;
    cdsTmp.Open;
    Result := cdsTmp.RecordCount > 0;
  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TConfiguraConsultaOperadores.fGrupoSelecionado]');
  End;

  FreeAndNil(cdsTmp);
end;

function TConfiguraConsultaOperadores.fMarcaDesmarcaTotalGrupo(
  pgbProgresso: TcxProgressBar): Boolean;
Var
  intRecNo: Integer;
begin
  intRecNo := cdsCadGpo.RecNo;

  Try
    cdsCadGpo.DisableControls;
    pgbProgresso.Properties.Max := cdsCadGpo.RecordCount;

    With cdsCadGpo Do
    Begin
      First;

      While Not Eof Do
      Begin
        pStepStatusGravacao(pgbProgresso,
          'Aguarde...' + IfThen(Self.blnMarcar, 'Marcando', 'Desmarcando')+
            ' Grupos ' + IntToStr(RecNo) + ' de ' + IntToStr(RecordCount));

        Edit;
        FieldByName('GPO_MARDES').AsString := IfThen(Self.blnMarcar, 'S', 'N');
        Post;

        Next;
      End;

      Result := True;
    End;
  Finally
    cdsCadGpo.RecNo := intRecNo;
    cdsCadGpo.EnableControls;
  End;
end;

function TConfiguraConsultaOperadores.fMarcaDesmarcaTotalOperador(pgbProgresso: TcxProgressBar): Boolean;
Var
  intRecNo: Integer;
begin
  intRecNo := cdsCadOpe.RecNo;

  Try
    cdsCadOpe.DisableControls;
    pgbProgresso.Properties.Max := cdsCadOpe.RecordCount;

    With cdsCadOpe Do
    Begin
      First;

      While Not Eof Do
      Begin
        pStepStatusGravacao(pgbProgresso, 'Aguarde...' +
          IfThen(Self.blnMarcar, 'Marcando', 'Desmarcando')+
            ' Operadores ' + IntToStr(RecNo) + ' de ' + IntToStr(RecordCount));

        Edit;
        FieldByName('OPE_MARDES').AsString := IfThen(Self.blnMarcar, 'S', 'N');
        Post;

        Next;
      End;

      Result := True;
    End;
  Finally
    cdsCadOpe.RecNo := intRecNo;
    cdsCadOpe.EnableControls;
  End;
end;

function TConfiguraConsultaOperadores.fOperadorSelecionado: Boolean;
Var
  cdsTmp: TUniClientDataSet;
begin
  Result := False;

  Try
    cdsTmp := TUniClientDataSet.Create(Nil);
    cdsTmp.Data     := cdsCadOpe.Data;
    cdsTmp.Filter   := 'OPE_MARDES = ' + QuotedStr('S');
    cdsTmp.Filtered := True;
    cdsTmp.Open;
    Result := cdsTmp.RecordCount > 0;
  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TConfiguraConsultaOperadores.fOperadorSelecionado]');
  End;

  FreeAndNil(cdsTmp);
end;


function TConfiguraConsultaOperadores.fTemRegistroSelecionado: Boolean;
begin
  Result := fOperadorSelecionado;

  If (Not Result) Then
    Result := fGrupoSelecionado;
end;

function TConfiguraConsultaOperadores.getCdsGpo: TDataSet;
begin
  Result := cdsCadGpo;
end;

function TConfiguraConsultaOperadores.getCdsOpe: TDataSet;
begin
  Result := cdsCadOpe;
end;

function TConfiguraConsultaOperadores.getMarcarGpo: Boolean;
begin
  Result := True;

  If (cdsCadGpo.FieldByName('GPO_MARDES').AsString = 'S') Then
    Result := False;
end;

function TConfiguraConsultaOperadores.getMarcarOpe: Boolean;
begin
  Result := True;

  If (cdsCadOpe.FieldByName('OPE_MARDES').AsString = 'S') Then
    Result := False;
end;

procedure TConfiguraConsultaOperadores.pDestroiComponentes;
begin
  FreeAndNil(FOperadores);
  FreeAndNil(cdsCadOpe);
  FreeAndNil(cdsCadGpo);
  FreeAndNil(dspCadOpe);
  FreeAndNil(dspCadGpo);
  FreeAndNil(qryCadOpe);
  FreeAndNil(qryCadGpo);
  FreeAndNil(qryGeneri);
end;

procedure TConfiguraConsultaOperadores.pListarOperadoresNosGruposSelecionados;
Var
  qryOpeGpo: TUniQuery;
  intRecNo: Integer;
begin
  qryOpeGpo := fCriaQuery(nil);
  intRecNo := cdsCadGpo.RecNo;
  Try
    cdsCadGpo.DisableControls;

    With cdsCadGpo Do
    Begin
      Filter   := 'GPO_MARDES = ' + QuotedStr('S');
      Filtered := True;
      First;

      While Not Eof Do
      Begin
        qryOpeGpo.Close;
        qryOpeGpo.SQL.Text := 'SELECT * FROM OPEGPO WHERE GPO_CODGPO = :CODGPO';
        qryOpeGpo.ParamByName('CODGPO').AsString := FieldByName('GPO_CODGPO').AsString;
        qryOpeGpo.Open;

        While Not qryOpeGpo.Eof Do
        Begin
          If FOperadores.IndexOf(qryOpeGpo.FieldByName('OPE_CODOPE').AsString) = -1 Then
            FOperadores.Add(qryOpeGpo.FieldByName('OPE_CODOPE').AsString);
          qryOpeGpo.Next;
        End;

        Next;
      End;
    End;

  Finally
    FreeAndNil(qryOpeGpo);
    cdsCadGpo.Filter   := '';
    cdsCadGpo.Filtered := False;
    cdsCadGpo.RecNo    := intRecNo;
    cdsCadGpo.EnableControls;
  End;
end;

procedure TConfiguraConsultaOperadores.pListarOperadoresSelecionados;
Var
  intRecNo: Integer;
begin
  intRecNo := cdsCadOpe.RecNo;
  Try
    cdsCadOpe.DisableControls;
    With cdsCadOpe Do
    Begin
      Filter   := 'OPE_MARDES = ' + QuotedStr('S');
      Filtered := True;
      First;
      While Not Eof Do
      Begin
        If FOperadores.IndexOf(FieldByName('OPE_CODOPE').AsString) = -1 Then
          FOperadores.Add(FieldByName('OPE_CODOPE').AsString);
        Next;
      End;
    End;
  Finally
    cdsCadOpe.Filter   := '';
    cdsCadOpe.Filtered := False;
    cdsCadOpe.RecNo    := intRecNo;
    cdsCadOpe.EnableControls;
  End;
end;

procedure TConfiguraConsultaOperadores.pMarcaDesmarcaGrupo(blnMarcar: Boolean);
begin
  If (Not cdsCadGpo.IsEmpty) Then
  Begin
    cdsCadGpo.Edit;
    cdsCadGpo.FieldByName('GPO_MARDES').AsString := IfThen(blnMarcar, 'S', 'N');
    cdsCadGpo.Post;
  End;
end;

procedure TConfiguraConsultaOperadores.pMarcaDesmarcaOperador(blnMarcar: Boolean);
begin
  If (Not cdsCadOpe.IsEmpty) Then
  Begin
    cdsCadOpe.Edit;
    cdsCadOpe.FieldByName('OPE_MARDES').AsString := IfThen(blnMarcar, 'S', 'N');
    cdsCadOpe.Post;
  End;
end;

procedure TConfiguraConsultaOperadores.pMarcaDesmarcaTotalGrupo(blnMarcar: Boolean);
Var
  frmGravando: TfrmGravando;
begin

  Try

    Self.blnMarcar := blnMarcar;

    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.fExecutarAcao := fMarcaDesmarcaTotalGrupo;
    frmGravando.ShowModal;

  Except
    On E: Exception Do
      pMensagensErro(e.message, '[TConfiguraConsultaOperadores.pMarcaDesmarcaTotalGrupo]');
  End;

  pFreeAndNil(frmGravando);

end;

procedure TConfiguraConsultaOperadores.pMarcaDesmarcaTotalOperador(blnMarcar: Boolean);
Var
  frmGravando: TfrmGravando;
begin

  Try

    Self.blnMarcar := blnMarcar;

    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.fExecutarAcao := fMarcaDesmarcaTotalOperador;
    frmGravando.ShowModal;

  Except
    On E: Exception Do
      pMensagensErro(e.message, '[TConfiguraConsultaOperadores.pMarcaDesmarcaTotalOperador]');
  End;

  pFreeAndNil(frmGravando);

end;

procedure TConfiguraConsultaOperadores.pPreparaComponentes;
begin
  FOperadores := TStringList.Create;

  qryGeneri := fCriaQuery(Nil);
  qryCadOpe := fCriaQuery(Nil);
  qryCadGpo := fCriaQuery(Nil);

  cdsCadOpe := TUniClientDataSet.Create(Nil);
  cdsCadGpo := TUniClientDataSet.Create(Nil);

  dspCadOpe := TUniDataSetProvider.Create(Nil);
  dspCadGpo := TUniDataSetProvider.Create(Nil);

  dspCadOpe.DataSet := qryCadOpe;
  dspCadGpo.DataSet := qryCadGpo;

  cdsCadOpe.SetProvider(dspCadOpe);
  cdsCadGpo.SetProvider(dspCadGpo);
end;

procedure TConfiguraConsultaOperadores.pPreparaDados;
begin
  Try

    With qryCadOpe Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(fGetSQLOperador);
      Open;
      pSetaClient(qryCadOpe);
      cdsCadOpe.Open;
      pSetaClient(cdsCadOpe);
    End;

    With qryCadGpo Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(fGetSQLGrupo);
      Open;
      pSetaClient(qryCadGpo);
      cdsCadGpo.Open;
      pSetaClient(cdsCadGpo);
    End;

  Except
    On E: Exception DO
      pMensagensErro(e.Message, '[TConfiguraConsultaOperadores.pPreparaDados]');
  End;
end;

end.
