unit untPendenciaFiscal;

interface

Uses
  Classes,
  untZClient,
  CxProgressBar;

Type
  TPendenciaFiscal = Class(TZClient)
  Private
    FAutXMLVAL: String;

    Function fSQLPencencias(blnSoConsulta: Boolean): String;

    Function fGravaPendenciasNotaPrg(cxpProgresso: TCxProgressBar): Boolean;

  Public

    constructor Create(Owner: TComponent); Reintroduce; Overload;

    Destructor Destroy; override;

    Function fCarregaPendenciasNota(strAutXMLVAL: String; blnSoConsulta: Boolean): Boolean;

    Function fGravaPendenciasNota(strAutXMLVAL: String): Boolean;

  End;

implementation

Uses
  SysUtils,
  untGravando,
  untFuncoesSimples;

constructor TPendenciaFiscal.Create(Owner: TComponent);
Begin
  Inherited Create(Owner, '');

End;

Destructor TPendenciaFiscal.Destroy;
Begin

  Inherited;
End;

Function TPendenciaFiscal.fSQLPencencias(blnSoConsulta: Boolean): String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT             ';
  strSQL := strSQL + '   P.*,             ';

  strSQL := strSQL + '   IF(V.VAL_CODPEN IS NULL, "N", "S") AS MARCADO ';

   strSQL := strSQL + ' FROM               ';
  strSQL := strSQL + '    CADPEN P         ';

  If blnSoConsulta Then
    strSQL := strSQL + ' INNER  '
  Else
    strSQL := strSQL + ' LEFT  ';

   strSQL := strSQL + ' JOIN VALPEN V ON V.VAL_CODPEN = P.PEN_CODPEN AND V.VAL_AUTXML = :AUTXML ';

  strSQL := strSQL + ' WHERE              ';
  strSQL := strSQL + '   PEN_ATIVO_ = "S" ';

  Result := strSQL;
End;

Function TPendenciaFiscal.fCarregaPendenciasNota(strAutXMLVAL: String; blnSoConsulta: Boolean): Boolean;
Begin
  qryQuery.SQL.Text := fSQLPencencias(blnSoConsulta);
  qryQuery.ParamByName('AUTXML').AsString := strAutXMLVAL;
  Result := fLeDados('TPendenciaFiscal.fCarregaPendenciasNota', True, 'Carregando pendências...');
End;

Function TPendenciaFiscal.fGravaPendenciasNota(strAutXMLVAL: String): Boolean;
  Var
    frmGravando: TfrmGravando;
Begin
  FAutXMLVAL := strAutXMLVAL;
  Result := TfrmGravando.fExecuta(fGravaPendenciasNotaPrg, frmGravando, 'Gravando pendências...');
End;

Function TPendenciaFiscal.fGravaPendenciasNotaPrg(cxpProgresso: TCxProgressBar): Boolean;
  Var
    cdsValPen: TZClient;
Begin
  Self.DisableControls;
  Self.Filter   := 'MARCADO = ' + QuotedStr('S');
  Self.Filtered := True;

  Try
    cdsValPen := TZClient.Create(Self, 'SELECT * FROM VALPEN WHERE VAL_AUTXML = ' + QuotedStr(FAutXMLVAL));

    Result := cdsValPen.fLeDados('TPendenciaFiscal.fIncluiPendencias');

    If Not Result Then
      Exit;

    While Not cdsValPen.IsEmpty Do
      cdsValPen.Delete;

    Self.First;
    While Not Self.Eof Do
    Begin
      cdsValPen.Append;
      cdsValPen.FieldByName('VAL_CODPEN').AsString := Self.FieldByName('PEN_CODPEN').AsString;
      cdsValPen.FieldByName('VAL_AUTXML').AsString := FAutXMLVAL;
      cdsValPen.Post;

      Self.Next;
    End;

    Result := cdsValPen.fSalva;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, 'TPendenciaFiscal.fIncluiPendencias');
    End;
  End;

  Self.Filtered := False;
  Self.EnableControls;
End;

end.
