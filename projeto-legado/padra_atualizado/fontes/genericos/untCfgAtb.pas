unit untCfgAtb;

interface

uses
  Windows, Classes, Controls, untPai, Menus, StdCtrls, Buttons, ExtCtrls, DBCtrls,
  Uni, EditFocus, MemoFocus, AppEvnts, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade;

type
  TfrmCfgAtb = class(TfrmPai)
    pnlCentral: TPanel;
    pnlRodape: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edtDesCam: TMemoFocus;
    edtNomFor: TEditFocus;
    edtNomCam: TEditFocus;
    btnGravar: TBitBtnLocked;
    procedure FormShow(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure edtDesCamKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    qryGenAtb: TUniQuery;

  public
    { Public declarations }
    strNomCam : String;
    strNomFor : String;
    blnCfgAtb : Boolean;

  end;


implementation

uses Forms, untModuloCfgAtb, untfuncoesSimples, Data.DB;

{$R *.dfm}

procedure TfrmCfgAtb.FormShow(Sender: TObject);
  Var
   strSQL : String;

begin
  inherited;

  {*******************************************}
  {* SUBSTITUI PQ SEMPRE PEGAVA O ULTIMO     *}
  {* NAO TINHA WHERE NA QUERY                *}
  {****************************************AC*}
  //fAbrirTabela( frmModuloCfgAtb.qryCfgAtb );
  With frmModuloCfgAtb.qryCfgAtb Do
  Begin
    Close;
    ParamByName('NOMFOR').AsString := strNomFor;
    ParamByName('NOMCAM').AsString := strNomCam;
    Open;
  End;


  edtNomFor.Text := strNomFor;
  edtNomCam.Text := strNomCam;

  //*************************************************//
  // LOCALIZA A DESCRICAO REFERENTE AO CAMPO E FORM. //
  // DE CONFIGURACAO                                 //
  //**********************************************ED*//
  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CFGATB ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  ATB_NOMCAM = :NOMCAM AND  ';
  strSQL := strSQL + '  ATB_NOMFOR = :NOMFOR ';
  With qryGenAtb Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('NOMCAM').AsString := strNomCam;
    ParamByName('NOMFOR').AsString := strNomFor;
    Open;
  End;

  //*************************************************//
  // VERIFICA SE JA POSSUI CONFIGURACAO.             //
  // - SE NAO ENCONTRAR CONFIGURACAO ENTAO VERIFICA, //
  //   SE ESTA NO MODO DE CONFIGURACAO               //
  //**********************************************ED*//
  If qryGenAtb.IsEmpty Then
  Begin

    If blnCfgAtb Then
    Begin
      pnlCentral.Enabled := True;
      btnGravar.Enabled  := True;
    End
    Else
    Begin
      pnlCentral.Enabled := False;
      edtDesCam.Enabled  := False;
      btnGravar.Enabled  := False;
    End;

  End
  Else
  Begin

    edtDesCam.Text := qryGenAtb.FieldByName('ATB_DESCAM').AsString;
    edtNomFor.Text := qryGenAtb.FieldByName('ATB_NOMFOR').AsString;
    edtNomCam.Text := qryGenAtb.FieldByName('ATB_NOMCAM').AsString;

    If blnCfgAtb Then
    Begin
      pnlCentral.Enabled := True;
      btnGravar.Enabled  := True;
    End
    Else
    Begin
      pnlCentral.Enabled := False;
      edtDesCam.Enabled  := False;
      btnGravar.Enabled  := False;
    End;

  End;
  pSetFocus(btnSair);
end;

procedure TfrmCfgAtb.btnGravarClick(Sender: TObject);
begin
  inherited;

  If qryGenAtb.IsEmpty Then
  Begin

    With frmModuloCfgAtb.qryCfgAtb Do
    Begin
      Append;
      FieldByName('ATB_DESCAM').AsString := edtDesCam.Text;
      FieldByName('ATB_NOMFOR').AsString := edtNomFor.Text;
      FieldByName('ATB_NOMCAM').AsString := edtNomCam.Text;
      FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CFGATB', VS_strCodEmp);
      Post;
    End;

  End
  Else
  Begin

    With frmModuloCfgAtb.qryCfgAtb Do
    Begin
      Edit;
      FieldByName('ATB_DESCAM').AsString := edtDesCam.Text;
      Post;
    End;

  End;

  pSetFocus(btnSair);

end;

procedure TfrmCfgAtb.edtDesCamKeyPress(Sender: TObject; var Key: Char);
//  Var
//    strKey : String;

begin
  inherited;

  //strKey := UpCase(Key);
  //Key    := strKey[1];

end;

procedure TfrmCfgAtb.FormCreate(Sender: TObject);
begin
  inherited;

  qryGenAtb := fCriaQuery(Self);

end;

end.

