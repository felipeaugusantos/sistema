unit untLocFisAdicionais;

interface

Uses
  Classes, SysUtils, Controls, DB,
  untFuncoesSimples, untZClient, Graphics;

Type
  TLocFisAdicionais = Class(TZClient)
    Private
      blnCadLoc: Boolean;
      FIteAtu: String;
      FLocPri: String;

      Function fSQLCadLoc: String;

      Procedure pAbreGrid(pnlGrid: TWincontrol);

    Public

      constructor Create(Owner: TComponent; pnlGrid: TWincontrol  = Nil); Reintroduce; Overload;
      Destructor Destroy; override;

      Function fCarregaLocalizacoes(strCodIte, strLocPri: String): Boolean;
      Function fIncluiLocalizacao(strLocFis: String): Boolean;
      Function fExcluiLocalizacao: Boolean;
      Function fSalvaLocalizacoes(strCodite: String): Boolean;
      Function fTemLocalizacaoAdicional(strLocFis: String): Boolean;

      Procedure pSetaLocalizacaoPrincipal(strLocFis: String);

      Procedure pHabilitaEdicao(blnHabil: Boolean);
      Procedure pCancela(blnUpdates: Boolean = True); override;

      procedure pVerdeVermelho(blnLiberado: Boolean);

      Property strIteAtu: String Read FIteAtu Write FIteAtu;
  End;

implementation

Uses
  untCadLocAdicionais;

constructor TLocFisAdicionais.Create(Owner: TComponent; pnlGrid: TWincontrol = Nil);
Begin
  FLocPri := '';
  blnCadLoc := fCfgSis('CADLOC', varBoolean);

  Inherited Create(Owner, fSQLCadLoc);
  pAbreGrid(pnlGrid);
End;

Procedure TLocFisAdicionais.pSetaLocalizacaoPrincipal(strLocFis: String);
Begin
  FLocPri := strLocFis;
End;

procedure TLocFisAdicionais.pVerdeVermelho(blnLiberado: Boolean);
begin
  If Assigned(frmCadLocAdicionais) Then
  Begin
    frmCadLocAdicionais.edtLocFis.ReadOnly   := Not blnLiberado;
    frmCadLocAdicionais.btnExcluir.Enabled   := blnLiberado;
    frmCadLocAdicionais.shpLocFisAdi.Visible := True;
    frmCadLocAdicionais.shpLocFisAdi.Brush.Color := IIF(blnLiberado, clGreen, clRed);
  End;
end;

Procedure TLocFisAdicionais.pAbreGrid(pnlGrid: TWincontrol);
Begin
  If Not Assigned(pnlGrid) then
    Exit;

  pCriarFormularios(TfrmCadLocAdicionais, frmCadLocAdicionais);
  frmCadLocAdicionais.objLocFis   := self;
  frmCadLocAdicionais.Dock(pnlGrid, pnlGrid.BoundsRect);
  frmCadLocAdicionais.pnlStatus.Visible := False;
  frmCadLocAdicionais.Show;
  frmCadLocAdicionais.Enabled           := False;
End;

Procedure TLocFisAdicionais.pHabilitaEdicao(blnHabil: Boolean);
Begin
  If Assigned(frmCadLocAdicionais) Then
    frmCadLocAdicionais.Enabled := blnHabil;
End;

Function TLocFisAdicionais.fSQLCadLoc: String;
Begin
  Result := '';
  Result := Result + ' SELECT ';
  Result := Result + '   L.* ';

  If blnCadLoc Then
    Result := Result + '  , (SELECT C.LOC_DESCRI FROM CADLOC C WHERE C.LOC_CODLOC = L.LOC_LOCFIS AND C.LOC_CODEMP = L.LOC_CODEMP) AS LOC_DESCRI ';

  Result := Result + ' FROM LOCFIS L          ';
  Result := Result + ' WHERE ';
  Result := Result + '   LOC_CODEMP = :CODEMP AND ';
  Result := Result + '   LOC_CODITE = :CODITE     ';
End;

Function TLocFisAdicionais.fCarregaLocalizacoes(strCodIte, strLocPri: String): Boolean;
Begin
  Try
    pSetaLocalizacaoPrincipal(strLocPri);
    FIteAtu := strCodIte;
    With qryQuery Do
    Begin
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      ParamByName('CODITE').AsString := strCodIte;

      Result := fAbreClient(True, 'TLocFisAdicionais.fCarregaLocalizacoes');

      If Result And blnCadLoc Then
        FieldByName('LOC_DESCRI').ProviderFlags := [];

    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TLocFisAdicionais.fCarregaLocalizacoes]');
    End;
  End;
End;

Function TLocFisAdicionais.fIncluiLocalizacao(strLocFis: String): Boolean;
Begin
  Try
    If fEmptyStr(strLocFis) Then
    Begin
      Result := False;
      pMensagemOk('Localização Física em branco!');
    End

    Else If fTemLocalizacaoAdicional(strLocFis) Then
    Begin
      Result := False;
      pMensagemOk('A Localização Física ' + strLocFis + ' já existe!');
    End

    Else If (Not fEmptyStr(FLocPri)) And SameText(FLocPri, strLocFis) Then
    Begin
      Result := False;
      pMensagemOk('A Localização Física ' + strLocFis + ' já está cadastrada como principal!');
    End Else

    Begin
      Append;
      FieldByName('LOC_CODEMP').AsString := VS_strCodEmp;
      FieldByName('LOC_LOCFIS').AsString := strLocFis;

      If blnCadLoc Then
        FieldByName('LOC_DESCRI').AsString := fRetNomLocFisica(strLocFis);

      Post;

      Result := True;
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TLocFisAdicionais.fIncluiLocalizacao]');
    End;
  End;
End;

Function TLocFisAdicionais.fExcluiLocalizacao: Boolean;
Begin
  Try

    If Not IsEmpty then
     Delete;

    Result := True;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TLocFisAdicionais.fExcluiLocalizacao]');
    End;
  End;
End;

Function TLocFisAdicionais.fSalvaLocalizacoes(strCodite: String): Boolean;
Begin
  Try
    FIteAtu := strCodIte;

    DisableControls;
    First;

    While Not Eof Do
    Begin
      Edit;
      FieldByName('LOC_CODITE').AsString := strCodIte;
      Post;

      Next;
    End;

    Result := fSalva;

  Except
    On E : Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TLocFisAdicionais.fSalvaLocalizacoes]');
    End;
  End;

  EnableControls;
End;

Procedure TLocFisAdicionais.pCancela(blnUpdates: Boolean = True);
Begin
  Inherited pCancela(blnUpdates);
  pHabilitaEdicao(False);
End;

Destructor TLocFisAdicionais.Destroy;
Begin
  If Assigned(frmCadLocAdicionais) Then
    pFreeAndNil(frmCadLocAdicionais);

  Inherited;
End;

Function TLocFisAdicionais.fTemLocalizacaoAdicional(strLocFis: String): Boolean;
Begin
  Result := Locate('LOC_LOCFIS', strLocFis, []);
End;

end.
