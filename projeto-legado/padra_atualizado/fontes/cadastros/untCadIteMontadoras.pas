unit untCadIteMontadoras;

interface

Uses
  Uni, Controls, Classes, frxClass, frxDBset, untZClient, System.SysUtils;

Type
  TCadIteMontadoras = Class(TZClient)
    Private
      Function fSqlIteMon: String;

      Procedure pAbreCadMontadoras(wncLocCad: TWincontrol);
    Public
      strCodIte: String;

      constructor Create(Owner: TComponent; wncLocCad: TWincontrol); Reintroduce;

      Destructor Destroy; override;

      Function  fSalvaDados(strCodigoItem: String): Boolean;

      Procedure pCancela(blnUpdates: Boolean = True); override;
      Procedure pHabilitaEdicao(blnHabil: Boolean);
      Procedure pExcluiRegistro;
      Procedure pIncluiMontadora(strCodMon: String);
      Procedure pHerdaItem(strCodIteOrigem: String);
      Procedure pCarregaDados(strCodIteP: String);
      procedure pFormKeyDown(Sender: TObject; var Key: Word;
                  Shift: TShiftState);

  End;

implementation

Uses
  DB, UniClientDataSet, untfuncoesSimples, untCadIteMon;

Function TCadIteMontadoras.fSqlIteMon: String;
Begin
  Result := '';
  Result := Result + ' SELECT         ';
  Result := Result + '   ITEMON.*,    ';
  Result := Result + '   (SELECT MON_DESCRI FROM CADMON WHERE MON_CODMON = ITM_CODMON) AS ITM_DESMON ';
  Result := Result + ' FROM ITEMON                ';
  Result := Result + ' WHERE ITM_CODITE = :CODITE ';
  Result := Result + ' ORDER BY ITM_CODMON        ';
End;

constructor TCadIteMontadoras.Create(Owner: TComponent; wncLocCad: TWincontrol);
Begin
  Inherited Create(Owner, fSqlIteMon);

  pAbreCadMontadoras(wncLocCad);
End;

Destructor TCadIteMontadoras.Destroy;
Begin
  Inherited;

End;

Procedure TCadIteMontadoras.pAbreCadMontadoras(wncLocCad: TWincontrol);
Begin
  pCriarFormularios(TfrmCadIteMon, frmCadIteMon);
  frmCadIteMon.objIteMon         := self;
  frmCadIteMon.Dock(wncLocCad, wncLocCad.BoundsRect);
  frmCadIteMon.pnlStatus.Visible := False;
  frmCadIteMon.Show;
  frmCadIteMon.Enabled           := False;
End;

Procedure TCadIteMontadoras.pCarregaDados(strCodIteP: String);
Begin
  strCodIte := strCodIteP;

  With qryQuery Do
  Begin
    ParamByName('CODITE').AsString := strCodIte;
  End;

  If fAbreClient(True, 'TCadIteMontadoras.pCarregaDados') Then
    FieldByName('ITM_DESMON').ProviderFlags := [];
End;

Function TCadIteMontadoras.fSalvaDados(strCodigoItem: String): Boolean;
Begin
  If not Active Then
  Begin
    Result := True;
    Exit;
  End;

  DisableControls;
  First;
  While Not Eof Do
  Begin

    If fEmptyStr(FieldByName('AUTOINCREM').AsString) Then
    Begin
      Edit;
      FieldByName('ITM_CODITE').AsString := strCodigoItem;
      FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('ITEMON', VS_strCodEmp);
      Post;
    End;

    Next;
  End;

  Result := fSalva;

  EnableControls;
End;

Procedure TCadIteMontadoras.pExcluiRegistro;
Begin
  If IsEmpty Then
    Exit;

  Delete;
End;

Procedure TCadIteMontadoras.pIncluiMontadora(strCodMon: String);
Begin
  If (Not fEmptyStr(strCodMon)) And (Not Locate('ITM_CODMON', strCodMon, [])) Then
  Begin
    Insert;
    FieldByName('ITM_CODMON').AsString := strCodMon;
    FieldByName('ITM_DESMON').AsString := fRetNomMontadora(strCodMon);
    Post;
  End;
  frmCadIteMon.pLimpaTela;
End;

Procedure TCadIteMontadoras.pHabilitaEdicao(blnHabil: Boolean);
Begin
  frmCadIteMon.Enabled := blnHabil;
End;

procedure TCadIteMontadoras.pHerdaItem(strCodIteOrigem: String);
  Var
    qryGen : TUniQuery;
begin

  qryGen := fCriaQuery;
  Try
    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(fSqlIteMon);
      ParamByName('CODITE').AsString := strCodIteOrigem;
      Open;

      Self.EmptyDataSet;
      If (Not IsEmpty) Then
      Begin
        First;
        While Not Eof Do
        Begin
          pIncluiMontadora(FieldByName('ITM_CODMON').Value);

          Next;
        End;
      End;
      Close;

    End;
  Finally
    FreeAndNil(qryGen);
  End;

end;

Procedure TCadIteMontadoras.pCancela(blnUpdates: Boolean = True);
Begin
  Inherited pCancela(blnUpdates);

  frmCadIteMon.pLimpaTela;
  pHabilitaEdicao(False);
End;

procedure TCadIteMontadoras.pFormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  frmCadIteMon.FormKeyDown(Sender, Key, Shift);
end;


end.
