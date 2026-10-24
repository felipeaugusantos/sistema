unit untPrazoEntregaFornecedor;

interface

Uses
  Classes, SysUtils, Controls, DB,
  untFuncoesSimples, untZClient, Uni,
  untTypesSistema, untConstantes, untMensagemExplicativa;

Type
  TPrazoEntregaFornecedor = Class(TZClient)
    Private

      Function fSQLEmpresas: String;

    private
    Public

      constructor Create(Owner: TComponent); Reintroduce; Overload;
      Destructor Destroy; override;

      Function fCarregaDados(strCodFor: String): Boolean;
      Function fSalvaDados(strCodFor: String): Boolean;
      procedure pValidacaoDias(DiaCompra: Integer; PrazoEntrega: Integer);

  End;

implementation

procedure TPrazoEntregaFornecedor.pValidacaoDias(DiaCompra: Integer; PrazoEntrega: Integer);
begin
  If PrazoEntrega <= 0 Then
    Exit;

  If PrazoEntrega > IIf(DiaCompra > 0, DiaCompra, Self.FieldByName('PAR_DIAMAG').AsInteger) Then
  Begin
    pCriarFormularios(TfrmMensagemExplicativa , frmMensagemExplicativa);
    Try
      frmMensagemExplicativa.Caption := 'Atenção.';
      frmMensagemExplicativa.mmoInstru.Lines.Add('Atenção: O Prazo de Entrega do fornecedor é maior do que a quantidade prevista para o ciclo de compras, sendo assim, o estoque de segurança será');
      frmMensagemExplicativa.mmoInstru.Lines.Add('comprometido e poderá ocorrer ruptura desse produto. Favor analisar o parâmetro de "Dias para Compra" do cadastro de fornecedores e também dos parâmetros');
      frmMensagemExplicativa.mmoInstru.Lines.Add('da Pasta de Compras", aumentando a quantidade de "Dias para Compra" desse fornecedor. ');
      frmMensagemExplicativa.mmoInstru.Lines.Add('O ciclo de compras só será sustentável se a quantidade de Dias para Compra for maior do que o prazo de entrega do Fornecedor.');
      frmMensagemExplicativa.ShowModal;
    Finally
       FreeAndNil(frmMensagemExplicativa);
    End;
  End;
end;


constructor TPrazoEntregaFornecedor.Create(Owner: TComponent);
Begin
  Inherited Create(Owner, fSQLEmpresas);

End;

Destructor TPrazoEntregaFornecedor.Destroy;
Begin
  Inherited;

End;

Function TPrazoEntregaFornecedor.fSQLEmpresas: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + 'SELECT P.*, ';
  strSQL := strSQL + '       EMPPAR.PAR_DIAMAG, ';
  strSQL := strSQL + '       (SELECT EMP_NOMEMP FROM CADEMP WHERE EMP_CODEMP = PRA_CODEMP) AS PRA_NOMEMP  ';
  strSQL := strSQL + ' FROM EMPPRA P ';
  strSQL := strSQL + ' LEFT JOIN EMPPAR   ON PAR_CODEMP   = PRA_CODEMP ';
  strSQL := strSQL + 'WHERE PRA_CODFOR = :CODFOR ';
  strSQL := strSQL + 'ORDER BY PRA_CODEMP ';

  Result := strSQL;
End;

Function TPrazoEntregaFornecedor.fCarregaDados(strCodFor: String): Boolean;
   Var
     qryEmpresa: TUniQuery;
Begin
  qryQuery.ParamByName('CODFOR').AsString := strCodFor;
  Result := fLeDados('TPrazoEntregaFornecedor.fCarregaDados');

  pAlinhaCampoCentro('PRA_CODEMP');

  If Not Result Then
    Exit;

  qryEmpresa := fCriaQuery;

  qryEmpresa.SQL.Text := 'SELECT EMP_CODEMP, EMP_NOMEMP FROM CADEMP ' +
                         'LEFT JOIN EMPPRA ON PRA_CODFOR = :CODFOR AND PRA_CODEMP = EMP_CODEMP ' +
                         'WHERE PRA_CODEMP IS NULL ' +
                         'ORDER BY EMP_CODEMP ';

  qryEmpresa.ParamByName('CODFOR').AsString := strCodFor;
  qryEmpresa.Open;

  While Not qryEmpresa.Eof Do
  Begin
    Insert;
    FieldByName('PRA_CODFOR').AsString := strCodFor;
    FieldByName('PRA_CODEMP').AsString := qryEmpresa.FieldByName('EMP_CODEMP').AsString;
    FieldByName('PRA_NOMEMP').AsString := qryEmpresa.FieldByName('EMP_NOMEMP').AsString;
    Post;

    qryEmpresa.Next;
  End;

  FreeAndNil(qryEmpresa);
End;

Function TPrazoEntregaFornecedor.fSalvaDados(strCodFor: String): Boolean;
  Var
    strAutInc: String;
Begin
  DisableControls;

  Try
    Filter    := 'AUTOINCREM IS NULL';
    Filtered  := True;
    strAutInc := fRetAutoIncrem('EMPPRA', VS_strCodEmp, RecordCount);
    Filtered  := False;

    First;
    While Not Eof Do
    Begin

      If fEmptyStr(FieldByName('AUTOINCREM').AsString) Then
      Begin
        Edit;
        FieldByName('PRA_CODFOR').AsString := strCodFor;
        FieldByName('AUTOINCREM').AsString := strAutInc;
        Post;

        strAutInc := fNextAutoIncrem(strAutInc);
      End;

      Next;
    End;

  Finally
    Filtered := False;
    EnableControls;
  End;

  Result := fSalva;
End;

end.
