unit untSalvaDadosCfgGiro;

interface

uses
  Classes, SysUtils, Controls, ComCtrls, DB, UniClientDataSet, Forms, untZClient,
  StrUtils, Math, untFuncoesSimples, ExtCtrls, StdCtrls, EditFocus, MaskEditFocus,
  CheckLst, Uni, untSalvaDadosInterface, untTEditFocusWithTConsultasArray;

Type
  TSalvaDadosCfgGiro = Class(TSalvaInterface)

  Private
     FFormDados: TForm;

  Public
    blnEncontrouGiro: Boolean;

    blnExibiItens: Boolean;

    constructor Create(Owner: TComponent);

    Function fCarregaDados(strValKey: String; strNomFrm: String = ''; strCodOpe: String = '';
                           blnRecuperandoPedido: Boolean = False; blnCarregaTela: Boolean = True): Boolean; Reintroduce;

    Function fAtualizaDados: Boolean; Override;
  End;

implementation

Uses
  untConfiguraDadosGiro;

constructor TSalvaDadosCfgGiro.Create(Owner: TComponent);
Begin
  Inherited;

  FFormDados := TForm(Owner);

  blnExibiItens := True;
  blnDeleteNaoEncontrados := False;
End;

Function TSalvaDadosCfgGiro.fAtualizaDados: Boolean;
  Var
    stlLista: TStringList;
    cdsDados: TDataSet;
    frmConfiguraDadosGiro: TfrmConfiguraDadosGiro;

    Procedure pTrataMeses;
    Begin
      With frmConfiguraDadosGiro, fraCalcGirFrame, fraCalcGirMesesFrame Do
      Begin
        stlLista.Clear;
        pLocalizaRegistro(lblSelMes.Name);

        If chkInfMes.Checked Then
        Begin
          FieldByName('INT_VALCOM').AsString := strMeses;

          Post;
        End Else
        Begin

          If State = dsInsert Then
          Begin
            Cancel;
          End Else
          Begin
            Cancel;
            Delete;
          End;

        End;
      End;
    End;

    Procedure pTrataNiveis;
    Begin
      With frmConfiguraDadosGiro, fraCalcGirFrame, fraCalcGirMesesFrame Do
      Begin
        stlLista.Clear;

        pLocalizaRegistro(cxgNivel.Name);

        cdsDados := cxvNivel.DataController.DataSource.DataSet;

        cdsDados.First;
        While Not cdsDados.Eof Do
        Begin
          stlLista.Add(cdsDados.FieldByName('NIVGIR').AsString + ';' +
                       cdsDados.FieldByName('USANIV').AsString + ';' +
                       cdsDados.FieldByName('QTDDIA').AsString + '/' +
                       cdsDados.FieldByName('PERCON').AsString);

          cdsDados.Next;
        End;

        FieldByName('INT_VALCOM').AsString := stlLista.Text;

        Post;
      End;
    End;

Begin
  Try
    frmConfiguraDadosGiro := TfrmConfiguraDadosGiro(FFormDados);

    Result := inherited;

    If Result Then
    Begin

      If Assigned(frmConfiguraDadosGiro) Then
      With frmConfiguraDadosGiro Do
      Begin
        stlLista := TStringList.Create;

        pTrataMeses;
        pTrataNiveis;

        FreeAndNil(stlLista);
      End;

    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, 'TSalvaDadosCfgGiro.fAtualizaDadosGiro');
    End;
  End;
End;

Function TSalvaDadosCfgGiro.fCarregaDados(strValKey: String; strNomFrm: String = ''; strCodOpe: String = ''; blnRecuperandoPedido: Boolean = False; blnCarregaTela: Boolean = True): Boolean;
  Var
    stlLista: TStringList;
    cdsDados: TUniClientDataSet;
    frmConfiguraDadosGiro: TfrmConfiguraDadosGiro;

    Procedure pTrataMeses;
      Var
        intContador: Integer;
        strListaMeses: String;
    Begin
      With frmConfiguraDadosGiro, fraCalcGirFrame, fraCalcGirMesesFrame Do
      Begin
        If chkInfMes.Checked And Locate('INT_NOMCOM', lblSelMes.Name, []) And
          Assigned(cdsMeses) And cdsMeses.Active Then
        Begin
          cdsMeses.blnTestaLimite := False;

          strListaMeses := Trim(FieldByName('INT_VALCOM').AsString);
          stlLista.Text := AnsiReplaceStr(strListaMeses, ' ', #13#10);

          cdsMeses.IndexFieldNames := 'ANOMES';

          For intContador := 0 To stlLista.Count - 1 Do
          If cdsMeses.Locate('ANOMES', stlLista[intContador], []) Then
          Begin
            cdsMeses.Edit;
            cdsMeses.FieldByName('SELECI').AsString := 'S';
            cdsMeses.Post;
          End;

          strMeses := cdsMeses.fRetMeses;

          cdsMeses.blnTestaLimite := True;
        End;

      End;
    End;

    Procedure pTrataNiveis;
      Var
        strNivel,
        strMarca,
        strQtdDia,
        strPerCon: String;
        intPos,
        intContador: Integer;
    Begin
      With frmConfiguraDadosGiro, fraCalcGirFrame, fraCalcGirMesesFrame Do
      Begin
        cmbTipNivChange(Nil);

        cdsDados := TUniClientDataSet(cxvNivel.DataController.DataSource.DataSet);
        objNiveis.pTiraBeforePost;

        If Locate('INT_NOMCOM', cxgNivel.Name, []) Then
        Begin
          stlLista.Text := Trim(FieldByName('INT_VALCOM').AsString);

          For intContador := 0 To stlLista.Count - 1 Do
          Begin
            strPerCon := '';

            intPos   := Pos(';', stlLista[intContador]);

            strNivel := LeftStr(stlLista[intContador], Pred(intPos));

            If cdsDados.Locate('NIVGIR', strNivel, []) Then
            Begin
              strMarca := stlLista[intContador];
              System.Delete(strMarca, 1, intPos);
              intPos := Pos(';', strMarca);

              If Pos('/', strMarca) > 0 Then
              Begin
                strPerCon := RightStr(strMarca, Length(strMarca) - Pos('/', strMarca));
                System.Delete(strMarca, Pos('/', strMarca), Length(strMarca) - Pos('/', strMarca) + 1);
              End;

              strQtdDia := RightStr(strMarca, Length(strMarca) - intPos);
              strMarca  := LeftStr(strMarca, Pred(intPos));

              cdsDados.Edit;
              cdsDados.FieldByName('USANIV').AsString  := strMarca;
              cdsDados.FieldByName('QTDDIA').AsInteger := StrToIntDef(strQtdDia, 0);
              cdsDados.FieldByName('PERCON').AsFloat   := fStrToFloat(strPerCon);

              cdsDados.Post;
            End;

          End;

        End Else If Locate('INT_NOMCOM', 'chkUsaNivGir', []) And
                    (Trim(FieldByName('INT_VALCOM').AsString) = '1') Then // Compatibilidade com componentes excluidos
        Begin
          cmbTipNiv.ItemIndex := 1;
          cmbTipNivChange(Nil);

          If Locate('INT_NOMCOM', 'chkCalNivA', []) And
            (Trim(FieldByName('INT_VALCOM').AsString) = '1') And
            cdsDados.Locate('NIVGIR', 'A', []) Then
          begin
            cdsDados.Edit;
            cdsDados.FieldByName('USANIV').AsString  := 'S';

            If Locate('INT_NOMCOM', 'edtDiaComNivA', []) Then
              cdsDados.FieldByName('QTDDIA').AsInteger := StrToIntDef(Trim(FieldByName('INT_VALCOM').AsString), 0);

            cdsDados.Post;
           End;

          If Locate('INT_NOMCOM', 'chkCalNivB', []) And
            (Trim(FieldByName('INT_VALCOM').AsString) = '1') And
            cdsDados.Locate('NIVGIR', 'B', []) Then
          begin
            cdsDados.Edit;
            cdsDados.FieldByName('USANIV').AsString  := 'S';

            If Locate('INT_NOMCOM', 'edtDiaComNivB', []) Then
              cdsDados.FieldByName('QTDDIA').AsInteger := StrToIntDef(Trim(FieldByName('INT_VALCOM').AsString), 0);

            cdsDados.Post;
           End;

          If Locate('INT_NOMCOM', 'chkCalNivC', []) And
            (Trim(FieldByName('INT_VALCOM').AsString) = '1') And
            cdsDados.Locate('NIVGIR', 'C', []) Then
          begin
            cdsDados.Edit;
            cdsDados.FieldByName('USANIV').AsString  := 'S';

            If Locate('INT_NOMCOM', 'edtDiaComNivC', []) Then
              cdsDados.FieldByName('QTDDIA').AsInteger := StrToIntDef(Trim(FieldByName('INT_VALCOM').AsString), 0);

            cdsDados.Post;
           End;

        End;

        objNiveis.pPoeBeforePost;
      End;
    End;


Begin

  Try
    frmConfiguraDadosGiro := TfrmConfiguraDadosGiro(FFormDados);

    If Not fEmptyStr(strCodOpe) Then
      strNomFrm := 'frmConfiguraDadosGiro';

    pSetFrame(frmConfiguraDadosGiro.fraCalcGirFrame);
    pSetFrame(frmConfiguraDadosGiro.fraCalcGirMesesFrame);

    Result := inherited fCarregaDados(strValKey, FFormDados, strNomFrm, strCodOpe, blnCarregaTela);

    blnEncontrouGiro := Not Self.IsEmpty;

    If Result And blnCarregaTela And Assigned(frmConfiguraDadosGiro) Then
    With frmConfiguraDadosGiro, fraCalcGirFrame, fraCalcGirMesesFrame Do
    Begin
      stlLista := TStringList.Create;
      stlLista.Sorted := True;

      // PARA NÃO EXLCLUIR DO GIRO ITENS QUE ESTÃO NO PEDIDO
      If blnExibiItens And (Not blnRecuperandoPedido) Then
        chkExibItens.Checked := True;

      pTrataMeses;
      pTrataNiveis;

      FreeAndNil(stlLista);
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, 'TSalvaDadosCfgGiro.fCarregaDados');
    End;
  End;

End;

end.
