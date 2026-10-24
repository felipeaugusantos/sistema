unit untAltPrecoAcabadosInd;

interface

uses
  Windows, Classes, Controls, untPaiEdit, BitBtnLockedIncrem, StdCtrls, Buttons,
  ExtCtrls, EditFocus, ComCtrls, untFuncoesSimples, Menus, AppEvnts, untTypesSistema,
  frxClass, frxExportCSVTestabilidade, Vcl.Mask, MaskEditFocus, untPreAlt_Trigger ;

type
  TfrmAltPrecoAcabadosInd = class(TfrmPaiEdit)
    btnGravar: TBitBtnLocked;
    rdgMarPre: TRadioGroup;
    shpMultSel: TShape;
    gpbGranel: TGroupBox;
    Label7: TLabel;
    edtCodGra: TEditFocus;
    edtDesGra: TEditFocus;
    Label2: TLabel;
    edtDesGruGra: TEditFocus;
    edtCodDepGra: TEditFocus;
    Label12: TLabel;
    edtDesCodDepGra: TEditFocus;
    Label5: TLabel;
    edtRefereGra: TEditFocus;
    gpbAcabado: TGroupBox;
    Label4: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    edtDesGruAca: TEditFocus;
    edtCodDepAca: TEditFocus;
    edtDesCodDepAca: TEditFocus;
    edtRefereAca: TEditFocus;
    Label1: TLabel;
    edtCodAca: TEditFocus;
    edtDesAca: TEditFocus;
    mskLinGruGra: TMaskEditFocus;
    mskLinGruAca: TMaskEditFocus;
    procedure edtCodGraKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodGraExit(Sender: TObject);
    procedure edtCodAcaExit(Sender: TObject);
    procedure edtCodAcaKeyPress(Sender: TObject; var Key: Char);
    procedure btnGravarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure mskLinGruGraExit(Sender: TObject);
    procedure edtCodDepGraExit(Sender: TObject);
    procedure mskLinGruGraKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodDepGraKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodDepAcaExit(Sender: TObject);
    procedure edtCodDepAcaKeyPress(Sender: TObject; var Key: Char);
    procedure mskLinGruAcaExit(Sender: TObject);
    procedure mskLinGruAcaKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
     arrProGra        : TConsultasArray;
     arrProAca        : TConsultasArray;
     arrLinhaGrupoGra : TConsultasArray;
     arrLinhaGrupoAca : TConsultasArray;
     arrCodDepGra      : TConsultasArray;
     arrCodDepAca       : TConsultasArray;

     Function fAtualizaCustos: Boolean;

     Procedure pLimpaCampos;

  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  end;

implementation

{$R *.dfm}

Uses
  SysUtils, Forms, untProdutosAcabadosIndustrial, untConsultas, untFuncoesConsulta,
  OrdemProducaoIndustrial.TAtualizacaoCustosProdutosAcabadosGeral,
  OrdemProducaoIndustrial.TFiltroProduto, untPreAlt;

procedure TfrmAltPrecoAcabadosInd.btnGravarClick(Sender: TObject);
  var
    strAgrupadorPreAlt: String;
begin
  inherited;

  pPreAltDefineVariaveisAltPre(fNow, 'ATUALIZACAO CUSTO DE ACABADOS', strLoginUsuarioLogado, VS_StrCodEmp, strAgrupadorPreAlt);

  If fVerificaCampos And fAtualizaCustos Then
  Begin
    pMensagemOk('Operação concluída com sucesso!');
    pLimpaCampos;
  End;
  strAgrupadorPreAlt := '';
end;

procedure TfrmAltPrecoAcabadosInd.edtCodAcaExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodAca, edtDesAca, arrProAca, nil, fRetNomProduto, 'do Produto Acabado');

end;

procedure TfrmAltPrecoAcabadosInd.edtCodAcaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqItem(conIteSimples, Self, edtCodAca, edtDesAca,
               nil, Key, arrProAca, False,
               nil, 'Consulta de Itens', '1',
               '',
               0,
               False,
               False,
               0,
               cdrCodIte,
               '',
               False,
               '',
               '',
               True,
               False,
               True,
               '',
               False,
               True,
               False,
               False) {Departamento produto granel cadestruturaindustrial} Then
  Begin
    If fValidaCampos(edtCodAca, True) then
      Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmAltPrecoAcabadosInd.edtCodDepAcaExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodDepAca, edtDesCodDepAca, arrCodDepAca, fRetNomDep, nil, 'do Departamento');
end;

procedure TfrmAltPrecoAcabadosInd.edtCodDepAcaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqDepartamento(Self, edtCodDepAca, edtDesCodDepAca, nil, key, arrCodDepAca, False) Then
  Begin
    if fValidaCampos(edtCodDepAca, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmAltPrecoAcabadosInd.edtCodDepGraExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodDepGra, edtDesCodDepGra, arrCodDepGra, fRetNomDep, nil, 'do Departamento');
end;

procedure TfrmAltPrecoAcabadosInd.edtCodDepGraKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqDepartamento(Self, edtCodDepGra, edtDesCodDepGra, nil, key, arrCodDepGra, False) Then
  Begin
    if fValidaCampos(edtCodDepGra, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmAltPrecoAcabadosInd.edtCodGraExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodGra, edtDesGra, arrProGra, nil, fRetNomProduto, 'do Produto a Granel');

end;

procedure TfrmAltPrecoAcabadosInd.edtCodGraKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqItem(conIteSimples, Self, edtCodGra, edtDesGra,
               nil, Key, arrProGra, False,
               nil, 'Consulta de Itens', '1',
               '',
               0,
               False,
               False,
               0,
               cdrCodIte,
               '',
               False,
               '',
               '',
               True,
               False,
               True,
               '',
               False,
               False,
               False,
               True) {Departamento produto granel cadestruturaindustrial} Then
  Begin
    If fValidaCampos(edtCodGra, True) then
      Self.SelectNext(ActiveControl, True, True);
  End;

end;

function TfrmAltPrecoAcabadosInd.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin

  Result := True;

  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin

    If Sender = edtCodGra Then
    Begin

      If (Not fEmptyStr(edtCodGra.Text)) And (Length(arrProGra) <= 1) And
         (fCampoTabela('ITE_CODDEP', 'CADITE', ['ITE_CODITE'], [edtCodGra.Text]) <>
          fRetTipoDepartamento((fCampoTabela('ITE_CODDEP', 'CADITE', ['ITE_CODITE'], [edtCodGra.Text])), 'PROGRA')) Then
      Begin
        Result := False;
        pMensagemOk('Esse produto não é A Granel!');
      End;

      pDesmarcaLista(edtCodGra, arrProGra);
    End

    Else If Sender = edtCodAca Then
    Begin

      If (Not fEmptyStr(edtCodAca.Text)) And (Length(arrProAca) <= 1) And
        (fCampoTabela('ITE_CODDEP', 'CADITE', ['ITE_CODITE'], [edtCodAca.Text]) <>
         fRetTipoDepartamento((fCampoTabela('ITE_CODDEP', 'CADITE', ['ITE_CODITE'], [edtCodAca.Text])), 'PROACA')) Then
      Begin
        Result := False;
        pMensagemOk('Esse produto não é Acabado!');
      End;

      pDesmarcaLista(edtCodAca, arrProAca);
    End

    Else If Sender = edtCodDepGra Then
    Begin
      pDesmarcaLista(edtCodDepGra, arrCodDepGra);
    end

    Else If Sender = edtCodDepAca Then
    Begin
      pDesmarcaLista(edtCodDepAca, arrCodDepAca);
    end

    Else If Sender = mskLinGruGra Then
    Begin
      pDesmarcaLista(mskLinGruGra, arrLinhaGrupoGra, '', 6);
    end

    else If Sender = mskLinGruAca Then
    Begin
      pDesmarcaLista(mskLinGruAca, arrLinhaGrupoAca, '', 6);
    end;

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmAltPrecoAcabadosInd.mskLinGruAcaExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(mskLinGruAca, edtDesGruAca, arrLinhaGrupoAca, fRetNomeLinhaGrupo, Nil, 'da linha/grupo', 6);
end;

procedure TfrmAltPrecoAcabadosInd.mskLinGruAcaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqGrupo(Self, mskLinGruAca, edtDesGruAca, nil, Key, arrLinhaGrupoAca, False) Then
  Begin
    If fValidaCampos(mskLinGruAca, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmAltPrecoAcabadosInd.mskLinGruGraExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(mskLinGruGra, edtDesGruGra, arrLinhaGrupoGra, fRetNomeLinhaGrupo, Nil, 'da linha/grupo', 6);
end;

procedure TfrmAltPrecoAcabadosInd.mskLinGruGraKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqGrupo(Self, mskLinGruGra, edtDesGruGra, nil, Key, arrLinhaGrupoGra, False) Then
  Begin
    If fValidaCampos(mskLinGruGra, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

Procedure TfrmAltPrecoAcabadosInd.pLimpaCampos;
Begin
  edtCodGra.Clear;
  edtDesGra.Clear;

  edtCodAca.Clear;
  edtDesAca.Clear;

  pSetFocus(edtCodGra);                    
End;

Function TfrmAltPrecoAcabadosInd.fAtualizaCustos: Boolean;
  Var
    objAtualizacaoCustos: TAtualizacaoCustosProdutosAcabadosGeral;

Begin
  objAtualizacaoCustos := TAtualizacaoCustosProdutosAcabadosGeral.Create;
  try
    objAtualizacaoCustos.objFiltroProdutoGranel.strCodigo             := objAtualizacaoCustos.objFiltroProdutoGranel.fRetornaFiltro(edtCodGra.Text, arrProGra);
    objAtualizacaoCustos.objFiltroProdutoGranel.strLinhaGrupo         := objAtualizacaoCustos.objFiltroProdutoGranel.fRetornaFiltro(mskLinGruGra.Text, arrLinhaGrupoGra);
    objAtualizacaoCustos.objFiltroProdutoGranel.strCodigoDepartamento := objAtualizacaoCustos.objFiltroProdutoGranel.fRetornaFiltro(edtCodDepGra.Text, arrCodDepGra);
    objAtualizacaoCustos.objFiltroProdutoGranel.strReferencia         := edtRefereGra.Text;

    objAtualizacaoCustos.objFiltroProdutoAcabado.strCodigo             := objAtualizacaoCustos.objFiltroProdutoAcabado.fRetornaFiltro(edtCodAca.Text, arrProAca);
    objAtualizacaoCustos.objFiltroProdutoAcabado.strLinhaGrupo         := objAtualizacaoCustos.objFiltroProdutoAcabado.fRetornaFiltro(mskLinGruAca.Text, arrLinhaGrupoAca);
    objAtualizacaoCustos.objFiltroProdutoAcabado.strCodigoDepartamento := objAtualizacaoCustos.objFiltroProdutoAcabado.fRetornaFiltro(edtCodDepAca.Text, arrCodDepAca);
    objAtualizacaoCustos.objFiltroProdutoAcabado.strReferencia         := edtRefereAca.Text;

    objAtualizacaoCustos.blnMargem := rdgMarPre.ItemIndex = 0;

    If objAtualizacaoCustos.ftemFiltro then
      pMensagemOk('Alguns filtros foram utilizados, não irá calcular a estrutura obedecendo seus subníveis !');

    If Length(mskLinGruAca.Text) > 5 Then
    Begin
      If (Copy(mskLinGruAca.Text,4,3) = '000') And (Copy(mskLinGruAca.Text,1,3)<>'000') Then
        objAtualizacaoCustos.objFiltroProdutoAcabado.ConsiderarTodosGruposDaLinha := fPergunta('Deseja considerar todos os grupos da linha "'+Copy(mskLinGruAca.Text,1,3)+' - '+edtDesGruAca.Text+'" do produto acabado?');
      objAtualizacaoCustos.objFiltroProdutoAcabado.Linha := Copy(mskLinGruAca.Text,1,3);
    End;

    If Length(mskLinGruGra.Text) > 5 Then
    Begin
      If (Copy(mskLinGruGra.Text,4,3) = '000') And (Copy(mskLinGruGra.Text,1,3)<>'000') Then
        objAtualizacaoCustos.objFiltroProdutoGranel.ConsiderarTodosGruposDaLinha := fPergunta('Deseja considerar todos os grupos da linha "'+Copy(mskLinGruGra.Text,1,3)+' - '+edtDesGruGra.Text+'" do produto a granel?');
      objAtualizacaoCustos.objFiltroProdutoGranel.Linha := Copy(mskLinGruGra.Text,1,3);
    End;

    Result := objAtualizacaoCustos.fAtualizaCustos;
  finally
    FreeAndNil(objAtualizacaoCustos);
  end;

End;

procedure TfrmAltPrecoAcabadosInd.FormCreate(Sender: TObject);
begin
  inherited;

  If fCfgSis('VENMAR', varString) = 1 Then
    rdgMarPre.ItemIndex:= 1
  Else
    rdgMarPre.ItemIndex:= 0;

end;

procedure TfrmAltPrecoAcabadosInd.FormShow(Sender: TObject);
begin
  inherited;
  pSetaCodIte( edtCodGra );
  pSetaCodIte( edtCodAca );
end;

end.

