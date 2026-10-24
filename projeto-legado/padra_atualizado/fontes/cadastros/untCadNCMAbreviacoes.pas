unit untCadNCMAbreviacoes;

interface

Uses
  Classes,
  SysUtils,
  Controls,
  DB,
  UniClientDataSet,
  Forms,
  Uni,
  untZClient,
  cxEdit,
  cxGridDBTableView,
  cxGridCustomTableView,
  Winapi.Windows;

Type
  TCadNcmAbf = class abstract(TZClient)
    private
      FOwner: TWinControl;
      FView: TcxGridDBTableView;

      function fAbreviacaoCadastrada(strCodigo: string): Boolean;

      procedure pBeforePost(dataSet: TDataSet);

      procedure pOnViewEditKeyDown(Sender: TcxCustomGridTableView;
        AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Word;
        Shift: TShiftState);

      procedure pOnViewEditKeyPress(Sender: TcxCustomGridTableView;
        AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Char);

    protected
      function fNomeTabela: String; virtual; abstract;
      function fSQLAbreviacao: String; virtual; abstract;
      function fDescricaoAbreviacao(strCodigo: String): String; virtual; abstract;
      function fPesquisarAbreviacao(Var strCodigo, strDescricao: String): Boolean; virtual; abstract;

    public
      constructor Create(Owner: TWinControl; cxgView: TcxGridDBTableView); reintroduce;

      procedure pExcluiAbreviacao;
      function fCarregaAbreviacao(strCodNcm, strCodExc: String): Boolean;
      function fSalvaAbreviacao(strCodNcm, strCodExc: String): Boolean;
  end;

  TCadNcmAbfIcms = class sealed(TCadNcmAbf)
  protected
    function fNomeTabela: String; override; final;
    function fSQLAbreviacao: String; override; final;
    function fDescricaoAbreviacao(strCodigo: String): String; override; final;
    function fPesquisarAbreviacao(Var strCodigo, strDescricao: String): Boolean; override; final;
  end;

  TCadNcmAbfPis = class sealed(TCadNcmAbf)
  protected
    function fNomeTabela: String; override; final;
    function fSQLAbreviacao: String; override; final;
    function fDescricaoAbreviacao(strCodigo: String): String; override; final;
    function fPesquisarAbreviacao(Var strCodigo, strDescricao: String): Boolean; override; final;
  end;

  TCadNcmAbfCofins = class sealed(TCadNcmAbf)
  protected
    function fNomeTabela: String; override; final;
    function fSQLAbreviacao: String; override; final;
    function fDescricaoAbreviacao(strCodigo: String): String; override; final;
    function fPesquisarAbreviacao(Var strCodigo, strDescricao: String): Boolean; override; final;
  end;

  TCadNcmAbfIpi = class sealed(TCadNcmAbf)
  protected
    function fNomeTabela: String; override; final;
    function fSQLAbreviacao: String; override; final;
    function fDescricaoAbreviacao(strCodigo: String): String; override; final;
    function fPesquisarAbreviacao(Var strCodigo, strDescricao: String): Boolean; override; final;
  end;

implementation

uses untFuncoesSimples, untConsultas, untTypesSistema;

constructor TCadNcmAbf.Create(Owner: TWinControl; cxgView: TcxGridDBTableView);
Begin
  Inherited Create(Owner, fSQLAbreviacao);
  FOwner := Owner;
  FView := cxgView;
  FView.OnEditKeyDown := pOnViewEditKeyDown;
  FView.OnEditKeyPress := pOnViewEditKeyPress;

  BeforePost := pBeforePost;
End;

function TCadNcmAbf.fCarregaAbreviacao(strCodNcm, strCodExc: String): Boolean;
Begin
  Try
    With qryQuery Do
    Begin
      Sql.Text := fSQLAbreviacao;
      ParamByName('CODNCM').AsString := strCodNcm;
      ParamByName('CODEXC').AsString := strCodExc;
      Result := fAbreClient(True, 'TCadNcmAbf.fCarregaAbreviacao');

      FieldByName('DESABF').ProviderFlags := [];
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TCadNcmAbf.fCarregaAbreviacao]');
    End;
  End;
End;

Function TCadNcmAbf.fSalvaAbreviacao(strCodNcm, strCodExc: String): Boolean;
Begin
  Try
    DisableControls;
    First;
    Result := True;

    BeforePost := Nil;

    While Not Eof Do
    Begin

      If fEmptyStr(FieldbyName('NCM_CODNCM').AsString) Then
      Begin
        Edit;
        FieldbyName('NCM_CODNCM').AsString := strCodNcm;
        FieldbyName('NCM_CODEXC').AsString := strCodExc;
        FieldbyName('AUTOINCREM').AsString := fRetAutoIncrem(fNomeTabela, VS_strCodEmp);
        Post;
      End;

      Next;
    End;

    Result := Result And fSalva;

    BeforePost := pBeforePost;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TCadNcmAbf.fSalvaAbreviacao]');
    End;
  End;

  EnableControls;
End;

Procedure TCadNcmAbf.pExcluiAbreviacao;
Begin
  If (Not IsEmpty) And fPergunta('Confirma a exclusão da Abreviação "' + FieldbyName('DESABF').AsString + '" ?') Then
    Delete;
End;

procedure TCadNcmAbf.pOnViewEditKeyDown(Sender: TcxCustomGridTableView;
  AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Word;
  Shift: TShiftState);
begin
  Case Key Of
    VK_RETURN: Begin
                 If Not Assigned(AItem) then
                   Exit;

                 If Not (AItem is TcxGridDBColumn) then
                   Exit;

                 If (AItem as TcxGridDBColumn).DataBinding.FieldName <> 'NCM_CODABF' then
                   Exit;

                 Try
                   AItem.GridView.NavigatorButtons.Post.Click;
                 Finally
                   AItem.GridView.NavigatorButtons.Insert.Click;
                 End;
               End;
  End;
end;

procedure TCadNcmAbf.pOnViewEditKeyPress(Sender: TcxCustomGridTableView;
  AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Char);
Var
  strCodigo: String;
  strDescricao: String;
begin
  inherited;

  If Not Assigned(AItem) then
    Exit;

  If Not (AItem is TcxGridDBColumn) then
    Exit;

  If (AItem as TcxGridDBColumn).DataBinding.FieldName <> 'NCM_CODABF' then
    Exit;

  If Not fEntraCons(Key) Then
    Exit;

  Key := #0;

  If Not fPesquisarAbreviacao(strCodigo, strDescricao) Then
    Exit;

  AItem.EditValue := strCodigo;

  If (AItem.Index + 1) < (AItem.GridView.ItemCount) then
    AItem.GridView.Items[AItem.Index + 1].EditValue := strDescricao;
end;

function TCadNcmAbf.fAbreviacaoCadastrada(strCodigo: string): Boolean;
  Var
    intRecordIndex: Integer;
begin
  Result := False;

  If Not Assigned(FView) Then
    Exit;

  With FView.DataController Do
  For intRecordIndex := 0 to RowCount - 1 do
  begin
    Result := SameText(DisplayTexts[intRecordIndex, 0], strCodigo)
      and (intRecordIndex <> FocusedRowIndex);
    If Result then
      Exit;
  end;
end;

Procedure TCadNcmAbf.pBeforePost(dataSet: TDataSet);
  Var
    strDesAbf: String;
Begin
  With dataSet Do
  Begin
    If fEmptyStr(FieldByName('NCM_CODABF').AsString) Then
    Begin
      Cancel;
      Abort;
      Exit;
    End;

    FieldByName('NCM_CODABF').AsString := fStrZero(FieldByName('NCM_CODABF').AsString, IIf(fCfgSis('USASAN') = 'S', 7, 3));

    If fAbreviacaoCadastrada(FieldByName('NCM_CODABF').AsString) Then
    begin
      pMensagemOk('Abreviação já cadastrada!');
      Cancel;
      Abort;
      Exit;
    End;

    strDesAbf := Self.fDescricaoAbreviacao(FieldByName('NCM_CODABF').AsString);

    If fEmptyStr(strDesAbf)  Then
    begin
      pMensagemOk('Abreviação não encontrada!');
      Cancel;
      Abort;
      Exit;
    End;

    FieldByName('DESABF').AsString := strDesAbf;
  End;
End;

{ TCadNcmAbfIcms }

function TCadNcmAbfIcms.fDescricaoAbreviacao(strCodigo: String): String;
begin
  Result := fRetDesAbfIcm(strCodigo);
end;

function TCadNcmAbfIcms.fNomeTabela: String;
begin
  Result := 'NCMICM';
end;

function TCadNcmAbfIcms.fPesquisarAbreviacao(var strCodigo,
  strDescricao: String): Boolean;
Var
  Key: Char;
  qryTab: TUniQuery;
  arrAbf: TConsultasArray;
begin
  Key := '?';
  qryTab := fCriaQuery(nil);
  Try
    Result := fPesqAbrevFiscal(GetParentForm(FOwner) as TForm, nil, nil, qryTab, Key, arrAbf);
    If Result Then
    Begin
      strCodigo := qryTab.FieldByName('ABF_CODABF').AsString;
      strDescricao := qryTab.FieldByName('ABF_DESABF').AsString;
    End;
  Finally
    FreeAndNil(qryTab);
  End;
end;

function TCadNcmAbfIcms.fSQLAbreviacao: String;
begin
  Result := '';
  Result := Result + ' SELECT SQL_NO_CACHE ';
  Result := Result + '   A.*,  ';
  Result := Result + '   (SELECT ABF_DESABF FROM ABFICM WHERE ABF_CODABF = A.NCM_CODABF LIMIT 1) AS DESABF ';
  Result := Result + ' FROM ';
  Result := Result + '   ' + fNomeTabela + ' A ';
  Result := Result + ' WHERE ';
  Result := Result + '   A.NCM_CODNCM = :CODNCM AND ';
  Result := Result + '   A.NCM_CODEXC = :CODEXC ';
end;

{ TCadNcmAbfPis }

function TCadNcmAbfPis.fDescricaoAbreviacao(strCodigo: String): String;
begin
  Result := fRetDesAbfPis(strCodigo);
end;

function TCadNcmAbfPis.fNomeTabela: String;
begin
  Result := 'NCMPIS';
end;

function TCadNcmAbfPis.fPesquisarAbreviacao(var strCodigo,
  strDescricao: String): Boolean;
Var
  Key: Char;
  qryTab: TUniQuery;
  arrAbf: TConsultasArray;
begin
  Key := '?';
  qryTab := fCriaQuery(nil);
  Try
    Result := fPesqPisSai(GetParentForm(FOwner) as TForm, nil, nil, qryTab, Key, arrAbf);
    If Result Then
    Begin
      strCodigo := qryTab.FieldByName('APC_CODAPC').AsString;
      strDescricao := qryTab.FieldByName('APC_DESCRI').AsString;
    End;
  Finally
    FreeAndNil(qryTab);
  End;
end;

function TCadNcmAbfPis.fSQLAbreviacao: String;
begin
  Result := '';
  Result := Result + ' SELECT SQL_NO_CACHE ';
  Result := Result + '   A.*,  ';
  Result := Result + '   (SELECT APC_DESCRI FROM PISSAI WHERE APC_CODAPC = A.NCM_CODABF LIMIT 1) AS DESABF ';
  Result := Result + ' FROM ';
  Result := Result + '   ' + fNomeTabela + ' A ';
  Result := Result + ' WHERE ';
  Result := Result + '   A.NCM_CODNCM = :CODNCM AND ';
  Result := Result + '   A.NCM_CODEXC = :CODEXC ';
end;

{ TCadNcmAbfCofins }

function TCadNcmAbfCofins.fDescricaoAbreviacao(strCodigo: String): String;
begin
  Result := fRetDesAbfCof(strCodigo);
end;

function TCadNcmAbfCofins.fNomeTabela: String;
begin
  Result := 'NCMCOF';
end;

function TCadNcmAbfCofins.fPesquisarAbreviacao(var strCodigo,
  strDescricao: String): Boolean;
Var
  Key: Char;
  qryTab: TUniQuery;
  arrAbf: TConsultasArray;
begin
  Key := '?';
  qryTab := fCriaQuery(nil);
  Try
    Result := fPesqCofSai(GetParentForm(FOwner) as TForm, nil, nil, qryTab, Key, arrAbf);
    If Result Then
    Begin
      strCodigo := qryTab.FieldByName('APC_CODAPC').AsString;
      strDescricao := qryTab.FieldByName('APC_DESCRI').AsString;
    End;
  Finally
    FreeAndNil(qryTab);
  End;
end;

function TCadNcmAbfCofins.fSQLAbreviacao: String;
begin
  Result := '';
  Result := Result + ' SELECT SQL_NO_CACHE ';
  Result := Result + '   A.*,  ';
  Result := Result + '   (SELECT APC_DESCRI FROM COFSAI WHERE APC_CODAPC = A.NCM_CODABF LIMIT 1) AS DESABF ';
  Result := Result + ' FROM ';
  Result := Result + '   ' + fNomeTabela + ' A ';
  Result := Result + ' WHERE ';
  Result := Result + '   A.NCM_CODNCM = :CODNCM AND ';
  Result := Result + '   A.NCM_CODEXC = :CODEXC ';
end;

{ TCadNcmAbfIpi }

function TCadNcmAbfIpi.fDescricaoAbreviacao(strCodigo: String): String;
begin
  Result := fRetDesAbfIpi(strCodigo);
end;

function TCadNcmAbfIpi.fNomeTabela: String;
begin
  Result := 'NCMIPI';
end;

function TCadNcmAbfIpi.fPesquisarAbreviacao(var strCodigo,
  strDescricao: String): Boolean;
Var
  Key: Char;
  qryTab: TUniQuery;
  arrAbf: TConsultasArray;
begin
  Key := '?';
  qryTab := fCriaQuery(nil);
  Try
    Result := fPesqIPISai(GetParentForm(FOwner) as TForm, nil, qryTab, Key, arrAbf);
    If Result Then
    Begin
      strCodigo := qryTab.FieldByName('APC_CODAPC').AsString;
      strDescricao := qryTab.FieldByName('APC_DESCRI').AsString;
    End;
  Finally
    FreeAndNil(qryTab);
  End;
end;

function TCadNcmAbfIpi.fSQLAbreviacao: String;
begin
  Result := '';
  Result := Result + ' SELECT SQL_NO_CACHE ';
  Result := Result + '   A.*,  ';
  Result := Result + '   (SELECT APC_DESCRI FROM IPISAI WHERE APC_CODAPC = A.NCM_CODABF LIMIT 1) AS DESABF ';
  Result := Result + ' FROM ';
  Result := Result + '   ' + fNomeTabela + ' A ';
  Result := Result + ' WHERE ';
  Result := Result + '   A.NCM_CODNCM = :CODNCM AND ';
  Result := Result + '   A.NCM_CODEXC = :CODEXC ';
end;

end.
