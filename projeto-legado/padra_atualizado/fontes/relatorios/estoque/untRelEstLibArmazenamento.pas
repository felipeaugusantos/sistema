unit untRelEstLibArmazenamento;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiRelatorio, frxDesgn, frxClass, frxDBSet, frxDMPExport,
  frxExportPDF, frxExportHTML, frxExportXLS, frxExportRTF, untTypesSistema,
  RLFilters, RLDraftFilter, AppEvnts, Menus, StdCtrls, EditFocus, QColorLabel,
  ExtCtrls, Buttons, BitBtnLockedIncrem, frxExportCSVTestabilidade, untIFuncoes,
  Uni, untConsultas, StrUtils;

type
  TfrmRelEstLibArmazenamento = class(TfrmPaiRelatorio)
    Panel1: TPanel;
    lbl5: TLabel;
    lbl6: TLabel;
    lbl7: TLabel;
    edtSerie: TEditFocus;
    edtEspecie: TEditFocus;
    edtDocumento: TEditFocus;
    lblCliFor: TLabel;
    edtCodFornecedor: TEditFocus;
    edtDesFornecedor: TEditFocus;
    lblEmpresa: TLabel;
    edtCodEmpresa: TEditFocus;
    edtDesEmpresa: TEditFocus;
    rdgForCli: TRadioGroup;
    pnlMltDocs: TPanel;
    btnAddDoc: TBitBtnLocked;
    btnLimpaLista: TBitBtnLocked;
    mmoLista: TMemo;
    chkMaisDeUmDocumento: TCheckBox;
    chkCadSem: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure edtCodFornecedorKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure btnImprimirClick(Sender: TObject);
    procedure rdgForCliClick(Sender: TObject);
    procedure chkMaisDeUmDocumentoClick(Sender: TObject);
    procedure btnAddDocClick(Sender: TObject);
    procedure btnLimpaListaClick(Sender: TObject);
  private
    stlDocumentos :TStringList;
    stlEspecies :TStringList;
    stlSeries :TStringList;
    stlEmpresas :TStringList;
    stlFornecedores :TStringList;
    stlTipFC: TStringList;
    Procedure pLimpaCampos;
    procedure pSetaTamanhoDocumento;
  public
    { Public declarations }
  Protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;    
  end;

implementation

uses untQckLiberacaoArmazenamento, untFuncoesSimples;

{$R *.dfm}

procedure TfrmRelEstLibArmazenamento.btnImprimirClick(Sender: TObject);
  Var
    frmQckLiberacaoArmazenamento: TfrmQckLiberacaoArmazenamento;
begin
  pCriarFormularios(TfrmQckLiberacaoArmazenamento,frmQckLiberacaoArmazenamento);
  If Not(chkMaisDeUmDocumento.Checked) Then
    frmQckLiberacaoArmazenamento.pImprimir(edtDocumento.Text,
                                           edtEspecie.Text,
                                           edtSerie.Text,
                                           edtCodFornecedor.Text,
                                           edtCodEmpresa.Text,
                                           Self.Name,
                                           edtDestino.Text,
                                           IfThen(rdgForCli.ItemIndex = 1, 'F', 'C'),
                                           oriLibReimpressaoLiberacaoDocUnico,
                                           chkCadSem.Checked)
  Else
  Begin
    If mmoLista.Lines.Count = 0  Then
      fMensagem('', 'Não há documentos selecionados para gerar o relatório!', ['&Ok'])
    Else
      frmQckLiberacaoArmazenamento.pImprimirDocumentos(stlDocumentos,
                                                     stlEspecies,
                                                     stlSeries,
                                                     stlEmpresas,
                                                     stlFornecedores,
                                                     stlTipFC,
                                                     Self.Name,
                                                     edtDestino.Text,
                                                     oriLibReimpressaoLiberacaoDocMultiplo,
                                                     chkCadSem.Checked);
  End;

  If Not frmQckLiberacaoArmazenamento.blnOk Then
    fMensagem('', 'Não há dados para gerar o relatório!', ['&Ok']);

  FreeAndNil(frmQckLiberacaoArmazenamento);
  pLimpaCampos;


end;

procedure TfrmRelEstLibArmazenamento.edtCodEmpresaKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmpresa, edtDesEmpresa, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmpresa, True) Then
      SelectNext(ActiveControl, True, True);
  End;
  
end;

procedure TfrmRelEstLibArmazenamento.edtCodFornecedorKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrFornec: TConsultasArray;
begin
  inherited;
  {*********************************}
  {* NOVA CONSULTA DE FORNECEDORES *}
  {******************************RV*}

  If rdgForCli.ItemIndex = 1 Then
  Begin
    If fPesqFornecedor(conForSimples, Self, edtCodFornecedor, edtDesFornecedor, Nil, Key, arrFornec) Then
    Begin
      If fValidaCampos(edtCodFornecedor, True) Then
        SelectNext(ActiveControl, True, True);
    End;
  End
  Else
  Begin
    If fPesqCliente(conCliSimples, Self, edtCodFornecedor, edtDesFornecedor, Nil, Key, arrFornec) Then
    Begin
      If fValidaCampos(edtCodFornecedor, True) Then
        SelectNext(ActiveControl, True, True);
    End;
  End;

end;

procedure TfrmRelEstLibArmazenamento.FormCreate(Sender: TObject);
begin
  inherited;
  If fCfgSis('MODLIB', varString) <> '2' Then
  Begin
    chkMaisDeUmDocumento.Visible := False;
    btnAddDoc.Visible := False;
    btnLimpaLista.Visible := False;
    mmoLista.Visible := False;
    pnlMltDocs.Visible := False;
    Self.Height := Self.Height -
                   chkMaisDeUmDocumento.Height -
                   pnlMltDocs.height;
  End;

  chkCadSem.Visible := fCfgSis('UTISEM', varBoolean);

  pSetaTamanhoDocumento;
  pLimpaCampos;
end;

procedure TfrmRelEstLibArmazenamento.pSetaTamanhoDocumento;
Begin
  if rdgForCli.ItemIndex = 1 Then
  Begin
    edtDocumento.TamCampo  := fTamNumDoc;
    edtDocumento.MaxLength := edtDocumento.TamCampo;
  End
  Else
  Begin
    edtDocumento.TamCampo  := 12;
    edtDocumento.MaxLength := 12;
  End;

  lblCliFor.Caption := Ifthen(rdgForCli.ItemIndex = 1, 'Fornecedor', 'Cliente');


End;

procedure TfrmRelEstLibArmazenamento.rdgForCliClick(Sender: TObject);
begin
  inherited;
  pSetaTamanhoDocumento;
end;

function TfrmRelEstLibArmazenamento.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    if (Sender = edtDocumento) and fEmptyStr(edtDocumento.Text) Then
    Begin
      Result := False;
      fMensagem('AVISO', 'Preencha o Numero do Documento!',['&OK']);
    End
    Else
    If (Sender = edtCodFornecedor ) Then
    Begin

      If rdgForCli.ItemIndex = 1 Then
      Begin
        If fEmptyStr(edtCodFornecedor.Text) Then
        Begin
          fMensagem('AVISO','Código do Fornecedor não Preenchido!', ['&O K']);
          Result := False;
        End
        Else
          edtDesFornecedor.Text := fRetNomFornecedor(edtCodFornecedor.Text);

        If Result and fEmptyStr(edtDesFornecedor.Text) Then
        Begin
          fMensagem('AVISO','Código do Fornecedor não encontrado.', ['&O K']);
          edtCodFornecedor.Clear;
          Result := False;
        End;
      End
      Else
        Begin
        If fEmptyStr(edtCodFornecedor.Text) Then
        Begin
          fMensagem('AVISO','Código do Cliente não Preenchido!', ['&O K']);
          Result := False;
        End
        Else
          edtDesFornecedor.Text := fRetNomCliente(edtCodFornecedor.Text);

        If Result and fEmptyStr(edtDesFornecedor.Text) Then
        Begin
          fMensagem('AVISO','Código do Cliente não encontrado.', ['&O K']);
          edtCodFornecedor.Clear;
          Result := False;
        End;

      End;

    End
    Else
    If (Sender = edtCodEmpresa) Then
    Begin
      If fEmptyStr(edtCodEmpresa.Text) Then
      Begin
        Result := False;
        fMensagem('AVISO','Código da Empresa não Preenchido!', ['&O K']);
      End
      Else
        edtDesEmpresa.Text := fRetNomeEmpresaSelec(edtCodEmpresa.Text);

      If Result and fEmptyStr(edtDesEmpresa.Text) Then
      Begin
        fMensagem('AVISO','Código da empresa não encontrado.', ['&O K']);
        edtCodEmpresa.Clear;
        Result := False;
      End;

    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmRelEstLibArmazenamento.pLimpaCampos;
begin
  edtDocumento.Clear;
  edtSerie.Clear;
  edtCodFornecedor.Clear;
  edtCodFornecedor.Enabled := True;
  edtDesFornecedor.Clear;

  edtEspecie.Text := 'NF';
  edtCodEmpresa.Text := VS_strCodEmp;
  edtDesEmpresa.Text := fRetNomeEmpresaSelec(edtCodEmpresa.Text);

  pSetFocus(edtDocumento);

end;

procedure TfrmRelEstLibArmazenamento.btnAddDocClick(Sender: TObject);
Var
  qryVerifDocumento: TUniQuery;
begin
  inherited;
  If pos(edtDocumento.Text + '-' + edtEspecie.Text + '-' +  edtSerie.Text,
         mmoLista.Lines.Text) > 0 Then
  Begin
    fMensagem('', 'Documento já inserido.', ['&Ok']);
    psetFocus(edtDocumento);
    Exit;
  End;

  qryVerifDocumento:= fCriaQuery(Self);
  With qryVerifDocumento Do
  Begin
    SQL.Add(' SELECT ');
    SQL.Add('   COUNT(AUTOINCREM) AS EXISTE  ');
    SQL.Add(' FROM MOVGER ');
    SQL.Add(' WHERE TRUE  ');
    SQL.Add('   AND GER_NUMDOC = :NUMDOC  ');
    SQL.Add('   AND GER_ESPDOC = :ESPDOC ');
    SQL.Add('   AND GER_SERIE_ = :SERIE ');
    SQL.Add('   AND GER_CODEMP = :CODEMP ');
    If rdgForCli.ItemIndex = 1 Then
      SQL.Add('   AND GER_CODFOR = :CODFOR ')
    Else
      SQL.Add('   AND GER_CODCLI = :CODFOR ');

    ParamByName('NUMDOC').AsString := edtDocumento.Text;
    ParamByName('ESPDOC').AsString := edtEspecie.Text;
    ParamByName('SERIE').AsString  := edtSerie.Text;
    ParamByName('CODEMP').AsString := edtCodEmpresa.Text;
    ParamByName('CODFOR').AsString := edtCodFornecedor.Text;

    Open;
  End;

  If qryVerifDocumento.FieldByName('EXISTE').AsInteger > 0 Then
  Begin
     stlDocumentos.Add(edtDocumento.Text);
     stlEspecies.Add(edtEspecie.Text);
     stlSeries.Add(edtSerie.Text);
     stlEmpresas.Add(edtCodEmpresa.Text);
     stlFornecedores.Add(edtCodFornecedor.Text);
     stlTipFc.Add(IIf(RdgForCli.ItemIndex = 0, 'C', 'F'));
     fMensagem('', 'Documento Incluído com Sucesso!', ['&Ok']);
     psetFocus(edtDocumento);
     edtCodFornecedor.Enabled := False;
     mmoLista.Lines.Add(edtDocumento.Text + '-' +
                        edtEspecie.Text + '-' +
                        edtSerie.Text);
     edtDocumento.Text := '';
     edtSerie.Text := '';
  End
  Else
  Begin
     fMensagem('', 'Documento Não Encontrado', ['&Ok']);
     psetFocus(edtDocumento);
  End;
  FreeAndNil(qryVerifDocumento);
end;

procedure TfrmRelEstLibArmazenamento.btnLimpaListaClick(Sender: TObject);
begin
  inherited;
  stlDocumentos.Clear;
  stlEspecies.Clear;
  stlSeries.Clear;
  stlEmpresas.Clear;
  stlFornecedores.Clear;
  stlTipFC.Clear;
  mmoLista.Clear;

  edtCodFornecedor.Enabled := True;
  fMensagem('','Documentos Armazenados Apagados', ['&Ok']);
end;

procedure TfrmRelEstLibArmazenamento.chkMaisDeUmDocumentoClick(Sender: TObject);
begin
  inherited;
  btnAddDoc.Enabled := chkMaisDeUmDocumento.Checked;
  mmoLista.Enabled := chkMaisDeUmDocumento.Checked;
  btnLimpaLista.Enabled := chkMaisDeUmDocumento.Checked;

  If chkMaisDeUmDocumento.Checked Then
  Begin
    stlDocumentos := TStringList.Create;
    stlEspecies := TStringList.Create;
    stlSeries := TStringList.Create;
    stlEmpresas := TStringList.Create;
    stlFornecedores := TStringList.Create;
    stlTipFC := TStringLIst.Create;
    fMensagem('', 'Insira os Documentos e Clique em Adicionar!', ['&Ok']);
  End
  Else
  Begin
    FreeAndNil(stlDocumentos);
    FreeAndNil(stlEspecies);
    FreeAndNil(stlSeries);
    FreeAndNil(stlEmpresas);
    FreeAndNil(stlFornecedores);
    FreeAndNil(stlTipFC);
    edtCodFornecedor.Enabled := True;
  End;
end;

end.

