unit untConsultaProdutoAncora;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, ancora.comunicacao, Uni, EditFocus, cxProgressBar;

type
  TfrmConsultaProdutoAncora = class(TfrmPai)
    Panel1: TPanel;
    Label1: TLabel;
    edtCodCna: TEditFocus;
    Panel2: TPanel;
    Label5: TLabel;
    edtCodEan: TEditFocus;
    Panel3: TPanel;
    Label2: TLabel;
    edtCodFab: TEditFocus;
    Label6: TLabel;
    edtMarca: TEditFocus;
    BitBtnLocked1: TBitBtnLocked;
    GroupBox1: TGroupBox;
    lblEstoque: TLabel;
    lblNome: TLabel;
    lblCodFab: TLabel;
    lblMarca: TLabel;
    lblRetNome: TLabel;
    lblRetCodFab: TLabel;
    lblRetMarca: TLabel;
    lblRetEstoque: TLabel;
    btnBuscar: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BitBtnLocked1Click(Sender: TObject);
    procedure btnBuscarClick(Sender: TObject);
  private
    FRedeAncora : TRedeAncora;
    qryConsulta: TUniQuery;
    function fImportandoAncora(pgbStatus: TcxProgressBar = Nil): Boolean;
    procedure pDefineFocoCodFabMarca;

    { Private declarations }
  public
    FCodIte: String;
    class procedure pConsultaFullSearch(ACodIte: String; var ARedeAncora: TRedeAncora);
    { Public declarations }
  end;

implementation

uses
  Ancora.Classes.EndPoint, untFuncoesSimples, untGravando;

{$R *.dfm}

{ TfrmConsultaProdutoAncora }

procedure TfrmConsultaProdutoAncora.BitBtnLocked1Click(Sender: TObject);
begin
  inherited;
  edtCodCna.Clear;
  edtCodEan.Clear;
  edtCodFab.Clear;
  EdtMarca.Clear;
  lblRetNome.Caption := '';
  lblRetCodFab.Caption := '';
  lblRetMarca.Caption := '';
  lblRetEstoque.Caption := '';
  pSetFocus(edtCodCna);
end;

procedure TfrmConsultaProdutoAncora.FormCreate(Sender: TObject);
begin
  inherited;
  qryConsulta := fCriaQuery;
end;

procedure TfrmConsultaProdutoAncora.FormDestroy(Sender: TObject);
begin
  FreeAndNil(qryConsulta);
  inherited;

end;

class procedure TfrmConsultaProdutoAncora.pConsultaFullSearch(ACodIte: String; var ARedeAncora: TRedeAncora);
var frmConsultaProdutoAncora : TfrmConsultaProdutoAncora;
begin
  If not Assigned(ARedeAncora) Then
  begin
    ARedeAncora := TRedeAncora.Create;
  End;

  If Not ARedeAncora.RetApiProfile.TemWarehouses Then
    ARedeAncora.fGetProfile;

  pCriarFormularios(TfrmConsultaProdutoAncora, frmConsultaProdutoAncora);
  Try
    frmConsultaProdutoAncora.FRedeAncora := ARedeAncora;
    If Not fEmptyStr(ACodIte) Then
    begin
      frmConsultaProdutoAncora.qryConsulta.SQL.Add('SELECT ITE_CODCNA ,I.ITE_CODITE,  I.ITE_CODBAR, M.MAR_DESMAR, C.ITE_CODFAB, C.ITE_DESITE');
      frmConsultaProdutoAncora.qryConsulta.SQL.Add('  FROM CADFOR F');
      frmConsultaProdutoAncora.qryConsulta.SQL.Add(' INNER JOIN ITEFOR I ON I.ITE_CODFOR = F.FOR_CODFOR');
      frmConsultaProdutoAncora.qryConsulta.SQL.Add('  LEFT JOIN CADITE C ON I.ITE_CODITE = C.ITE_CODITE');
      frmConsultaProdutoAncora.qryConsulta.SQL.Add('  LEFT JOIN CADMAR M ON M.MAR_CODMAR = C.ITE_CODMAR');
      frmConsultaProdutoAncora.qryConsulta.SQL.Add(' WHERE TRUE');
      frmConsultaProdutoAncora.qryConsulta.SQL.Add('   AND F.FOR_C_G_C_ = "' + ARedeAncora.RetApiProfile.Warehouses[0].cgc + '"');
      frmConsultaProdutoAncora.qryConsulta.SQL.Add('   AND IFNULL(I.ITE_CODCNA, "" ) <> ""');
      frmConsultaProdutoAncora.qryConsulta.SQL.Add('   AND I.ITE_CODITE = :CODITE');
      frmConsultaProdutoAncora.qryConsulta.ParamByName('CODITE').AsString := ACodIte;
      frmConsultaProdutoAncora.qryConsulta.Open;

      If Not frmConsultaProdutoAncora.qryConsulta.IsEmpty Then
      begin
        If not fEmptyStr(frmConsultaProdutoAncora.qryConsulta.FieldByName('ITE_CODCNA').AsString) Then
          frmConsultaProdutoAncora.edtCodCna.Text := frmConsultaProdutoAncora.qryConsulta.FieldByName('ITE_CODCNA').AsString
        Else If not fEmptyStr(frmConsultaProdutoAncora.qryConsulta.FieldByName('ITE_CODBAR').AsString) Then
          frmConsultaProdutoAncora.edtCodEan.Text := frmConsultaProdutoAncora.qryConsulta.FieldByName('ITE_CODBAR').AsString
        Else If (not fEmptyStr(frmConsultaProdutoAncora.qryConsulta.FieldByName('MAR_DESMAR').AsString)) and
                (not fEmptyStr(frmConsultaProdutoAncora.qryConsulta.FieldByName('ITE_CODFAB').AsString)) Then
        begin
          frmConsultaProdutoAncora.EdtMarca.Text := frmConsultaProdutoAncora.qryConsulta.FieldByName('MAR_DESMAR').AsString;
          frmConsultaProdutoAncora.edtCodFab.Text := frmConsultaProdutoAncora.qryConsulta.FieldByName('ITE_CODFAB').AsString;
        end;
      End;


    End;

    frmConsultaProdutoAncora.ShowModal;
  Finally
    FreeAndNil(frmConsultaProdutoAncora);
  End;
end;

procedure TfrmConsultaProdutoAncora.pDefineFocoCodFabMarca;
begin
  If fEmptyStr(edtCodFab.Text) Then
    pSetFocus(edtCodFab)
  Else
    pSetFocus(edtMarca)
  {}
end;

procedure TfrmConsultaProdutoAncora.btnBuscarClick(Sender: TObject);
var frmGravando: TfrmGravando;
begin
  pCriarFormularios(TfrmGravando, frmGravando);
  Try
    frmGravando.lblGravando.Caption := 'Consultando Rede Ancora...';
    frmGravando.pgbStatus.Visible := False;
    frmGravando.fExecutarAcao := fImportandoAncora;
    frmGravando.ShowModal;
  finally
    FreeAndNil(frmGravando);
  End;
end;

function TfrmConsultaProdutoAncora.fImportandoAncora(pgbStatus: TcxProgressBar = Nil): Boolean;
  var ParamnsFullSearch: TParamnsFullSearch;
begin
  Result := True;
  lblRetNome.Caption := '';
  lblRetCodFab.Caption := '';
  lblRetMarca.Caption := '';
  lblRetEstoque.Caption := '';

  If (Not(fEmptyStr(edtCodFab.Text))) xor (Not(fEmptyStr(EdtMarca.Text))) then
  begin
    pMensagemOk('Para consultar por Código de Fábrica + marca, os dois campos devem estar preenchidos!');
    pDefineFocoCodFabMarca;
    Exit;
  End;

  If fEmptyStr(edtCodCna.Text + edtCodEan.Text  + edtCodFab.Text + edtCodFab.Text) then
  begin
    pMensagemOk('Para consultar, pelo menos um filtro deve ser preenchido!');
    Exit;
  end;

  Try
    ParamnsFullSearch := TParamnsFullSearch.Create;
    Try
      ParamnsFullSearch.empresa := FRedeAncora.RetApiProfile.WareHousePreferencial;
      ParamnsFullSearch.brand := EdtMarca.Text;
      ParamnsFullSearch.code := edtCodFab.Text;
      ParamnsFullSearch.gtin := edtCodEan.Text;
      ParamnsFullSearch.fields := [prices,stocks];

      If not fEmptyStr(edtCodCna.Text) Then
        ParamnsFullSearch.cna := edtCodCna.Text;
      FRedeAncora.fRetFullSearch(ParamnsFullSearch);

      If Not ParamnsFullSearch.RetornoApi.Sucess then
      begin
        pMensagemOk('Retorno com erro: ' + ParamnsFullSearch.RetornoApi.Falha);
        Exit;
      end;

      lblRetNome.Caption := FRedeAncora.RetApiFullSearch.nome;
      lblRetCodFab.Caption := FRedeAncora.RetApiFullSearch.codFabrica;
      lblRetMarca.Caption := FRedeAncora.RetApiFullSearch.marca;
      lblRetEstoque.Caption := FRedeAncora.RetApiFullSearch.fltEstoque.ToString();
    finally
      freeAndNil(ParamnsFullSearch);
    End;
  Except
    on e:exception do
      pMensagensErro(e.message, '[TfrmConsultaProdutoAncora.fImportandoAncora]');
  End;
end;


end.


