unit untConsultaServicosAutocenterTecSeat;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, untSubjectIntf, untTecladoSEAT;

type
  TfrmConsultaServicosAutocenterTecSeat = class(TfrmPai, IObserver_)
    lblInfo: TLabel;
    procedure btnSairClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    objTecladoSEAT: TTecladoSEAT;

    procedure pUpdate(const Parameters: Array of String; AVisualizarProgresso: Boolean = True);
    function fSolicitaLiberacao: Boolean;
    procedure fGravaAvaliacao;
  public
    { Public declarations }
    strNumDoc: String;
    strEspDoc: String;
    strEmpDoc: String;
  end;

implementation

uses
  untLiberacao, untFuncoesSimples;

{$R *.dfm}

{ TfrmConsultaServicosAutocenterTecSeat }

procedure TfrmConsultaServicosAutocenterTecSeat.btnSairClick(Sender: TObject);
begin
  inherited;
  If fSolicitaLiberacao Then
    ModalResult := mrOk;
end;

procedure TfrmConsultaServicosAutocenterTecSeat.fGravaAvaliacao;
begin
  objTecladoSEAT.pSetNumDoc(strNumDoc);
  objTecladoSEAT.pSetEspDoc(strEspDoc);
  objTecladoSEAT.pSetEmpDoc(strEmpDoc);
  objTecladoSEAT.fGravarAvaliacao;
end;

procedure TfrmConsultaServicosAutocenterTecSeat.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  If ModalResult = mrOk Then
    fGravaAvaliacao;

  If Assigned(objTecladoSEAT) Then
    FreeAndNil(objTecladoSEAT);
end;

procedure TfrmConsultaServicosAutocenterTecSeat.FormCreate(Sender: TObject);
begin
  inherited;
  blnFecharComEscape := False;
  objTecladoSEAT := TTecladoSEAT.Create;
end;

procedure TfrmConsultaServicosAutocenterTecSeat.FormShow(Sender: TObject);
begin
  inherited;
  objTecladoSEAT.pAddObserver(Self);
  objTecladoSEAT.pIniciarAvaliacao;
end;

function TfrmConsultaServicosAutocenterTecSeat.fSolicitaLiberacao: Boolean;
  Var
    objLiberacao: TLiberacao;
begin
  Result := True;

  If Not (objTecladoSEAT.Status In [stDefault, stAvaliando]) Then
    Exit;

  objTecladoSEAT.pDesligarMonitoramento(True);

  objLiberacao := TLiberacao.Create;
  Try
    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('Permitir finalização do serviço no Acompanhamento de Serviços sem receber a avaliação do teclado de satisfação da Seat');
    objLiberacao.objMsgLibera.pAddTexto('Documento: '+ strNumDoc +'-'+ strEspDoc +'-'+ strEmpDoc);
    objLiberacao.strDirAce := 'TECCEN';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;

    Result := objLiberacao.fLibera;
  Finally
    FreeAndNil(objLiberacao);
  End;
end;

procedure TfrmConsultaServicosAutocenterTecSeat.pUpdate(const Parameters: Array of String; AVisualizarProgresso: Boolean = True);
  const
    IDX_STATUS = 0;
    IDX_COR    = 1;
begin
  inherited;
  If Parameters[IDX_STATUS].IsEmpty Then
    Exit;

  lblInfo.Caption    := Parameters[IDX_STATUS];
  lblInfo.Font.Color := IIF(Parameters[IDX_COR].Equals('VERMELHO'), clRed, clGreen);

  If Parameters[IDX_COR].Equals('VERDE') Then
    ModalResult := mrOk;
end;

end.
