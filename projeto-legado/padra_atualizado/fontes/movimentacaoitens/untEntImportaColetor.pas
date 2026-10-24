unit untEntImportaColetor;

interface

Uses
  Classes, DBClient, DB, SysUtils, Forms, Windows, Controls,
  untFuncoesSimples, Uni, cxProgressBar, untZClient,
  Dialogs, EditFocus, StrUtils,
  untConstantes;

Type
  TfuncRegistraItem = Function: Boolean of Object;

  TEntImportaColetor = Class(TObject)
  Private

  Public

    Constructor Create; Overload;

    Destructor Destroy; Override;

    Class Function fImportaColetor(cdsConsulta: TDataSet; edtCodIte, edtQtdIte: TEditFocus;
                             fRegistraItem: TfuncRegistraItem): Boolean;
  End;

implementation

Constructor TEntImportaColetor.Create;
Begin
  inherited Create;

End;

Destructor TEntImportaColetor.Destroy;
Begin

  inherited;
End;

Class Function TEntImportaColetor.fImportaColetor(cdsConsulta: TDataSet; edtCodIte, edtQtdIte: TEditFocus;
                                           fRegistraItem: TfuncRegistraItem): Boolean;
  Var
    stlArqCol: TStringList;
    intContador, intModCol, intposVir: Integer;
    strLinha: String;
    opdArqCol: TOpenDialog;

{
ope nota  fornece Item          qtdite
1234123456123456781234567890123412345,123
12345678901234567890123456789012345678901
         1         2         3         4
}
    Procedure pModelo1;
    Begin
      strLinha       := Trim(stlArqCol[intContador]);
      edtCodIte.Text := Trim(Copy(strLinha, 1, 13));
      Try
        edtQtdIte.Text := FormatFloat('##0.00', fstrToFloat(Copy(AnsiReplaceStr(strLinha, '.', ','), 14, 5)));
      Except
        edtQtdIte.Text := '0,00';
      End;

    End;

    Procedure pModelo2;
    Begin
      strLinha       := Trim(stlArqCol[intContador]);
      edtCodIte.Text := Copy(strLinha, 1, fTamCodite);
      Try
        edtQtdIte.Text := FormatFloat('##0.00', fStrToFloat(Copy(AnsiReplaceStr(strLinha, '.', ','), 6, (Length(strLinha) - 5) ) ) );
      Except
        edtQtdIte.Text := '0,00';
      End;

    End;

    Procedure pModelo3;
    Begin
      strLinha       := Trim(stlArqCol[intContador]);
      edtCodIte.Text := Trim(Copy(strLinha, 1, 13));
      Try
        edtQtdIte.Text := FormatFloat('##0.00', fstrToFloat(Copy(AnsiReplaceStr(strLinha, '.', ','), 15, 5)));
      Except
        edtQtdIte.Text := '0,00';
      End;

    End;

    Procedure pModelo4;
    Begin
      strLinha       := stlArqCol[intContador];
      edtCodIte.Text := Copy(strLinha, 2, fTamCodIte);
      Try
        edtQtdIte.Text := FormatFloat('##0.00', fstrToFloat(Copy(AnsiReplaceStr(strLinha, '.', ','), 7, 6)));
      Except
        edtQtdIte.Text := '0,00';
      End;
    End;

    Procedure pModelo5;
    Begin
      strLinha       := TrimRight(stlArqCol[intContador]);
      edtCodIte.Text := Trim(Copy(strLinha, 11, 13));
      Try
        edtQtdIte.Text := FormatFloat('##0.00', fstrToFloat(Copy(AnsiReplaceStr(strLinha, '.', ','), 44, 5)));
      Except
        edtQtdIte.Text := '0,00';
      End;
    End;

    Procedure pModelo6;
    Begin
      strLinha  := Trim(stlArqCol[intContador]);
      If (Length(strLinha) < 13) Then
        Exit;
      edtCodIte.Text := Trim(Copy(strLinha, 01, 13));
      Try
        edtQtdIte.Text := FormatFloat('##0.00', fstrToFloat(Copy(AnsiReplaceStr(strLinha, '.', ','), 17, 6)));
      Except
        edtQtdIte.Text := '0,00';
      End;
    End;

    Procedure pModelo7;
    Begin
      strLinha  := Trim(stlArqCol[intContador]);
      intposVir := Pos(',', strLinha);
      If intposVir = 0 Then
      Begin
         edtCodIte.Text := strLinha;
         edtQtdIte.Text := '0,00';
      End Else
      Begin
        edtCodIte.Text := Copy(strLinha, 01, Pred(intposVir));
        delete(strLinha, 1, intposVir);

        Try
          edtQtdIte.Text := FormatFloat('##0.00', fstrToFloat(AnsiReplaceStr(strLinha, '.', ',')));
        Except
          edtQtdIte.Text := '0,00';
        End;

      End;
    End;

    Procedure pModelo8;
    Begin
      strLinha       := Trim(stlArqCol[intContador]);
      edtCodIte.Text := Trim(Copy(strLinha, 1, 13));
      Try
        edtQtdIte.Text := FormatFloat('##0.00', fstrToFloat(Copy(AnsiReplaceStr(strLinha, '.', ','), 15, 6)));
      Except
        edtQtdIte.Text := '0,00';
      End;

    End;

    Procedure pModelo9;
    Begin
      strLinha       := TrimRight(stlArqCol[intContador]);
      edtCodIte.Text := Copy(strLinha, 92, fTamCodIte);
      Try
        edtQtdIte.Text := FormatFloat('##0.00', fstrToFloat(Copy(AnsiReplaceStr(strLinha, '.', ','), 15, 5)));
      Except
        edtQtdIte.Text := '0,00';
      End;
    End;

    Procedure pModelo10;
    Begin
      strLinha       := TrimRight(stlArqCol[intContador]);
      edtCodIte.Text := Trim(Copy(strLinha, 19, 14));
      Try
        edtQtdIte.Text := FormatFloat('##0.00', fstrToFloat(Copy(AnsiReplaceStr(strLinha, '.', ','), 33, 09)));
      Except
        edtQtdIte.Text := '0,00';
      End;
    End;

    Procedure pModelo11;
    Begin
      strLinha  := Trim(stlArqCol[intContador]);
      edtCodIte.Text := Trim(Copy(strLinha, 01, 15));
      Try
        edtQtdIte.Text := FormatFloat('##0.00', fstrToFloat(Copy(AnsiReplaceStr(strLinha, '.', ','), 16, 11)));
      Except
        edtQtdIte.Text := '0,00';
      End;
    End;

    procedure pModelo13;
    Begin
      strLinha  := Trim(stlArqCol[intContador]);
      edtCodIte.Text := Copy(strLinha, 19, fTamCodIte);
      Try
        edtQtdIte.Text := FormatFloat('##0.00', fValNumForm(Copy(strLinha, 85, 09), 09, 03));
      Except
        edtQtdIte.Text := '0,00';
      End;
    End;

    Procedure pModelo14;
    Begin
      strLinha  := Trim(stlArqCol[intContador]);
      edtCodIte.Text := Trim(Copy(strLinha, 21, 14));
      Try
        edtQtdIte.Text := FormatFloat('##0.00', fstrToFloat(Copy(AnsiReplaceStr(strLinha, '.', ','), 35, 8)));
      Except
        edtQtdIte.Text := '0,00';
      End;
    End;

begin
  Result := False;

  If Not cdsConsulta.Active Then
    Exit;

  intModCol := fCfgSis('MODCOL', varInteger);

  If intModCol = 0 Then
  Begin
    pMensagemOk('Configure o Modelo de coletor para utilização (IMPORTAÇÃO) (CFG_MODCOL) na aba "COLETOR DE DADOS" em Configurações do Sistema!');
    Exit;
  End;

  opdArqCol := TOpenDialog.Create(Nil);
  opdArqCol.InitialDir := fCfgSis('PATCOL');

  If (opdArqCol.Execute) Then
  Begin

    cdsConsulta.DisableControls;
    stlArqCol := TStringList.Create;

    Try
      stlArqCol.LoadFromFile(opdArqCol.FileName);
      For intContador := 0 To stlArqCol.Count-1 Do
      Begin
        Case intModCol Of
          1:  pModelo1;
          2:  pModelo2;
          3:  pModelo3;
          4:  pModelo4;
          5:  pModelo5;
          6:  pModelo6;
          7:  pModelo7;
          8:  pModelo8;
          9:  pModelo9;
          10: pModelo10;
          11: pModelo11;
          12: ;//
          13: pModelo13;
          14: pModelo14;
        End;
        Result := fRegistraItem;
      End;
    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[Importação de dados do coletor]');
      End;
    End;

    FreeAndNil(stlArqCol);
    cdsConsulta.EnableControls;

  End;

  FreeAndNil(opdArqCol);
end;

end.
