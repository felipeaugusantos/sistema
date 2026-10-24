unit untFatRomaneioImpr;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, EditFocus,
  QColorLabel, AppEvnts, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmFatRomaneioImpr = class(TfrmPai)
    btnConfirmar: TBitBtnLocked;
    grbRota: TGroupBox;
    GroupBox1: TGroupBox;
    ckbItensCli: TCheckBox;
    ckbMosMar: TCheckBox;
    edtCliQV: TEditFocus;
    clbCliQV: TColorLabel;
    edtCliOrd: TEditFocus;
    clbCliOrd: TColorLabel;
    ckbImprimir: TCheckBox;
    ckbIteDoc: TCheckBox;
    pnlDadRom: TPanel;
    ckbProdutos: TCheckBox;
    clbQtdVol: TColorLabel;
    clbDesLoc: TColorLabel;
    edtQtdVol: TEditFocus;
    edtDesLoc: TEditFocus;
    ckbEmbalagens: TCheckBox;
    clbEmbQV: TColorLabel;
    edtEmbQV: TEditFocus;
    ckbDocumentos: TCheckBox;
    ckbTotEspDoc: TCheckBox;
    ckbFormas: TCheckBox;
    ckbInfItem: TCheckBox;
    ckbCarCar: TCheckBox;
    ckbImpKm: TCheckBox;
    ckbEndEnt: TCheckBox;
    edtDocEnd: TEditFocus;
    clbDocEnd: TColorLabel;
    clbCliOrd2: TColorLabel;
    chkLocAss: TCheckBox;
    chkRotViagem: TCheckBox;
    chkImpVal: TCheckBox;
    chkMenExp: TCheckBox;
    procedure btnConfirmarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure ckbProdutosClick(Sender: TObject);
    procedure ckbEmbalagensClick(Sender: TObject);
    procedure ckbItensCliClick(Sender: TObject);
    procedure ckbImprimirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ckbIteDocClick(Sender: TObject);
    procedure ckbEndEntClick(Sender: TObject);
    procedure ckbDocumentosClick(Sender: TObject);
  private
    { Private declarations }
    blnVerificaCkbImprimir: Boolean;

    procedure pInicializaConfig;
    procedure pSalvaConfig;

    function fGetMenorNomeComp(eComponente: TComponent): String;
    function fFindComponentLike(strNome: String): TComponent;
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  public
    { Public declarations }
    blnImprimi   : Boolean;
    blnProdutos  : Boolean;
    blnEmbalagens: Boolean;
    blnDocumentos: Boolean;
    blnFormas    : Boolean;
    blnItemCli   : Boolean;
    blnIteDoc    : Boolean;
    blnEndEnt    : Boolean;
    blnInfItem   : Boolean;
    blnTotEspDoc : Boolean;
    blnMosMar    : Boolean;
    blnCarCar    : Boolean;
    blnImpKm     : Boolean;
    blnPreviaRom : Boolean;
    blnImpVal    : Boolean;
    blnMenExp    : Boolean;

    blnConfig    : Boolean;
    strConfig    : String;
    blnGravar    : Boolean;

  end;

var
  frmFatRomaneioImpr: TfrmFatRomaneioImpr;

implementation

uses  untfuncoesSimples, StrUtils;

{$R *.dfm}

function TfrmFatRomaneioImpr.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin
    {****************************}
    {* VERIFICA CAMPO IMPRIMIR  *}
    {*************************LU*}
    If (Sender = ckbImprimir) And (blnVerificaCkbImprimir) Then
    Begin
      If Not ckbImprimir.Checked Then
      Begin
        grbRota.Enabled := False;
        ckbItensCli.Enabled := False;
        ckbInfItem.Enabled := False;
        btnConfirmar.Click;
      End;
    End

    Else If (Sender = edtQtdVol) And edtQtdVol.Enabled Then
    Begin

      If Pos(edtQtdVol.Text, 'Q_V_') <= 0 Then
      Begin
        fMensagem('ATENÇÃO!','O campo Imprimir Quantidade ou Volume deve ser Q ou V.',['&O K']);
        Result := False;
      End;

    End

    Else If (Sender = edtDesLoc) And edtDesLoc.Enabled Then
    Begin

      If Pos(edtDesLoc.Text, 'D_L_') <= 0 Then
      Begin
        fMensagem('ATENÇÃO!','O campo Ordenar por Descrição ou Localização física deve ser D ou L.',['&O K']);
        Result := False;
      End;

    End

    Else If (Sender = edtEmbQV) And edtEmbQV.Enabled Then
    Begin

      If Pos(edtEmbQV.Text, 'Q_V_') <= 0 Then
      Begin
        fMensagem('ATENÇÃO!','O campo Imprimir Quantidade ou Volume das embalagens deve ser Q ou V.',['&O K']);
        Result := False;
      End;

    End

    Else If (Sender = edtDocEnd) And edtDocEnd.Enabled Then
    Begin

      If Pos(edtDocEnd.Text, 'D_E_R_') <= 0 Then
      Begin
        fMensagem('ATENÇÃO!','O campo Ordenar Documentos da Rota deve ser D, E ou R.',['&O K']);
        Result := False;
      End;

    End

    Else If (Sender = edtCliQV) And edtCliQV.Enabled Then
    Begin

      If Pos(edtQtdVol.Text, 'Q_V_') <= 0 Then
      Begin
        fMensagem('ATENÇÃO!','O campo Imprimir Quantidade ou Volume (Itens por Cliente) deve ser Q ou V.',['&O K']);
        Result := False;
      End;

    End

    Else If (Sender = edtCliOrd) And edtCliOrd.Enabled Then
    Begin

      If Pos(edtCliOrd.Text, 'DUF') <= 0 Then
      Begin
        fMensagem('ATENÇÃO!','O Campo "Ordenar por:" dever ser D, U ou F!',['&O K']);
        Result := False;
      End;

    End

  End;

  blnVerificaCkbImprimir := True;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmFatRomaneioImpr.btnConfirmarClick(Sender: TObject);
begin
  inherited;

  blnVerificaCkbImprimir := False;
  If Not fVerificaCampos Then
    Exit;

  If ckbImprimir.Checked Then
  Begin

    If (Not ckbProdutos.Checked)   And
       (Not ckbEmbalagens.Checked) And
       (Not ckbDocumentos.Checked) And
       (Not chkRotViagem.Checked)  And
       (Not ckbFormas.Checked)     And
       (Not ckbCarCar.Checked)    Then
    Begin
      fMensagem('', 'Selecione ao menos um item para impressão!', ['&Ok']);
      pSetFocus(ckbImprimir);
      Exit;
    End
    Else
    Begin
      blnImprimi := True;

      blnProdutos   := ckbProdutos.Checked;
      blnEmbalagens := ckbEmbalagens.Checked;
      blnDocumentos := ckbDocumentos.Checked;
      blnFormas     := ckbFormas.Checked;
      blnInfItem    := ckbInfItem.Checked;
      blnTotEspDoc  := ckbTotEspDoc.Checked;
      blnMosMar     := ckbMosMar.Checked;
      blnCarCar     := ckbCarCar.Checked;
      blnImpKm      := ckbImpKm.Checked;
    End;
  End
  Else
    blnImprimi := False;

  blnIteDoc  := ckbIteDoc.Checked;
  blnEndEnt  := ckbEndEnt.Checked;
  blnItemCli := ckbItensCli.Checked;
  blnImpVal  := chkImpVal.Checked;
  blnMenExp  := chkMenExp.Checked;

  If chkRotViagem.Checked Then
  Begin
    If Not blnIteDoc And Not blnEndEnt Then
    Begin
      fMensagem('', 'Selecione ao menos uma opção para impressão do Roteiro de Viagem!' + #10#13 +
                    ' - Itens por Documento ou ' + #10#13 +
                    ' - Itens por Cliente / Endereço de Entrega', ['&Ok']);
      pSetFocus(ckbIteDoc);
      Exit;
    End;
  End;

  If blnConfig Then
  Begin
    pSalvaConfig;
    blnGravar := True;
  End;
    
  Close;
end;

procedure TfrmFatRomaneioImpr.FormCreate(Sender: TObject);
begin
  inherited;

  blnConfig := False;
  blnPreviaRom := False;
  blnVerificaCkbImprimir := True;

end;

procedure TfrmFatRomaneioImpr.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_ESCAPE) Then
  Begin
    Close;
  End;
end;

procedure TfrmFatRomaneioImpr.pInicializaConfig;
  Var
    sltLista: TStringList;
    intIndice: Integer;
    intPosInf: Integer;
    strNomCam: String;
    strInfCam: String;
    cmpCampo : TObject;
Begin
  sltLista := TStringList.Create;
  sltLista.CommaText := strConfig;

  For intIndice := 0 To sltLista.Count -1 Do
  Begin
    intPosInf := Pos(':', sltLista[intIndice]);

    If intPosInf > 0 Then
    Begin
      strNomCam := LeftStr(sltLista[intIndice], Pred(intPosInf));
      strInfCam := RightStr(sltLista[intIndice], Length(sltLista[intIndice]) - intPosInf);

      cmpCampo := fFindComponentLike(strNomCam);

      If Assigned(cmpCampo) Then
      Begin
        If cmpCampo Is TEditFocus Then
          (cmpCampo As TEditFocus).Text := strInfCam

        Else If cmpCampo Is TCheckBox Then
          (cmpCampo As TCheckBox).Checked := SameText(strInfCam, 'T');
      End;
    End;
  End;

  FreeAndNil(sltLista);
End;

procedure TfrmFatRomaneioImpr.pSalvaConfig;
  Var
    sltLista: TStringList;
    intIndice: Integer;
Begin
  sltLista := TStringList.Create;
  
  For intIndice := 0 To Self.ComponentCount - 1 Do
  Begin
    If Self.Components[intIndice] Is TEditFocus Then
      sltLista.Add(fGetMenorNomeComp(Components[intIndice]) +':'+ TEditFocus(Self.Components[intIndice]).Text)

    Else If Self.Components[intIndice] Is TCheckBox Then
      sltLista.Add(fGetMenorNomeComp(Components[intIndice]) +':'+ IIF(TCheckBox(Self.Components[intIndice]).Checked, 'T', 'F'));
  End;

  strConfig := sltLista.CommaText;

  FreeAndNil(sltLista);
End;

procedure TfrmFatRomaneioImpr.FormShow(Sender: TObject);
begin
  inherited;

  If blnConfig Then
  Begin
    blnGravar := False;
    Caption := Caption + ' - Configuração';
    btnSair.Visible := True;
  End

  Else strConfig := fCfgSis(IIF(blnPreviaRom, 'PRVIPR', 'ROMIPR'));

  pInicializaConfig;

  chkImpVal.Enabled := ckbIteDoc.Checked;
  chkMenExp.Enabled := ckbEndEnt.Checked;

  If (Not fCfgSis('ROMPAR', varBoolean)) Then
  Begin
    ckbInfItem.Visible := False;
  End;

  If (FileExists(ExtractFilePath(Application.ExeName) + '\ROMANEIO_DEP_CRAVINHOS.fr3')) Then Begin
    chkImpVal.Visible := False;
    chkImpVal.Checked := False;
    chkMenExp.Visible := False;
    chkMenExp.Checked := False;
    ckbEndEnt.Top := chkImpVal.Top;
    GroupBox1.Height := GroupBox1.Height - chkImpVal.Height - chkMenExp.Height;
    Self.Height := Self.Height - chkImpVal.Height - chkMenExp.Height;
  End;
end;

procedure TfrmFatRomaneioImpr.ckbProdutosClick(Sender: TObject);
begin
  inherited;

  edtQtdVol.Enabled := ckbProdutos.Checked;
  clbQtdVol.Enabled := ckbProdutos.Checked;

  edtDesLoc.Enabled := ckbProdutos.Checked;
  clbDesLoc.Enabled := ckbProdutos.Checked;

end;

function TfrmFatRomaneioImpr.fFindComponentLike(strNome: String): TComponent;
  Var
    intIndex,
    intQtdComp: Integer;
begin
  intQtdComp := 0;
  Result := nil;
  For intIndex := 0 To Self.ComponentCount -1 Do
  Begin
    If SameText(strNome, LeftStr(Self.Components[intIndex].Name, Length(strNome))) Then
    Begin
      Result := Self.Components[intIndex];
      Inc(intQtdComp);
    End;
  End;

  If intQtdComp > 1 Then
    Result := Nil;
end;

function TfrmFatRomaneioImpr.fGetMenorNomeComp(eComponente: TComponent): String;
  Var
    intIndex: Integer;
begin
  Result := '';

  For intIndex := 4 To Length(eComponente.Name) Do
  Begin
    If fFindComponentLike(LeftStr(eComponente.Name, intIndex)) <> Nil Then
    Begin
      Result := LeftStr(eComponente.Name, intIndex);
      Exit;
    End;
  End;
end;

procedure TfrmFatRomaneioImpr.ckbDocumentosClick(Sender: TObject);
begin
  inherited;
  edtDocEnd.Enabled := ckbDocumentos.Checked;
  clbDocEnd.Enabled := ckbDocumentos.Checked;
end;

procedure TfrmFatRomaneioImpr.ckbEmbalagensClick(Sender: TObject);
begin
  inherited;

  edtEmbQV.Enabled := ckbEmbalagens.Checked;
  clbEmbQV.Enabled := ckbEmbalagens.Checked;

end;

procedure TfrmFatRomaneioImpr.ckbEndEntClick(Sender: TObject);
begin
  inherited;

  If ckbEndEnt.Checked Then Begin
    ckbIteDoc.Checked := False;
    chkImpVal.Checked := False;
    chkImpVal.Enabled := False;
  End;

  chkMenExp.Enabled := ckbEndEnt.Checked;
end;

procedure TfrmFatRomaneioImpr.ckbImprimirClick(Sender: TObject);
begin
  inherited;

  pnlDadRom.Enabled := ckbImprimir.Checked;

  If Not ckbImprimir.Checked Then
  Begin
    ckbProdutos.Checked   := False;
    ckbEmbalagens.Checked := False;
    ckbDocumentos.Checked := False;
    ckbTotEspDoc.Checked  := False;
    ckbFormas.Checked     := False;
    ckbInfItem.Checked    := False;
    ckbCarCar.Checked     := False;
    ckbImpKm.Checked      := False;
  End;
end;

procedure TfrmFatRomaneioImpr.ckbIteDocClick(Sender: TObject);
begin
  inherited;
  chkImpVal.Enabled := ckbIteDoc.Checked;

  If ckbIteDoc.Checked Then
  begin
    ckbEndEnt.Checked := False;
    chkMenExp.Checked := False;
  end;

  chkMenExp.Enabled := ckbEndEnt.Checked;
end;

procedure TfrmFatRomaneioImpr.ckbItensCliClick(Sender: TObject);
begin
  inherited;

  edtCliQV.Enabled := ckbItensCli.Checked;
  clbCliQV.Enabled := ckbItensCli.Checked;

  edtCliOrd.Enabled := ckbItensCli.Checked;
  clbCliOrd.Enabled := ckbItensCli.Checked;
  clbCliOrd2.Enabled := ckbItensCli.Checked;

end;

end.

